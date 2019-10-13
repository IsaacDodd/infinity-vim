:: Name:     windows_uninstall.cmd
:: Purpose:  Runs the PowerShell script to uninstall VimSetup without having to reset execution policies
:: Author:   Isaac M. E. Dodd (https://github.com/IsaacDodd). Sources cited where appropriate.
:: Revision: April 10 2019 - initial version

@echo off

SET DIR=%~dp0%

::Run VIMSetup Installer
%systemroot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "& '%DIR%scripts\script_uninstall_vimsetup.ps1' %*"
