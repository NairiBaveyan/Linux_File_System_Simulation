Write-Output "Cygwin finished  POWERSHELL WORKS"

Write-Output "Cygwin first PATH $env:PATH"


$OldPATH = $env:PATH
$env:PATH = (Test-Path -Path "C:\cygwin64\bin") ? "C:\cygwin64\bin\" : "C:\cygwin\bin\"
Write-Output "Cygwin first PATH $env:PATH"
pwsh.exe --help

$env:PATH = $OldPATH











