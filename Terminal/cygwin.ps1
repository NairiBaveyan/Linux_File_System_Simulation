Write-Output "Cygwin starts"
$verific_path = Get-Location

$OldPATH = $PATH
$env:PATH = (Test-Path -Path "C:\cygwin64\bin") ? "C:\cygwin64\bin\" : "C:\cygwin\bin\"
$Cygwin = $env:PATH + "bash.exe"

#$env:PATH -split ";"
sed -help
Write-Output "sed command works"
#Arguments for Cygwin Bash
$arg0="-c"
$argF="flex --help"
$argB="bison -help"

& $Cygwin $arg0 $argF
& $Cygwin $arg0 $argB

$env:PATH = $OldPATH
Write-Output "Cygwin finished"
