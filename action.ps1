Write-Output "Build Visual Studio project"

sed --help
msbuild filesystem.sln /p:Configuration=Release /p:PlatformTarget=x64

Write-Output "Action ends"
