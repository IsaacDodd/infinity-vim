:: Name:     windows_install.cmd
:: Purpose:  Runs the PowerShell scripts without having to reset execution policies
:: Author:   Isaac M. E. Dodd (https://github.com/IsaacDodd). Sources cited where appropriate.
:: Revision: April 8 2019 - initial version
::           April 8 2019 - added chocolatey installation mechanism

@echo off

SET DIR=%~dp0%

IF NOT EXIST "C:\ProgramData\chocolatey\choco.exe" (
	::Download Chocolatey Installer (from install.ps1)
	%systemroot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "((new-object net.webclient).DownloadFile('https://chocolatey.org/install.ps1','%DIR%scripts\script_install_choco.ps1'))"
	::Run Chocolatey Installer
	%systemroot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "& '%DIR%scripts\script_install_choco.ps1' %*"
	::Prompt to Restart the Script after the installation
	%systemroot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "& '%DIR%scripts\script_install_choco_prompt.ps1' %*"

) ELSE (
	::Run VIMSetup Installer
	%systemroot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "& '%DIR%scripts\script_install_vimsetup.ps1' %*"
)

::Reference: [https://steve-jansen.github.io/guides/windows-batch-scripting/part-1-getting-started.html]
