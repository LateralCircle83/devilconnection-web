TYRANO.kag.dc = {
  ...TYRANO.kag.dc,
  loopTimers: {},
  mediaSources: {},
  setUpMediaSourceForLoop: function (video, name) {
    const [primaryVideo, primaryAudio, secondaryVideo, secondaryAudio] =
      this.getLoopBuffers(name)
    const primaryVideoBuffer = primaryVideo
    const primaryAudioBuffer = primaryAudio
    const secondaryVideoBuffer = secondaryVideo || primaryVideo
    const secondaryAudioBuffer = secondaryAudio || primaryAudio

    const mediaSource = new MediaSource()
    mediaSource.__dcLoopEnded = false
    const videoType = 'video/mp4; codecs="avc1.640028"'
    const audioType = 'audio/mpeg'

    mediaSource.addEventListener('sourceopen', function () {
      const videoBuffer = mediaSource.addSourceBuffer(videoType)
      videoBuffer.mode = 'sequence'
      const audioBuffer = primaryAudioBuffer
        ? mediaSource.addSourceBuffer(audioType)
        : null
      audioBuffer && (audioBuffer.mode = 'sequence')

      let loopVideoDuration,
        loopAudioDuration,
        videoLoaded = false,
        audioLoaded = false

      const pendingBufferAppends = new Map()
      const waitingBuffers = new Set()
      const waitForBufferUpdate = buffer => {
        if (waitingBuffers.has(buffer)) return
        waitingBuffers.add(buffer)
        buffer.addEventListener(
          'updateend',
          function flushPendingAppend() {
            waitingBuffers.delete(buffer)
            const append = pendingBufferAppends.get(buffer)
            pendingBufferAppends.delete(buffer)
            append && appendWhenBufferIdle(buffer, append)
          },
          { once: true }
        )
      }

      const appendWhenBufferIdle = (buffer, append) => {
        if (!buffer || mediaSource.__dcLoopEnded || mediaSource.readyState !== 'open') return
        if (buffer.updating) {
          pendingBufferAppends.set(buffer, append)
          waitForBufferUpdate(buffer)
          return
        }
        try {
          append()
        } catch (e) {
          if (e && e.name === 'InvalidStateError' && buffer.updating) {
            pendingBufferAppends.set(buffer, append)
            waitForBufferUpdate(buffer)
            return
          }
          console.warn('title_loop: SourceBuffer append skipped', e)
        }
      }

      const makeBufferGaplessWith = (gapless, buffer) => {
        const offset =
          buffer.buffered.length > 0
            ? buffer.buffered.end(buffer.buffered.length - 1)
            : 0

        buffer.appendWindowStart = offset
        buffer.appendWindowEnd = offset + gapless.audioDuration
        buffer.timestampOffset = offset - gapless.frontPaddingDuration
      }

      const appendVideoLoopBuffer = () => {
        appendWhenBufferIdle(videoBuffer, () => {
          videoBuffer.onupdateend ||
            (videoBuffer.onupdateend = function (e) {
              const buffered = e.target.buffered
              this.timestampOffset = buffered.end(buffered.length - 1)
            })
          videoBuffer.appendBuffer(secondaryVideoBuffer)
        })
      }

      const appendAudioLoopBuffer = () => {
        appendWhenBufferIdle(audioBuffer, () => {
          const gapless = llama.parseGaplessData(secondaryAudioBuffer)
          makeBufferGaplessWith(gapless, audioBuffer)
          audioBuffer.appendBuffer(secondaryAudioBuffer)
        })
      }

      const play = function () {
        video.play()
        TYRANO.kag.dc.loopTimers[`${name}_v`] = setInterval(
          appendVideoLoopBuffer,
          Math.floor(loopVideoDuration * 1000)
        )
        audioBuffer &&
          (TYRANO.kag.dc.loopTimers[`${name}_a`] = setInterval(
            appendAudioLoopBuffer,
            Math.floor(loopAudioDuration * 1000)
          ))
      }

      videoBuffer.onupdateend = function (e) {
        let mainVideoDuration

        videoBuffer.onupdateend = function (e) {
          const buffered = e.target.buffered
          videoBuffer.timestampOffset = buffered.end(buffered.length - 1)
          loopVideoDuration = videoBuffer.timestampOffset - mainVideoDuration
          videoLoaded = true
          if (audioLoaded || !audioBuffer) play()
          videoBuffer.onupdateend = null
        }

        const buffered = e.target.buffered
        mainVideoDuration = videoBuffer.timestampOffset = buffered.end(
          buffered.length - 1
        )
        videoBuffer.appendBuffer(secondaryVideoBuffer)
      }
      videoBuffer.appendBuffer(primaryVideoBuffer)

      if (audioBuffer) {
        audioBuffer.onupdateend = function (e) {
          audioBuffer.onupdateend = function (e) {
            audioLoaded = true
            videoLoaded && play()
            audioBuffer.onupdateend = null
          }
          const gapless = llama.parseGaplessData(secondaryAudioBuffer)
          loopAudioDuration = gapless.audioDuration
          makeBufferGaplessWith(gapless, audioBuffer)
          audioBuffer.appendBuffer(secondaryAudioBuffer)
        }
        const gapless = llama.parseGaplessData(primaryAudioBuffer)
        makeBufferGaplessWith(gapless, audioBuffer)
        audioBuffer.appendBuffer(primaryAudioBuffer)
      }
    })
    this.mediaSources[name] = mediaSource
    return mediaSource
  },
  tearDownMediaSourceForLoop: function (name) {
    clearInterval(TYRANO.kag.dc.loopTimers[`${name}_v`])
    clearInterval(TYRANO.kag.dc.loopTimers[`${name}_a`])
    delete TYRANO.kag.dc.loopTimers[`${name}_v`]
    delete TYRANO.kag.dc.loopTimers[`${name}_a`]

    const mediaSource = this.mediaSources[name]
    if (!mediaSource) return
    mediaSource.__dcLoopEnded = true

    const endStream = () => {
      const isUpdating = Array.from(mediaSource.sourceBuffers).some(
        sb => sb.updating
      )

      if (isUpdating) {
        setTimeout(endStream, 10)
        return
      }

      if (mediaSource.readyState === 'open') {
        mediaSource.endOfStream()
      }
      delete this.mediaSources[name]
    }

    endStream()
  },
}

TYRANO.kag.ftag.master_tag.title_loop = {
  kag: TYRANO.kag,
  vital: [],
  pm: {},
  start: function (pm) {
    const that = this

    const tagVol = 50
    const sfMovVol = that.kag.variable.sf._system_config_movie_volume
    const movieVolume = !isNaN(sfMovVol)
      ? parseFloat(tagVol / 100) * parseFloat(parseInt(sfMovVol) / 100)
      : parseFloat(tagVol / 100)
    const video = $('<video>')
      .addClass('title_movie')
      .css({
        position: 'absolute',
        top: '0px',
        left: '0px',
        width: '100%',
        height: '100%',
        'z-index': 0,
      })
      .removeAttr('autoplay')
      .attr('volume', tagVol)
      .each((_, v) => {
        v.volume = movieVolume
      })[0]

    const mediaSource = this.kag.dc.setUpMediaSourceForLoop(video, 'title')

    video.src = URL.createObjectURL(mediaSource)
    video.playsInline = '1'

    this.kag.layer.getLayer('fix').append(video)

    this.kag.ftag.nextOrder()
  },
}

TYRANO.kag.ftag.master_tag.free_title_loop = {
  kag: TYRANO.kag,
  vital: [],
  pm: { time: 0 },
  start: function ({ time }) {
    time = Number(time)
    const movie = $('.title_movie')[0]
    if (!movie) {
      this.kag.ftag.nextOrder()
      return
    }
    const removeMovie = () => {
      const url = movie.src
      $(movie).remove()
      this.kag.dc.tearDownMediaSourceForLoop('title')
      URL.revokeObjectURL(url)
    }
    if (time > 0) {
      const interval = 10
      const fadeOutDelta = movie.volume / Math.ceil(time / interval)
      const fadeOutTimer = setInterval(function () {
        movie.volume = Math.max(movie.volume - fadeOutDelta, 0)
        if (movie.volume === 0) {
          removeMovie()
          clearInterval(fadeOutTimer)
        }
      }, 10)
      $(movie).fadeOut(time)
    } else {
      removeMovie()
    }

    this.kag.ftag.nextOrder()
  },
}
;(function () {
  // TYRANO.kag.menu.loadGameData の最後に、media_sourceを解放する
  const lgd = TYRANO.kag.menu.loadGameData
  TYRANO.kag.menu.loadGameData = function (data, options) {
    lgd.call(this, data, options)
    if (!this.kag.tmp.sleep_game) {
      // 独自ロード演出のため1000ms待つ
      setTimeout(() => {
        TYRANO.kag.dc.tearDownMediaSourceForLoop('title')
      }, 1000)
    }
  }
})()
