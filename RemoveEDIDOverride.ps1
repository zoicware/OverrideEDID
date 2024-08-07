#remove edid override for all monitors

If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit	
}


#constant vars
$regLocation = 'HKLM\SYSTEM\CurrentControlSet\Enum\'

#build reg path
$monitors = (Get-WmiObject -Namespace root\wmi -Class WmiMonitorID).InstanceName -replace '_0' , ''
#remove override reg key
foreach ($monitor in $monitors) {
    $name = $monitor -split '\\'
    Write-Host "Removing EDID Override for $($name[1])" -ForegroundColor Green
    Reg.exe delete "$($regLocation)$($monitor)\Device Parameters\EDID_OVERRIDE" /f
}

$input = Read-Host 'Restart to APPLY...'
if ($input) {
    exit
}