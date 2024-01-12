$string = '' -replace '\s',''
$bytes = [byte[]] -split ($string '..','0x%& ')
$b64 = [system.convert]::tobase64string($bytes)
