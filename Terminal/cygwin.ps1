Write-Output "Cygwin starts"
$verific_path = Get-Location

$OldPATH = $PATH
$env:PATH = (Test-Path -Path "C:\cygwin64\bin") ? "C:\cygwin64\bin\" : "C:\cygwin\bin\"
$Cygwin = $env:PATH + "bash.exe"
$awk = "awk"
$gawk = "gawk"

Write-Output "awk and gawk"
& $awk 'BEGIN { del=0; } /# Begin Group "uap"/ { del=1; } /# End Group/ { if( del > 0 ) {del=0; next;} } del==0 {print;} ' abclib.dsp > tmp.dsp
& $gawk 'BEGIN { del=0; } /# Begin Group "uap"/ { del=1; } /# End Group/ { if( del > 0 ) {del=0; next;} } del==0 {print;} ' abclib.dsp > tmp.dsp

Write-Output "C:\cygwin\bin\gawk"
$Cyg_gawk = $env:PATH + "gawk"
& $Cyg_gawk 'BEGIN { del=0; } /# Begin Group "uap"/ { del=1; } /# End Group/ { if( del > 0 ) {del=0; next;} } del==0 {print;} ' abclib.dsp > tmp.dsp


#$env:PATH -split ";"
sed -help
Write-Output "sed command works"
#Arguments for Cygwin Bash
$arg0="-c"
$argF="flex --help"
$argB="bison -help"

& $Cygwin $arg0 $argF
& $Cygwin $arg0 $argB

& $Cygwin $arg0 "gawk" 'BEGIN { del=0; } /# Begin Group "uap"/ { del=1; } /# End Group/ { if( del > 0 ) {del=0; next;} } del==0 {print;} ' abclib.dsp > tmp.dsp

$env:PATH = $OldPATH
Write-Output "Cygwin finished"
