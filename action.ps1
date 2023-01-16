Write-Output "Build Visual Studio project"

$OldPath = $env:PATH
$env:PATH = "c:\\cygwin64\\bin"
$BASH = $env:PATH + "\\bash.exe"

Write-Output "LN RUNS
$BASH -c "ln -sf vhdl_1987/bin vdbs_1987"
c:\\cygwin64\\bin\\bash -c "ln -sf vhdl_1993/bin vdbs_1993"
& $BASH "-c" "ln -sf vhdl_2008/bin vdbs_2008"
& $BASH "-c" "ln -sf vhdl_2019/bin vdbs_2019"

Write-Output "MAKE RUNS"

c:\\cygwin64\\bin\\bash.exe -c "make genfiles " "SHELL=C:\\cygwin64\\bin\\bash"


Write-Output "Action ends"
$env:PATH = $OldPath
