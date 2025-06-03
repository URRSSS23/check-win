@echo off
REM ===========================================
REM Batch script to run DISM and SFC scans
REM ===========================================

echo.
echo *******************************************
echo *    Starting DISM: /RestoreHealth (1)    *
echo *******************************************
echo.
DISM.exe /Online /Cleanup-Image /RestoreHealth
echo.
echo *******************************************
echo *  Starting DISM: /RestoreHealth (2) w/Source *
echo *******************************************
echo.
DISM.exe /Online /Cleanup-Image /RestoreHealth /Source:C:\RepairSource\Windows /LimitAccess
echo.
echo *******************************************
echo *        Starting System File Check        *
echo *******************************************
echo.
sfc /scannow
echo.

echo ===========================================
echo All operations complete.
echo ===========================================
pause
