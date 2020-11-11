$URL="https://da3hntz84uekx.cloudfront.net/QlikSense/13.95/0/_MSI/Qlik_Sense_setup.exe"
Invoke-WebRequest $URL -OutFile c:\software\Qlik_Sense_setup.exe


$Ipaddress   = $(ipconfig | where {$_ -match 'IPv4.+\s(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})' } | out-null; $Matches[1])
$ComputerName = $env:computername | Select-Object


$Username = "digit1"
$Password = "pDigit@!@#@123"
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



New-Item 'c:\QlikSenseStorage' -ItemType Directory
New-SMBShare –Name AdminUsedShares  –Path C:\QlikSenseStorage  –FullAccess 'Administrators'
New-SMBShare –Name DigitUsedShares  –Path C:\QlikSenseStorage  –FullAccess 'digit1'
