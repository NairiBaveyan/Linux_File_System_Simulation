Write-Output "Build Visual Studio project"

$OldPATH = $env:PATH
Write-Output "OLD PATH = $env:PATH"
$env:PATH = (Test-Path -Path "C:\cygwin64\bin") ? "C:\cygwin64\bin\" : "C:\cygwin\bin\"
Write-Output
$env:PATH -split ";"
$Cygwin = $env:PATH + "bash.exe"
$arg = "-c"

Write-Output "LN RUNS"

& $Cygwin $arg "ln -sf vhdl_1993/bin vdbs_1993"
& $Cygwin $arg "ln -sf vhdl_2008/bin vdbs_2008"
& $Cygwin $arg "ln -sf vhdl_2019/bin vdbs_2019"
& $Cygwin $arg "wget -nc -O pmgen.py https://raw.githubusercontent.com/YosysHQ/yosys/master/passes/pmgen/pmgen.py"

& $Cygwin $arg "unix2dos.exe --help"
unix2dos.exe --help

Write-Output "Test Output"
./Terminal/cygwin.ps1

pwsh.exe --help
if($?)
{
  Write-Output "true"
}
Write-Output "MAKE RUNS"

& $Cygwin $arg "make genfiles " "SHELL=$Cygwin"
Write-Output "Python3..."
& $Cygwin $arg "python3 --help"

Write-Output "Action ends"
$env:PATH = $OldPath
