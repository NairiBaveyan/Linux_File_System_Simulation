Write-Output "	VERIFIC start "
$verific_path = Get-Location

$OldPATH = $PATH
$env:PATH = (Test-Path -Path "C:\cygwin64\bin") ? "C:\cygwin64\bin\" : "C:\cygwin\bin\"
$env:PATH -split ";"


Set-Location -Path "$verific_path\hdl_file_sort"
C:\cygwin64\bin\bash.exe -c "flex "
C:\cygwin64\bin\bash.exe -c "bison "

Write-Output "	Verific End "

$env:PATH = $OldPATH
