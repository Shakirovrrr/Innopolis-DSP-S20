param(
	[string] $FileName
)

$sce = Get-Item $FileName;

Push-Location $sce.Directory
& 'C:\Program Files\scilab-6.1.0\bin\WScilex-cli.exe' -f $FileName
# & 'C:\Program Files\scilab-6.1.0\bin\WScilex-cli.exe' -e ("exec('{0}', -1); exit;" -f $sce.Name)
