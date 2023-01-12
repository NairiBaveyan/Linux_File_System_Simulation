Write-Output "Build Visual Studio project"

Write-Output "awk"
awk
Write-Output "gawk"
gawk

sed --help
msbuild filesystem.sln /p:Configuration=Release /p:PlatformTarget=x64

Write-Output "Action ends"
