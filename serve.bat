@echo off
cd /d "%~dp0"
echo Starting DevilConnection server at http://localhost:3000
echo Press Ctrl+C to stop.
echo.
npx -y http-server . -p 3000 -c-1
pause
