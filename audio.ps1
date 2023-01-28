param([switch]$Elevated)
function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)  {
    if ($elevated) {
        # tried to elevate, did not work, aborting
    } else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList (' -noprofile -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    }
    exit
}

$p = Get-WmiObject Win32_process -filter 'name="audiodg.exe"'
$p.SetPriority(32768) # Above Normal
#$p.SetPriority(128)  # High
$p = Get-Process audiodg
$p.ProcessorAffinity=4