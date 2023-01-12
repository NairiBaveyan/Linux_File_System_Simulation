Write-Output "Build Visual Studio project"

Write-Output "awk"
awk 'BEGIN { del=0; } /# Begin Group "uap"/ { del=1; } /# End Group/ { if( del > 0 ) {del=0; next;} } del==0 {print;} ' abclib.dsp > tmp.dsp
Write-Output "gawk"
gawk 'BEGIN { del=0; } /# Begin Group "uap"/ { del=1; } /# End Group/ { if( del > 0 ) {del=0; next;} } del==0 {print;} ' abclib.dsp > tmp.dsp

sed --help
msbuild filesystem.sln /p:Configuration=Release /p:PlatformTarget=x64

Write-Output "Action ends"
