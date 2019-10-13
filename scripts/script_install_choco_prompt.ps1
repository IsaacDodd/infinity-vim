
function Success-Output () {
	Write-Host $_ -ForegroundColor Green 
}


Write-Output ""
Write-Output ""
Write-Output "VIMSetup installed Chocolatey." | Success-Output
Write-Output "Please restart the installation to proceed with installing VIMSetup." | Success-Output
$StopScript = Read-Host -Prompt ' [Press Enter to Quit]'

