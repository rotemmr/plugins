$zip = "$env:TEMP\BakkesModSetup.zip"
$out = "$env:TEMP\BakkesModSetup"

if( Test-Path "$env:APPDATA\bakkesmod\bakkesmod\version.txt") {
    Write-Host "BM already exists" -ForegroundColor Yellow
} else {
Write-Host "installing BakkesMod..." -ForegroundColor Cyan
Invoke-WebRequest "https://github.com/bakkesmodorg/BakkesModInjectorCpp/releases/latest/download/BakkesModSetup.zip" -OutFile $zip -UseBasicParsing
Expand-Archive $zip -DestinationPath $out -Force
Start-Process "$out\BakkesModSetup.exe" -ArgumentList "/silent" -Wait
}

Write-Host "installing AlphaConsole..." -ForegroundColor Cyan
Start-Process "bakkesmod://install/108"

Write-Host "setting default configs (rotmvrr's cfg)" -ForegroundColor Cyan
Copy-Item -Path "$PSScriptRoot\configs\bakkesmod\*" -Destination "$env:APPDATA\bakkesmod\bakkesmod\" -Recurse -Force

Write-Host "* READY TO LAUNCH *" -ForegroundColor Green
