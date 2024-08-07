#override edid block 1 to fix display driver stuttering bug

If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit	
}


#constant vars
$regLocation = 'HKLM\SYSTEM\CurrentControlSet\Enum\'
$hex = '02030400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f7'

#build reg path
$monitors = (Get-WmiObject -Namespace root\wmi -Class WmiMonitorID).InstanceName -replace '_0' , ''
#create override reg key
foreach ($monitor in $monitors) {
    $name = $monitor -split '\\'
    Write-Host "Applying EDID Override for $($name[1])" -ForegroundColor Green
    Reg.exe add "$($regLocation)$($monitor)\Device Parameters\EDID_OVERRIDE" /v '1' /t REG_BINARY /d $hex /f
}

$input = Read-Host 'Restart to APPLY...'
if ($input) {
    exit
}