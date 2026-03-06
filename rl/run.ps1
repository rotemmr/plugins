$zip = "$env:TEMP\BakkesModSetup.zip"
$out = "$env:TEMP\BakkesModSetup"

Write-Host ""
Write-Host "  >> BakkesMod Setup and Configuration - rotmvrr "
Write-Host ""
Write-Host "====================================================="

Write-Host ""
Write-Host ""
Write-Host ""
# Python
if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    $consent = Read-Host "Python is needed for this setup to be installed. Continue? (Y/N)"
    if ($consent.ToLower() -eq "y") {
        Write-Host "installing Python..." -ForegroundColor Cyan
        Invoke-WebRequest "https://www.python.org/ftp/python/3.12.6/python-3.12.6-amd64.exe" -OutFile "$env:TEMP\python-3.12.6-amd64.exe" -UseBasicParsing
        Start-Process "$env:TEMP\python-3.12.6-amd64.exe" -ArgumentList "/silent InstallAllUsers=1 PrependPath=1" -Wait
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
        Write-Host "Python installed." -ForegroundColor Green
    } else {    
        Write-Host "setup cancelled." -ForegroundColor Red
        exit
    }
} else {
    Write-Host "Python already exists, skipping installation" -ForegroundColor Yellow
}



# BakkesMod
if( Test-Path "$env:APPDATA\bakkesmod\bakkesmod\version.txt") {
    Write-Host "BM already exists, skipping installation" -ForegroundColor Yellow

} else {
    Write-Host ""
    Write-Host "installing BakkesMod..." -ForegroundColor Cyan
    Invoke-WebRequest "https://github.com/bakkesmodorg/BakkesModInjectorCpp/releases/latest/download/BakkesModSetup.zip" -OutFile $zip -UseBasicParsing
    Expand-Archive $zip -DestinationPath $out -Force
    Start-Process "$out\BakkesModSetup.exe" -ArgumentList "/silent" -Wait
}



# AlphaConsole
if (Test-Path "$env:APPDATA\bakkesmod\bakkesmod\plugins\ACPlugin.dll") {
    Write-Host "AlphaConsole already exists, skipping installation" -ForegroundColor Yellow
} else {
    Write-Host ""
    Write-Host "installing AlphaConsole..." -ForegroundColor Cyan
    Start-Process "bakkesmod://install/108"
}

Write-Host ""
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host ""

#Configs
Write-Host "setting default configs (rotmvrr's cfg)" -ForegroundColor Cyan
python "$PSScriptRoot\py\blend_presets.py"

Write-Host ""
Write-Host ""

Write-Host "* READY TO LAUNCH *" -ForegroundColor Green
Write-Host ""
Read-Host "Press enter to exit the installation"

