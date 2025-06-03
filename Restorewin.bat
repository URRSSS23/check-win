@echo off
REM ----------------------------------------------
REM Repair-Windows.bat
REM Runs DISM and SFC to repair Windows system files
REM ----------------------------------------------

echo ==============================================
echo 1) Running DISM: RestoreHealth (default source)
echo ==============================================
DISM.exe /Online /Cleanup-Image /RestoreHealth
if %errorlevel% neq 0 (
    echo.
    echo [ERROR] DISM (default RestoreHealth) failed with code %errorlevel%.
    echo Continuing to next step...
    echo.
) else (
    echo.
    echo [OK] Default DISM RestoreHealth completed successfully.
    echo.
)

echo ==============================================
echo 2) Running DISM: RestoreHealth (with custom source)
echo ==============================================
DISM.exe /Online /Cleanup-Image /RestoreHealth /Source:C:\RepairSource\Windows /LimitAccess
if %errorlevel% neq 0 (
    echo.
    echo [ERROR] DISM (RestoreHealth w/ custom source) failed with code %errorlevel%.
    echo Continuing to next step...
    echo.
) else (
    echo.
    echo [OK] DISM RestoreHealth (custom source) completed successfully.
    echo.
)

echo ==============================================
echo 3) Running System File Checker (SFC)
echo ==============================================
sfc /scannow
if %errorlevel% neq 0 (
    echo.
    echo [ERROR] sfc /scannow encountered issues. Review the log for details.
    echo.
) else (
    echo.
    echo [OK] sfc /scannow completed successfully.
    echo.
)

echo ==============================================
echo All steps finished. Press any key to exit.
echo ==============================================
pause >nul
