Write-Output "Build Visual Studio project"

$OldPATH = $env:PATH
Write-Output "OLD PATH = $oldPATH"
Write-Output "env:PATH : $env:PATH"
$env:PATH = (Test-Path -Path "C:\cygwin64\bin") ? "C:/cygwin64/bin/" : "C:/cygwin/bin/"
$env:PATH -split ";"
$Cygwin = $env:PATH + "bash"
$arg = "-c"

Write-Output "LN RUNS"

& $Cygwin $arg "ln -sf vhdl_1993/bin vdbs_1993"
& $Cygwin $arg "ln -sf vhdl_2008/bin vdbs_2008"
& $Cygwin $arg "ln -sf vhdl_2019/bin vdbs_2019"
& $Cygwin $arg "wget -nc -O pmgen.py https://raw.githubusercontent.com/YosysHQ/yosys/master/passes/pmgen/pmgen.py"

Write-Output "CYGWIN = $Cygwin"

& $Cygwin $arg "unix2dos.exe --help"
unix2dos.exe --help

Write-Output "Test Output"
./Terminal/cygwin.ps1

if($?)
{
  Write-Output "true"
}
Write-Output "MAKE RUNS"

& $Cygwin $arg "make genfiles" "SHELL=$Cygwin"
Write-Output "Python3..."
& $Cygwin $arg "python3 --help"

Write-Output "Action ends"
$env:PATH = $OldPath
Write-Output "env:PATH = $env:PATH"
