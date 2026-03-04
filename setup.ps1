$zip = "$env:TEMP\BakkesModSetup.zip"
$out = "$env:TEMP\BakkesModSetup"

Write-Host "Downloading BakkesMod..." -ForegroundColor Cyan
Invoke-WebRequest "https://github.com/bakkesmodorg/BakkesModInjectorCpp/releases/latest/download/BakkesModSetup.zip" -OutFile $zip -UseBasicParsing
Expand-Archive $zip -DestinationPath $out -Force
Start-Process "$out\BakkesModSetup.exe" -Wait

Write-Host "Restoring configs..." -ForegroundColor Cyan
Copy-Item -Path "$PSScriptRoot\configs\bakkesmod\*" -Destination "$env:APPDATA\bakkesmod\bakkesmod\" -Recurse -Force

Write-Host "Done! Launch BakkesMod then start Rocket League." -ForegroundColor Green
