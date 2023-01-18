Write-Output "Cygwin finished  POWERSHELL WORKS"

$OldPATH = $PATH
$env:PATH = (Test-Path -Path "C:\cygwin64\bin") ? "C:\cygwin64\bin\" : "C:\cygwin\bin\"

pwsh.exe --help

$env:PATH = $OldPATH











