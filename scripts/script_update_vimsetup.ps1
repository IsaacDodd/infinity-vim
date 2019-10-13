

$Packages = choco list -lo -r  | % {($_.split("|"))[0]}

foreach ($Package in $Packages) {
	choco upgrade $Package -y | Out-File -FilePath "c:\Windows\Temp\choco-$Package.txt"
	if ($LASTEXITCODE -ne '0') {
	   $Results = [PSCustomObject]@{
			ComputerName = $Env:COMPUTERNAME
			Package = $Package
		}
		$Results
	}
}
# Reference: [https://blog.ipswitch.com/installing-chocolatey-packages-remotely-with-powershell]

choco upgrade choco-cleaner
# \ProgramData\chocolatey\lib\choco-cleaner\tools\Choco-Cleaner-manual.bat
# Reference: [https://superuser.com/questions/1371668/how-to-clear-chocolatey-cache-in-the-free-version]
#

# Update Coc.nvim
# vim -c 'CocUpdateSync|q'
