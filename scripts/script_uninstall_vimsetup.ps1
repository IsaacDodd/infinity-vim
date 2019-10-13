<#
.SYNOPSIS
This script uninstalls VimSetup on a Windows machine.
.DESCRIPTION
Use this script to automate the uninstallation of all the requirements for having VimSetup on the Windows OS.
.EXAMPLE
Uninstall-VimSetup -Full
.LINK
https://github.com/IsaacDodd
#>
# Let's begin

# ===========================================
# Call Manager - Removal
# ===========================================
function Call-Manager-Uninstall
{
	try {
		Write-Output ""
		Write-Output "[-] Uninstalling '$args'..." | AddTask-Output
		# Chocolatey Installation
		choco uninstall -y --force $args
		# Reload the PATH variable: Take the machine path and make it this session's path also:
		#	Reference: -- [/so/17794507] , [/so/17794507]
		$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
		$env:Path = [System.Environment]::ExpandEnvironmentVariables([System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User"))
		refreshenv
		Write-Output "Uninstallation of '$args' was successful." | Success-Output
		Write-Output ""
	}
	catch {
		Write-Output "[*] Could not uninstall '$args' " | Failure-Output
		Write-Output $_
	}
}

# ===========================================
# Output Functions
# ===========================================

# Resize console window to accommodate prompts and add title, if it's possible in the present cmd window
try {
	# Create an Windows PowerShell console object reference
	$PSHost = Get-Host
	$PSWindow = $PSHost.UI.RawUI
		# Increase the buffer size to enable increasing the screen width
		$NewSize = $PSWindow.BufferSize
		$NewSize.Height = 5000
		$NewSize.Width = 900
	$PSWindow.BufferSize = $NewSize
		# Assign the increased buffer size to the console window
		$NewSize = $PSWindow.WindowSize
		$NewSize.Height = 64
		$NewSize.Width = 200
	$PSWindow.WindowSize = $NewSize
	# Set the Window Title
	$PSWindow.WindowTitle = "VIMSetup Installation"
} catch {
	# No remedy needed
}

function Success-Output
{
	process { Write-Host $_ -ForegroundColor Green }
}
function Failure-Output
{
	process { Write-Host $_ -ForegroundColor Red }
}
function AddTask-Output
{
	process { Write-Host $_ -ForegroundColor Blue }
}
function SubtractTask-Output
{
	process { Write-Host $_ -ForegroundColor White }
}
# Display Uninstallation Type Menu
function choose_type() {
	Write-Output ""
	Write-Output "UNINSTALLATION TYPE:" | AddTask-Output

	Write-Output ""
	Write-Output ""
	Write-Output "	[1] Partial Vim Uninstallation 		-- Remove Vim, vimrc, and vim_runetime. Leave dependencies and Chocolatey" | Success-Output
	Write-Output "	[2] Partial System Uninstallation	-- Remove The above plus its fonts, files, and plugins PLUS its dependencies via Chocolatey" | Success-Output
	Write-Output "	[3] FULL System Uninstallation		-- Remove the above plus CHOCOLATEY itself [WARNING!]*" | Failure-Output
	Write-Output "	[Q] Quit"
	Write-Output ""
	Write-Output "* [WARNING]: A FULL system uninstallation will remove Chocolatey and all its packages," | Failure-Output
	Write-Output " ...including ones you may have installed prior to or after installing VIMSetup!" | Failure-Output
	Write-Output ""
	Write-Output ""
	Write-Output "Select a type by entering its number or enter Q to quit" | AddTask-Output
	Write-Output ""
	$UninstallType = Read-Host -Prompt "Type of Uninstallation [ 1, 2, 3, or Q ]"

	# Determine Uninstallation Procedures
	switch ($UninstallType) {
		"1" {
			# PARTIAL VIM
			Write-Output ""
			Write-Output "[-] Performing a Partial Uninstallation..." | AddTask-Output
			uninstall_partial_vim
		}
		"2" {
			# PARTIAL SYSTEM
			Write-Output ""
			Write-Output "[-] Performing a Partial System Uninstallation..." | AddTask-Output
			uninstall_partial_system
		}
		"3" {
			# FULL SYSTEM
			Write-Output ""
			Write-Output "[-] Performing a FULL SYSTEM UNINSTALLATION..." | Failure-Output
			uninstall_full_system
		}
		"Q" {
			# QUIT
			uninstall_quit
		}
		default {
			choose_type
		}
	}

	# References:
	#	https://jcallaghan.com/2011/10/adding-a-yes-no-cancel-prompt-to-a-powershell-script/
	#	https://www.petri.com/building-a-powershell-console-menu-revisited-part-1
}

# Exit Command -- References: [https://weblogs.asp.net/soever/returning-an-exit-code-from-a-powershell-script]
function ExitWithCode { 
	param 
	( 
		$exitcode 
	)
	$host.SetShouldExit($exitcode) 
	exit 
}
# QUIT
function uninstall_quit() {
	# Do Nothing
	Write-Output ""
	$StopScript = Read-Host -Prompt ' [Press Enter to Quit]'
	ExitWithCode 7
}

# PARTIAL VIM UNINSTALLATION
function uninstall_partial_vim() {
	try {
		Write-Output "Uninstalling Vim..." | AddTask-Output
		Call-Manager-Uninstall vim-tux.install
		echo ''

		# Must come before delete_vimefiles to use the .vim\fonts directory to delete fonts.
		Write-Output "[-] Uninstalling fonts..." | AddTask-Output
		delete_fonts
		
		Write-Output "Uninstalling Vim Files..." | AddTask-Output
		delete_vimfiles
		echo ''

		Write-Output "Partial Vim Uninstallation complete." | Success-Output
	}
	catch {
		Write-Output "[*] There was a problem partially uninstalling VIMSetup." | Failure-Output
		Write-Output $_
	}
	uninstall_quit
}

# PARTIAL SYSTEM UNINSTALLATION
function uninstall_partial_system() {
	try {
		Write-Output ""
		Write-Output "PARTIAL SYSTEM UNINSTALLATION" | AddTask-Output
		Write-Output ""
		Write-Output ""
		uninstall_partial_deleteall
		Write-Output "Partial System Uninstallation complete." | Success-Output
	}
	catch {
		Write-Output "[*] There was a problem partially uninstalling VIMSetup from the system." | Failure-Output
		Write-Output $_
	}
	uninstall_quit
}

# FULL SYSTEM UNINSTALLATION
function uninstall_full_system() {
	cls
	Write-Output ""
	Write-Output "FULL SYSTEM UNINSTALLATION" | Failure-Output
	Write-Output ""
	Write-Output ""
	Write-Output "WARNING!! Full System Uninstallation: This will remove Chocolatey and all packages, software, " | Failure-Output
	Write-Output "and configurations in the Chocolatey Installation folder from your machine. " | Failure-Output
	Write-Output ""
	Write-Output "Everything will be GONE. This is very destructive. DO NOT RUN this script unless you completely " | Failure-Output
	Write-Output "  understand what the intention of this script is and are good with it. If you mess something up, " | Failure-Output
	Write-Output "  we may not be able to help you fix it. Seriously, this script may destroy your machine and require a rebuild. " | Failure-Output
	Write-Output "	Think twice before running this." | Failure-Output
	Write-Output "As in the License Agreement, this software comes with NO WARRANTY and is AS-IS. The author is not responsible" | Failure-Output
	Write-Output "  for what happens in your use of this software!" | Failure-Output
	Write-Output "" | Failure-Output
	Write-Output "" | Failure-Output

	# Set Prompt Options
	$OptionYes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes","Yes -- Continue to do a Full System Uninstallation, Removing Chocolatey"
	$OptionNo = New-Object System.Management.Automation.Host.ChoiceDescription "&No","No -- Go Back to the Previous Menu"
	$OptionCancel = New-Object System.Management.Automation.Host.ChoiceDescription "&Cancel","Cancel -- Stop the Full System Uninstallation & Quit"
	$Options = [System.Management.Automation.Host.ChoiceDescription[]]($OptionYes, $OptionNo, $OptionCancel)

	# Prompt: Proceed with Uninstallation
	$PromptTitle = "WARNING: "
	$PromptMessage = "This will erase Chocolatey and all its packages, including ones you may have installed prior to installing VIMSetup. 
	
		Do you wish to Proceed?
		
		"
	$result = $Host.UI.PromptForChoice($PromptTitle, $PromptMessage, $Options, 1)
	switch ($result) {
		0 {
			uninstall_full_deleteall
		} 1 {
			cls
			choose_type
		} 2 {
			uninstall_quit
		}
	}
}
function uninstall_full_deleteall() {
	uninstall_partial_deleteall
	try {
		cls
		Write-Output ""
		Write-Output "[-] Uninstalling chocolatey..." | Failure-Output
		Write-Output ""
		Write-Output "Last Chance: Hit Ctrl+C to stop the uninstallation to back out of uninstalling Chocolatey" | Failure-Output
		Write-Output ""
		$StopScript = Read-Host -Prompt ' [Press Enter to Continue -- "I know what I am doing"]'
		uninstall_chocolatey
	}
	catch {
		Write-Output "[*] Could not uninstall Chocolatey." | Failure-Output
		Write-Output $_
	}
	uninstall_quit
}
function uninstall_partial_deleteall() {
	try {
		Write-Output "[-] Uninstalling Python dependencies..." | AddTask-Output
		Call-Manager-Uninstall python3
		Call-Manager-Uninstall python2
		Call-Manager-Uninstall python
		pip uninstall pynvim
		pip uninstall pep8
		pip uninstall flake8
		echo ''

		Write-Output "[-] Uninstalling Build dependencies..." | AddTask-Output
		Call-Manager-Uninstall llvm
		Call-Manager-Uninstall cmake.install
		Call-Manager-Uninstall cmake
		Call-Manager-Uninstall visualstudio2019community
		Call-Manager-Uninstall visualstudio2019-workload-nativedesktop
		Write-Output "[-] Uninstalling VimTeX & Markdown dependencies..." | AddTask-Output
		Call-Manager-Uninstall mupdf
		Call-Manager-Uninstall pandoc
		Write-Output "[-] Uninstalling Search dependencies..." | AddTask-Output
		Call-Manager-Uninstall ag
		Write-Output "[-] Uninstalling Neovim..." | AddTask-Output
		Call-Manager-Uninstall neovim
		Write-Output "[-] Uninstalling Vim..." | AddTask-Output
		Call-Manager-Uninstall vim-tux.install
		echo ''

		# Must come before delete_vimefiles to use the .vim\fonts directory to delete fonts.
		Write-Output "[-] Uninstalling fonts..." | AddTask-Output
		delete_fonts
		
		Write-Output "Uninstalling Vim Files..." | AddTask-Output
		delete_vimfiles
		echo ''

		echo ''
	}
	catch {
		Write-Output "[*] Could not uninstall VIMSetup dependencies." | Failure-Output
		Write-Output $_
	}
}

# Delete fonts from the system directory if it's possible
function delete_fonts() {
	$ssfFonts = 0x14
	$fontSourceFolder = "$HOME\.vim\fonts"
	$Shell = New-Object -ComObject Shell.Application
	$SystemFontsFolder = $Shell.Namespace($ssfFonts)
	$FontFiles = Get-ChildItem $fontSourceFolder
	$SystemFontsPath = $SystemFontsFolder.Self.Path
	$rebootFlag = $false

	try {
		foreach($FontFile in $FontFiles) {
			# $FontFile will be copied to this path:
			$targetPath = Join-Path $SystemFontsPath $FontFile.Name
			# So, see if target exists...
			if(Test-Path $targetPath){
				# font file with the same name already there.
				# delete and replace.
				$rebootFlag = $true
				Remove-Item $targetPath -Force
			}
		}
	}
	catch {
		Write-Output "[*] Could not uninstall fonts." | Failure-Output
		Write-Output $_
	}
	# Reference -- [https://www.mondaiji.com/blog/other/it/10247-windows-install-fonts-via-command-line]
}

# Delete Files associated with Vim in the HOME Directory
function delete_vimfiles() {
	Write-Output "[-] Removing _vimrc and .vim_runtime..." | AddTask-Output
	try {
		if (Test-Path "$HOME\.vim") {
			Remove-Item -Path "$HOME\.vim" -Force -Recurse
		}
		if (Test-Path "$HOME\.vim_runtime") {
			Remove-Item -Path "$HOME\.vim_runtime" -Force -Recurse
		}
		if (Test-Path "$HOME\vimfiles") {
			Remove-Item -Path "$HOME\vimfiles" -Force -Recurse
		}
		if (Test-Path "$HOME\.vimrc") {
			Remove-Item -Path "$HOME\.vimrc" -Force
		}
		if (Test-Path "$HOME\_vimrc") {
			Remove-Item -Path "$HOME\_vimrc" -Force
		}
		if (Test-Path "$HOME\.vim\.vimrc") {
			Remove-Item -Path "$HOME\.vim\.vimrc" -Force
		}
		if (Test-Path "$HOME\.vim\_vimrc") {
			Remove-Item -Path "$HOME\.vim\_vimrc" -Force
		}
		if (Test-Path "$HOME\.viminfo") {
			Remove-Item -Path "$HOME\.viminfo" -Force
		}
		if (Test-Path "$HOME\_viminfo") {
			Remove-Item -Path "$HOME\_viminfo" -Force
		}
		if (Test-Path "$HOME\.vim_mru_files") {
			Remove-Item -Path "$HOME\.vim_mru_files" -Force
		}
		if (Test-Path "$HOME\_vim_mru_files") {
			Remove-Item -Path "$HOME\_vim_mru_files" -Force
		}
		if (Test-Path "$HOME\.vim-rfc.yml") {
			Remove-Item -Path "$HOME\.vim-rfc.yml" -Force
		}
		if (Test-Path "$HOME\_vim-rfc.yml") {
			Remove-Item -Path "$HOME\_vim-rfc.yml" -Force
		}
		Write-Output "Removed all files assocated with Vim in the Home directory." | Success-Output
	}
	catch {
		Write-Output "[*] Could not uninstall vim files" | Failure-Output
		Write-Output $_
	}
}

function uninstall_chocolatey() {
	# Remove the directory where Chocolatey was installed
	Remove-Item -Recurse -Force "$env:ChocolateyInstall"
	[System.Text.RegularExpressions.Regex]::Replace([Microsoft.Win32.Registry]::CurrentUser.OpenSubKey('Environment').GetValue('PATH', '', [Microsoft.Win32.RegistryValueOptions]::DoNotExpandEnvironmentNames).ToString(), [System.Text.RegularExpressions.Regex]::Escape("$env:ChocolateyInstall\bin") + '(?>;)?', '', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase) | %{[System.Environment]::SetEnvironmentVariable('PATH', $_, 'User')}
	[System.Text.RegularExpressions.Regex]::Replace([Microsoft.Win32.Registry]::LocalMachine.OpenSubKey('SYSTEM\CurrentControlSet\Control\Session Manager\Environment\').GetValue('PATH', '', [Microsoft.Win32.RegistryValueOptions]::DoNotExpandEnvironmentNames).ToString(),  [System.Text.RegularExpressions.Regex]::Escape("$env:ChocolateyInstall\bin") + '(?>;)?', '', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase) | %{[System.Environment]::SetEnvironmentVariable('PATH', $_, 'Machine')}

	# Remove the tools directory
	if ($env:ChocolateyBinRoot -ne '' -and $env:ChocolateyBinRoot -ne $null) { Remove-Item -Recurse -Force "$env:ChocolateyBinRoot" }
	if ($env:ChocolateyToolsRoot -ne '' -and $env:ChocolateyToolsRoot -ne $null) { Remove-Item -Recurse -Force "$env:ChocolateyToolsRoot" }
	[System.Environment]::SetEnvironmentVariable("ChocolateyBinRoot", $null, 'User')
	[System.Environment]::SetEnvironmentVariable("ChocolateyToolsLocation", $null, 'User')

	Write-Output "Chocolatey Uninstalled." | Success-Output
}

# ===========================================================
# Main: Launch the menu
choose_type
# ===========================================================

# Uninstall Complete
#Write-Output ""
#$StopScript = Read-Host -Prompt ' [Press Enter to Quit]'
