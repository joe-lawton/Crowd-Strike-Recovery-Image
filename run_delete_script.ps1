$usbDrive = "X:"  # Replace X: with your USB drive letter
$scriptPath = "$usbDrive\delete_cs_file.bat"

# Create the PowerShell script
$psScript = @"
Start-Process -FilePath "cmd.exe" -ArgumentList "/c $scriptPath" -NoNewWindow -Wait
"@

$psScriptPath = "$usbDrive\run_delete_script.ps1"
Set-Content -Path $psScriptPath -Value $psScript
