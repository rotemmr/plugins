$zip = "$env:TEMP\BakkesModSetup.zip"
$out = "$env:TEMP\BakkesModSetup"

Write-Host ""
Write-Host "  >> BakkesMod Setup and Configuration - rotmvrr "
Write-Host "========================================"
Write-Host ""


if( Test-Path "$env:APPDATA\bakkesmod\bakkesmod\version.txt") {
    Write-Host "BM already exists" -ForegroundColor Yellow
} else {
Write-Host "installing BakkesMod..." -ForegroundColor Cyan
Invoke-WebRequest "https://github.com/bakkesmodorg/BakkesModInjectorCpp/releases/latest/download/BakkesModSetup.zip" -OutFile $zip -UseBasicParsing
Expand-Archive $zip -DestinationPath $out -Force
Start-Process "$out\BakkesModSetup.exe" -ArgumentList "/silent" -Wait
}

Write-Host ""
Write-Host ""
Write-Host ""
Write-Host "installing AlphaConsole..." -ForegroundColor Cyan
Start-Process "bakkesmod://install/108"

Write-Host ""
Write-Host ""
Write-Host "setting default configs (rotmvrr's cfg)" -ForegroundColor Cyan
Copy-Item -Path "$PSScriptRoot\configs\bakkesmod\cfg\_Presets.json" -Destination "$env:APPDATA\bakkesmod\bakkesmod\data\acplugin\Presets" -Recurse -Force

Write-Host ""
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host "* READY TO LAUNCH *" -ForegroundColor Green
Read-Host "Press enter to exit the installation"