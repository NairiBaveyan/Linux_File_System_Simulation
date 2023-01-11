Write-Output "Cygwin starts"
$verific_path = Get-Location

$OldPATH = $PATH
$env:PATH = (Test-Path -Path "C:\cygwin64\bin") ? "C:\cygwin64\bin" : "C:\cygwin\bin"
#$env:PATH -split ";"

if(Test-Path -Path "C:\cygwin64\bin"){
	Write-Output "cygwin64 "
	C:\cygwin64\bin\bash.exe -c "flex --help"
	C:\cygwin64\bin\bash.exe -c "bison --help"
}else{
	Write-Output "cygwin "
	C:\cygwin\bin\bash.exe -c "flex --help"
	C:\cygwin\bin\bash.exe -c "bison -help"
}

$env:PATH = $OldPATH
Write-Output "Cygwin finished"
