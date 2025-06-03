@echo off
REM --------------------------------------------------------
REM   Export-WindowsSystemLogs.bat
REM   Gathers Event Logs (System, Application, Security, etc.)
REM   and basic SystemInfo into text files on your Desktop.
REM --------------------------------------------------------

REM 1) Define output folder on Desktop
set "LogDir=%USERPROFILE%\Desktop\SystemLogs"
if not exist "%LogDir%" (
    mkdir "%LogDir%"
)

echo.
echo ================================================
echo Exporting Windows Event Logs to %LogDir%
echo (This may take a few minutes…)
echo ================================================

REM 2) Export the System event log (all entries)
echo.
echo [*] Exporting “System” log…
wevtutil qe System /f:text > "%LogDir%\SystemLog.txt"
if %errorlevel% neq 0 (
    echo    [!] Failed exporting System log (try running as Administrator).
) else (
    echo    [OK] SystemLog.txt created.
)

REM 3) Export the Application event log (all entries)
echo.
echo [*] Exporting “Application” log…
wevtutil qe Application /f:text > "%LogDir%\ApplicationLog.txt"
if %errorlevel% neq 0 (
    echo    [!] Failed exporting Application log.
) else (
    echo    [OK] ApplicationLog.txt created.
)

REM 4) Export the Security event log (requires Admin rights)
echo.
echo [*] Exporting “Security” log…
wevtutil qe Security /f:text > "%LogDir%\SecurityLog.txt"
if %errorlevel% neq 0 (
    echo    [!] Failed exporting Security log (run as Administrator).
) else (
    echo    [OK] SecurityLog.txt created.
)

REM 5) Export the Setup event log (if present)
echo.
echo [*] Exporting “Setup” log…
wevtutil qe Setup /f:text > "%LogDir%\SetupLog.txt"
if %errorlevel% neq 0 (
    echo    [!] Setup log not found or failed.
) else (
    echo    [OK] SetupLog.txt created.
)

REM 6) Export ForwardedEvents (if configured)
echo.
echo [*] Exporting “ForwardedEvents” log (if present)…
wevtutil qe ForwardedEvents /f:text > "%LogDir%\ForwardedEventsLog.txt"
if %errorlevel% neq 0 (
    echo    [!] ForwardedEvents log not found or/or failed.
) else (
    echo    [OK] ForwardedEventsLog.txt created.
)

REM 7) Export basic system information (CPU, RAM, OS build, etc.)
echo.
echo [*] Gathering “systeminfo”…
systeminfo > "%LogDir%\SystemInfo.txt"
if %errorlevel% neq 0 (
    echo    [!] Failed running systeminfo.
) else (
    echo    [OK] SystemInfo.txt created.
)

echo.
echo ================================================
echo All exports complete.
echo You can now browse the .txt files in:
echo    %LogDir%
echo ================================================
pause > nul
