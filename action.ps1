Write-Output "Build Visual Studio project"

$OldPath = $env:PATH
$env:PATH = "c:\\cygwin64\\bin\\"
$BASH = $env:PATH + "\\bash.exe"

Write-Output "LN RUNS"

c:\\cygwin64\\bin\\bash -c "ln -sf vhdl_1993/bin vdbs_1993"
bash.exe -c "ln -sf vhdl_2008/bin vdbs_2008"
bash -c "ln -sf vhdl_2019/bin vdbs_2019"
c:\\cygwin64\\bin\\wget -nc -O pmgen.py https://raw.githubusercontent.com/YosysHQ/yosys/master/passes/pmgen/pmgen.py
& "c:\\cygwin64\\bin\\wget" "-nc" "-O" "pmgen.py" "https://raw.githubusercontent.com/YosysHQ/yosys/master/passes/pmgen/pmgen.py"

if($?)
{
  Write-Output "true"
}
Write-Output "MAKE RUNS"

c:\\cygwin64\\bin\\bash -c "make genfiles " "SHELL=C:\\cygwin64\\bin\\bash"


Write-Output "Action ends"
$env:PATH = $OldPath
