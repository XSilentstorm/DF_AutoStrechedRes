@echo off
title Delta Force Stretch Installer
color 0B

echo ========================================================
echo   DELTA FORCE AUTOMATED STRETCH RATIO INSTALLER
echo ========================================================
echo.

:: Check administrator privileges
fltmc >nul 2>&1
if errorlevel 1 (
    echo [System] Requesting Administrator privileges...
    powershell -NoProfile -ExecutionPolicy Bypass -Command ^
      "Start-Process -FilePath $env:ComSpec -ArgumentList ('/d /c ""%~f0""') -Verb RunAs"
    exit /b
)

:: 2. Return to the installer directory
cd /d "%~dp0"

:: 3. Simple verification check
if not exist "QRes.exe" (
    echo [ERROR] QRes.exe was not found in this folder!
    echo Please make sure QRes.exe and this Install.bat are in the same folder.
    echo.
    pause
    exit
)


echo [+] Preparing target directory...
set "TargetDir=%ProgramFiles%\DF_StretchMonitor"

if exist "%TargetDir%" (
    echo [*] Previous installation detected! Upgrading files...
    del /F /Q "%TargetDir%\*.*" >nul 2>&1
) else (
    mkdir "%TargetDir%"
    if errorlevel 1 (
        echo [ERROR] Failed to create target directory.
        echo Target: "%TargetDir%"
        pause
        exit /b 1
    )
)

echo [+] Deploying QRes engine...
copy /Y "QRes.exe" "%TargetDir%\QRes.exe" >nul
if errorlevel 1 (
    echo [ERROR] Failed to copy QRes.exe.
    echo Destination: "%TargetDir%\QRes.exe"
    pause
    exit /b 1
)

echo [+] Creating robust plug-and-play monitor profile...
set "OutFile=%TargetDir%\Monitor.ps1"

:: Initialize/overwrite the file cleanly line by line with proper CMD character escaping
echo $qres = Join-Path $PSScriptRoot "QRes.exe" > "%OutFile%"
echo $gameRunning = $false >> "%OutFile%"
echo. >> "%OutFile%"
echo Write-Host "=========================================" -ForegroundColor Cyan >> "%OutFile%"
echo Write-Host "    DYNAMIC STRETCH RESOLUTION MONITOR    " -ForegroundColor Cyan >> "%OutFile%"
echo Write-Host "=========================================" -ForegroundColor Cyan >> "%OutFile%"
echo Write-Host "[*] Querying hardware configuration..." -ForegroundColor Gray >> "%OutFile%"
echo. >> "%OutFile%"
echo Add-Type -AssemblyName System.Windows.Forms >> "%OutFile%"
echo $screenObject = [System.Windows.Forms.Screen]::PrimaryScreen >> "%OutFile%"
echo $w = $screenObject.Bounds.Width >> "%OutFile%"
echo $h = $screenObject.Bounds.Height >> "%OutFile%"
echo. >> "%OutFile%"
echo $r = ^(Get-CimInstance -ClassName Win32_VideoController ^| Select-Object -First 1^).CurrentRefreshRate >> "%OutFile%"
echo if ^(-not $r -or $r -lt 60^) { $r = 360 } >> "%OutFile%"
echo if ^($r -eq 359^) { $r = 360 } >> "%OutFile%"
echo. >> "%OutFile%"
echo $rawModes = ^& $qres /L >> "%OutFile%"
echo $supported43Modes = $rawModes ^| Where-Object { $_ -match "(\d+)x(\d+), 32 bits" } ^| ForEach-Object { >> "%OutFile%"
echo     if ^($_ -match "(?<width>\d+)x(?<height>\d+)"^) { >> "%OutFile%"
echo         $wMode = [int]$Matches['width'] >> "%OutFile%"
echo         $hMode = [int]$Matches['height'] >> "%OutFile%"
echo         if ^([Math]::Round^($wMode / $hMode, 2) -eq 1.33^) { >> "%OutFile%"
echo             [PSCustomObject]@{ Width = $wMode; Height = $hMode } >> "%OutFile%"
echo         } >> "%OutFile%"
echo     } >> "%OutFile%"
echo } ^| Sort-Object Width -Descending ^| Select-Object -First 1 >> "%OutFile%"
echo. >> "%OutFile%"
echo if ^($supported43Modes^) { >> "%OutFile%"
echo     $targetW = $supported43Modes.Width >> "%OutFile%"
echo     $targetH = $supported43Modes.Height >> "%OutFile%"
echo } else { >> "%OutFile%"
echo     $targetW = 1024 >> "%OutFile%"
echo     $targetH = 768 >> "%OutFile%"
echo } >> "%OutFile%"
echo. >> "%OutFile%"
echo Write-Host "[+] Native Panel Detected: ${w}x${h} @ ${r}Hz" -ForegroundColor Green >> "%OutFile%"
echo Write-Host "[+] Detected Sharpest 4:3 Preset: ${targetW}x${targetH}" -ForegroundColor Green >> "%OutFile%"
echo Write-Host "-----------------------------------------" -ForegroundColor Cyan >> "%OutFile%"
echo Write-Host "Checking for Delta Force startup..." -ForegroundColor Gray >> "%OutFile%"
echo. >> "%OutFile%"
echo while ^($true^) { >> "%OutFile%"
echo     $process = Get-Process -Name "DeltaForceClient-Win64-Shipping" -ErrorAction SilentlyContinue ^| Where-Object { $_.MainWindowTitle -ne "" } >> "%OutFile%"
echo     if ^($process -and -not $gameRunning^) { >> "%OutFile%"
echo         Write-Host "[+] Delta Force Active! Applying 4:3 Stretch: ${targetW}x${targetH}" -ForegroundColor Green >> "%OutFile%"
echo         ^& $qres /x:$targetW /y:$targetH >> "%OutFile%"
echo         $gameRunning = $true >> "%OutFile%"
echo     } >> "%OutFile%"
echo     elseif ^(-not $process -and $gameRunning^) { >> "%OutFile%"
echo         Write-Host "[-] Delta Force Closed! Reverting to Native: ${w}x${h} @ ${r}Hz" -ForegroundColor Yellow >> "%OutFile%"
echo         ^& $qres /x:$w /y:$h /r:$r >> "%OutFile%"
echo         $gameRunning = $false >> "%OutFile%"
echo     } >> "%OutFile%"
echo     Start-Sleep -Seconds 2 >> "%OutFile%"
echo } >> "%OutFile%"

echo [+] Bundling launch accelerator (Play.bat)...
set "PlayFile=%TargetDir%\Play.bat"
echo @echo off > "%PlayFile%"
echo title Delta Force Automation Monitor >> "%PlayFile%"
echo cd /d "%TargetDir%" >> "%PlayFile%"
echo powershell -NoProfile -ExecutionPolicy Bypass -File "Monitor.ps1" >> "%PlayFile%"

echo [+] Generating desktop shortcut...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$Desktop = [Environment]::GetFolderPath('Desktop'); $ShortcutPath = Join-Path $Desktop 'Play Delta Force 4-3.lnk'; $WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut($ShortcutPath); $Shortcut.TargetPath = '%TargetDir%\Play.bat'; $Shortcut.WorkingDirectory = '%TargetDir%'; $Shortcut.IconLocation = 'imageres.dll,141'; $Shortcut.Save(); if (-not (Test-Path -LiteralPath $ShortcutPath)) { throw 'Shortcut was not created.' }"
if errorlevel 1 (
    echo [ERROR] Failed to create the desktop shortcut.
    pause
    exit /b 1
)

echo.
echo ========================================================
echo   INSTALLATION COMPLETED SUCCESSFULLY!
echo ========================================================
echo [+] Shared launcher generated. Debug console visibility maintained.
echo.
echo Press any button to exit...
pause >nul
exit
