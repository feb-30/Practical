$URL="https://da3hntz84uekx.cloudfront.net/QlikSense/13.95/0/_MSI/Qlik_Sense_setup.exe"
Invoke-WebRequest $URL -OutFile c:\software\Qlik_Sense_setup.exe


$Ipaddress   = $(ipconfig | where {$_ -match 'IPv4.+\s(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})' } | out-null; $Matches[1])
$ComputerName = $env:computername | Select-Object


$Username = "digit1"
$Password = "Digit@!@#@123"
$group = "Administrators"

$adsi = [ADSI]"WinNT://$env:COMPUTERNAME"
$existing = $adsi.Children | where {$_.SchemaClassName -eq 'user' -and $_.Name -eq $Username }

if ($existing -eq $null) {

    Write-Host "Creating new local user $Username."
    & NET USER $Username $Password /add /y /expires:never
    
    Write-Host "Adding local user $Username to $group."
    & NET LOCALGROUP $group $Username /add

}
else {
    Write-Host "Setting password for existing local user $Username."
    $existing.SetPassword($Password)
}

Write-Host "Ensuring password for $Username never expires."
& WMIC USERACCOUNT WHERE "Name='$Username'" SET PasswordExpires=FALSE



$content = Get-Content -Path 'c:\software\scripts\spec1_cfg.txt'
$newContent = $content -replace '%computername%', $ComputerName
$newContent | Set-Content -Path 'c:\software\scripts\spec1_cfg1.txt'

$content = Get-Content -Path 'c:\software\scripts\spec1_cfg1.txt'
$newContent = $content -replace 'localhost', $Ipaddress
$newContent | Set-Content -Path 'c:\software\scripts\spec1_cfg.txt'


New-Item 'c:\QlikSenseStorage' -ItemType Directory
New-SMBShare –Name AdminUsedShares  –Path C:\QlikSenseStorage  –FullAccess 'Administrators'
New-SMBShare –Name DigitUsedShares  –Path C:\QlikSenseStorage  –FullAccess 'digit1'





Qlik_Sense_setup.exe -silent -log "c:\software\qliksense.log" accepteula=1 desktopshortcut=1 skipstartservices=1 installdir="%ProgramFiles%\Qlik\Sense" userwithdomain=%computername%\digit1 userpassword="Digit@!@#@123" dbpassword="Digit@!@#@123" hostname=%computername% sharedpersistenceconfig="c:\software\spec1_cfg.txt" databasedumpfile="c:\software"
