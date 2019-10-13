<#
.SYNOPSIS
This script installs VimSetup on a Windows machine.
.DESCRIPTION
Use this script to automate the installation of all the requirements for having VimSetup on the Windows OS.
.EXAMPLE
Install-VimSetup -UserProfile localhost
.LINK
https://github.com/IsaacDodd
#>
# Reference: https://powershelltutorial.net/questions/How-do-you-comment-out-code-in-powershell

# ===========================================
# Capture Arguments
# ===========================================
Param(
	[switch]$h, [switch]$help,
	[switch]$v, [switch]$verbose = $true,
	[switch]$f, [switch]$force = $false,
	[switch]$l, [switch]$lvl, [switch]$level,
	[string]$g, [string]$group,
	[string]$a, [string]$ac, [string]$auto, [string]$autocompletion,

	[switch]$iall, [switch]$installall,
	[switch]$irs, [switch]$installrust,
	[switch]$igo, [switch]$installgo,
	[switch]$icl, [switch]$installclangd,
	[switch]$icc, [switch]$installccls,
	[switch]$irb, [switch]$installruby,
	[switch]$ijs, [switch]$installjs,
	[switch]$ivi, [switch]$installvim,
	[switch]$imd, [switch]$installmarkdown,
	[switch]$ipy, [switch]$installpython,
	[switch]$iph, [switch]$installphp,
	[switch]$ish, [switch]$installbash, [switch]$ibs, [switch]$installbashls,
	[switch]$ido, [switch]$installdocker,
	[switch]$ics, [switch]$installcsharp,
	[switch]$ija, [switch]$installjava
	)
# Reference:
#	[https://www.morgantechspace.com/2014/12/How-to-pass-arguments-to-PowerShell-script.html]
#	[https://stackoverflow.com/questions/2157554/how-to-handle-command-line-arguments-in-powershell]

# Help
if ($h -or $help) {
	$OPT_HELP = $true
}
# Verbose
if ($v -or $verbose) {
	$OPT_VERBOSE = $true
}
# Force
if ($f -or $force) {
	$OPT_FORCE = $true
}
#
# Group: Overrides some other prespecified options - Options = all/latest | stable
if ($g) {
	$OPTGROUP = $g
}
elseif ($group) {
	$OPTGROUP = $group
}

# Level: Options = full | basic
if ($l) {
	$OPTLEVEL = $l
} elseif ($lvl) {
	$OPTLEVEL = $lvl
} elseif ($level) {
	$OPTLEVEL = $level
}

# Auto-Completion: Options = coc.nvim | YouCompleteMe
if ($a) {
	$OPTAUTOCOMPLETION = $a
} elseif ($ac) {
	$OPTAUTOCOMPLETION = $ac
} elseif ($auto) {
	$OPTAUTOCOMPLETION = $auto
} elseif ($autocompletion) {
	$OPTAUTOCOMPLETION = $autocompletion
}
#
# Groups: Set default options by naming a group
if ( ($OPTGROUP -eq 'all') -or ($OPTGROUP -eq 'latest') -or ($g -eq 'all') -or ($g -eq 'latest') -or ($group -eq 'all') -or ($group -eq 'latest') ) {
	$OPTLEVEL='full'
	$OPTPLUGINMANAGER='vim-plug'
	$OPTAUTOCOMPLETION='coc.nvim'
	$OPT_INSTALLALL=$true
} elseif ( ($OPTGROUP -eq 'stable') -or ($OPTGROUP -eq 'basic') -or ($g -eq 'stable') -or ($g -eq 'basic') -or ($group -eq 'stable') -or ($group -eq 'basic') ) {
	$OPTLEVEL='basic'
	$OPTPLUGINMANAGER='Vundle'
	$OPTAUTOCOMPLETION='YouCompleteMe'
	$OPT_INSTALLALL=$true
}

# Install All
if ($iall) {
	$OPT_INSTALLALL = $true
} elseif ($installall) {
	$OPT_INSTALLALL = $true
}
if ($irs) {
	$OPT_INSTALLRUST = $true
} elseif ($installrust) {
	$OPT_INSTALLRUST = $true
}
if ($igo) {
	$OPT_INSTALLGO = $true
} elseif ($installgo) {
	$OPT_INSTALLGO = $true
}
if ($icl) {
	$OPT_INSTALLCLANGD = $true
} elseif ($installclangd) {
	$OPT_INSTALLCLANGD = $true
}
if ($icc) {
	$OPT_INSTALLCCLS = $true
} elseif ($installccls) {
	$OPT_INSTALLCCLS = $true
}
if ($irb) {
	$OPT_INSTALLRUBY = $true
} elseif ($installruby) {
	$OPT_INSTALLRUBY = $true
}
if ($ijs) {
	$OPT_INSTALLJS = $true
} elseif ($installjs) {
	$OPT_INSTALLJS = $true
}
if ($ivi) {
	$OPT_INSTALLVIM = $true
} elseif ($installvim) {
	$OPT_INSTALLVIM = $true
}
if ($imd) {
	$OPT_INSTALLMARKDOWN = $true
} elseif ($installmarkdown) {
	$OPT_INSTALLMARKDOWN = $true
}
if ($ipy) {
	$OPT_INSTALLPYTHON = $true
} elseif ($installpython) {
	$OPT_INSTALLPYTHON = $true
}
if ($iph) {
	$OPT_INSTALLPHP = $true
} elseif ($installpython) {
	$OPT_INSTALLPHP = $true
}
if ($ish) {
	$OPT_INSTALLBASHLS = $true
} elseif ($installbash) {
	$OPT_INSTALLBASHLS = $true
} elseif ($ibs) {
	$OPT_INSTALLBASHLS = $true
} elseif ($installbashls) {
	$OPT_INSTALLBASHLS = $true
}
if ($ido) {
	$OPT_INSTALLDOCKER = $true
} elseif ($installdocker) {
	$OPT_INSTALLDOCKER = $true
}



# ===========================================
# Capture Working Directory
# ===========================================
# Do it in a way compliant with PowerShell v2 - /so/34703657
$scriptsdir = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
cd "$scriptsdir"
cd ..
$SCRIPTROOT = ($pwd).path

# ===========================================
# Start Logging Output (for debugging)
# ===========================================
$DEBUG = $true
# Log output to a log file -- [/so/13160759]
if($DEBUG) {
	Start-Transcript -Path "$SCRIPTROOT\.test\windows_install.log" -Append
}

# ===========================================
# Output Functions
# ===========================================

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
function MinusTask-Output
{
	process { Write-Host $_ -ForegroundColor White }
}
function Action-Output
{
	process { Write-Host $_ -ForegroundColor Blue }
}
function NotFound-Output
{
	process { Write-Output "$_ not found. Installing $_..." -ForegroundColor Yellow }
}
function command_exists {
	param([string]$cmd)
	if (Get-Command $cmd -ErrorAction SilentlyContinue) {
		return $true
	} else {
		return $false
	}
}
function variable_exists
{
	param([string]$var)
	if (Get-Variable $var -Scope Global -ErrorAction 'Ignore') {
		return $true
	} else {
		return $false
	}
}

# ===========================================
# Prerequesites - Check for an internet connection
# ===========================================
# TODO: Test internet connection here and stop installation if none is present to prevent errors when no internet is present.

# ===========================================
# Windows - Determine Package Manager
# ===========================================

# Section: Detect the package manager, Chocolatey. If not present, install the package manager.
Write-Output "Checking for Package Manager..."
$ChocoInstalled = $false
if (Get-Command choco.exe -ErrorAction SilentlyContinue) {
    $ChocoInstalled = $true
}
if (Test-Path -Path "$env:ProgramData\Chocolatey") {
    $ChocoInstalled = $true
}
if (!$ChocoInstalled) {
	Write-Output "No package manager detected." | Failure-Output
	Write-Output "..."

	Write-Output "Installing Package Manager (Chocolatey)..."
	try {
		Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
		Write-Output "..."
		Write-Output ""
	} catch {
		Write-Output "[*] Attempt to install encountered some issues. Please restart your terminal/console to continue." | Failure-Output
		Write-Output "If you continue to encouter this error, please consider installing Chocolatey manually." | Failure-Output
		Write-Output " - Available Here: https://chocolatey.org/install"
		$StopScript = Read-Host -Prompt ' [Press Enter to Quit]'
	}

	Write-Output "In order to complete the installation, please restart this script." | Success-Output
	Write-Output ""
	$StopScript = Read-Host -Prompt ' [Press Enter to Quit]'
	#choco feature enable -n allowGlobalConfirmation
	#choco upgrade chocolatey
} else {
	Write-Output "Package manager detected." | Success-Output
	Write-Output ""
}
# References:
#	https://stackoverflow.com/questions/48144104/powershell-script-to-install-chocolatey-and-a-list-of-packages
# 	Luuk Grefte - choco-autoinstalller - https://gitlab.com/luukgrefte/choco-autoinstalller
# 	https://chocolatey.org/install#non-administrative-install

# ===========================================
# Git Setup
# ===========================================
# On Windows, use the autocrlf line ending setting in Git to store the EOL character as native *nix-based LF but check out in the working directory with a Windows-compatible CRLF format
# Reference: [/so/2825428]
git config --local core.autocrlf true

function Call-Manager
{
	try {
		Write-Output ""
		Write-Output "[+] Installing '$args'..." | AddTask-Output
		# Chocolatey Installation
		choco install -y --force $args
		# Refresh the commandline environment variables to add programs to path -- can force in cmd with: setx PATH "%PATH%;C:\path\to\binary"
		Call-Manager-Refresh
		Write-Output "Installation of '$args' was successful." | Success-Output
		Write-Output ""
	} catch {
		Write-Output "[*] Could not install '$args' " | Failure-Output
		Write-Output $_
	}
}
function Call-Manager-Refresh
{
	try {
		# Reload the PATH variable: Take the machine path and make it this session's path also:
		#	Reference: /so/17794507 , /so/17794507
		$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
		$env:Path = [System.Environment]::ExpandEnvironmentVariables([System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User"))
		# Refresh the commandline environment variables to add programs to path -- can force in cmd with: setx PATH "%PATH%;C:\path\to\binary"
		refreshenv

	} catch {
		Write-Output "[*] Could not refresh the command environment." | Failure-Output
		Write-Output $_
	}
}
# References:
#	https://serverfault.com/questions/


# Display Level Type Menu
function choose_level_type() {
	Write-Output ""
	Write-Output "LEVEL TYPE:" | AddTask-Output

	Write-Output ""
	Write-Output ""
	Write-Output "	[1] FULL" | Success-Output
	Write-Output "	[2] BASIC" | Success-Output
	Write-Output "	[Q] Quit"
	Write-Output ""
	Write-Output ""
	Write-Output "Select a type by entering its number or enter Q to quit" | AddTask-Output
	Write-Output ""
	$LevelType = Read-Host -Prompt "Type of Level [ 1, 2, or Q ]"

	# Determine Autocompletion Type
	switch ($LevelType) {
		"1" {
			# coc.nvim
			Set-Variable -Name 'OPTLEVEL' -Value 'full' -Scope global
			Write-Output ""
			Write-Output "[+] Level Selected: $OPTLEVEL" | AddTask-Output
		}
		"2" {
			# YouCompleteMe
			Set-Variable -Name 'OPTLEVEL' -Value 'basic' -Scope global
			Write-Output ""
			Write-Output "[+] Level Selected: $OPTLEVEL" | AddTask-Output
		}
		"Q" {
			# QUIT
			install_quit
		}
		default {
			choose_level_type
		}
	}

	# References:
	#	https://jcallaghan.com/2011/10/adding-a-yes-no-cancel-prompt-to-a-powershell-script/
	#	https://www.petri.com/building-a-powershell-console-menu-revisited-part-1
}

# Display Auto-Completion Type Menu
function choose_autocompletion_type() {
	Write-Output ""
	Write-Output "AUTOCOMPLETION TYPE:" | AddTask-Output

	Write-Output ""
	Write-Output ""
	Write-Output "	[1] coc.nvim" | Success-Output
	Write-Output "	[2] YouCompleteMe" | Success-Output
	Write-Output "	[Q] Quit"
	Write-Output ""
	Write-Output ""
	Write-Output "Select a type by entering its number or enter Q to quit" | AddTask-Output
	Write-Output ""
	$AutocompletionType = Read-Host -Prompt "Type of Auto-Completion [ 1, 2, or Q ]"

	# Determine Autocompletion Type
	switch ($AutocompletionType) {
		1 {
			# coc.nvim
			Set-Variable -Name 'OPTAUTOCOMPLETION' -Value 'coc.nvim' -Scope global
			Write-Output ""
			Write-Output "[+] Auto-completion Selected: $OPTAUTOCOMPLETION" | AddTask-Output
		}
		2 {
			# YouCompleteMe
			Set-Variable -Name 'OPTAUTOCOMPLETION' -Value 'YouCompleteMe' -Scope global
			Write-Output ""
			Write-Output "[+] Auto-completion Selected: $OPTAUTOCOMPLETION" | AddTask-Output
		}
		"Q" {
			# QUIT
			install_quit
		}
		default {
			choose_autocompletion_type
		}
	}

	# References:
	#	https://jcallaghan.com/2011/10/adding-a-yes-no-cancel-prompt-to-a-powershell-script/
	#	https://www.petri.com/building-a-powershell-console-menu-revisited-part-1
}

function choose_languagesupport_type() {
	Write-Output ""
	Write-Output "LANGUAGE SUPPORT INSTALLATION TYPE:" | AddTask-Output
	Write-Output "Auto-Completion Language Support: $OPTAUTOCOMPLETION"
	Write-Output ""
	Write-Output ""
	Write-Output "	[1] ALL: (Recommended)" | Success-Output
	Write-Output "		Install Support for ALL Languages" | Success-Output
	Write-Output "	[2] DEFAULT: " | Success-Output
	Write-Output "		If there were language support arguments passed from "
	Write-Output "		the command line they will be installed individually instead."
	Write-Output "	[Q] Quit"
	Write-Output ""
	Write-Output ""
	Write-Output "Select a type by entering its number or enter Q to quit" | AddTask-Output
	Write-Output ""
	$AutocompletionType = Read-Host -Prompt "Type of Language Support [ 1, 2, or Q ]"

	# Determine Autocompletion Type
	switch ($AutocompletionType) {
		"1" {
			# coc.nvim
			Set-Variable -Name 'OPT_INSTALLALL' -Value $true -Scope global
			Write-Output ""
			Write-Output "[+] Language Support Option Selected: Install All = $OPT_INSTALLALL" | AddTask-Output
		}
		"2" {
			Write-Output ""
			Write-Output "[-] Will not install all language servers" | MinusTask-Output
			Write-Output "		If there were language support arguments passed from "
			Write-Output "		the command line they will be installed individually instead."
		}
		"Q" {
			# QUIT
			install_quit
		}
		default {
			choose_languagesupport_type
		}
	}

	# References:
	#	https://jcallaghan.com/2011/10/adding-a-yes-no-cancel-prompt-to-a-powershell-script/
	#	https://www.petri.com/building-a-powershell-console-menu-revisited-part-1
}

# Display Plugin-Manager Type Menu
function choose_pluginmanager_type() {
	Write-Output ""
	Write-Output "PLUGIN-MANAGER TYPE:" | AddTask-Output

	Write-Output ""
	Write-Output ""
	Write-Output "	[1] vim-plug" | Success-Output
	Write-Output "	[2] Vundle" | Success-Output
	Write-Output "	[Q] Quit"
	Write-Output ""
	Write-Output ""
	Write-Output "Select a type by entering its number or enter Q to quit" | AddTask-Output
	Write-Output ""
	$PluginmanagerType = Read-Host -Prompt "Type of Plugin-Manager [ 1, 2, or Q ]"

	# Determine Plugin-Manager Type
	switch ($PluginmanagerType) {
		"1" {
			# vim-plug
			Set-Variable -Name 'OPTPLUGINMANAGER' -Value 'vim-plug' -Scope global
			Write-Output ""
			Write-Output "[+] Auto-completion Selected: $OPTPLUGINMANAGER" | AddTask-Output
		}
		"2" {
			# Vundle
			Set-Variable -Name 'OPTPLUGINMANAGER' -Value 'Vundle' -Scope global
			Write-Output ""
			Write-Output "[+] Auto-completion Selected: $OPTPLUGINMANAGER" | AddTask-Output
		}
		"Q" {
			# QUIT
			install_quit
		}
		default {
			choose_pluginmanager_type
		}
	}
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
function install_quit() {
	# Do Nothing
	Write-Output ""
	$StopScript = Read-Host -Prompt ' [Press Enter to Quit]'
	ExitWithCode 0
}


# ===========================================
# Capture Intended Home Directory
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
# Reference: https://devblogs.microsoft.com/scripting/how-can-i-expand-the-width-of-the-windows-powershell-console/

echo "
                                           ___
                  ___        ___          /__/\
                 /__/\      /  /\        |  |::\
                 \  \:\    /  /:/        |  |:|:\
                  \  \:\  /__/::\      __|__|:|\:\
              ___  \__\:\ \__\/\:\__  /__/::::| \:\
             /__/\ |  |:|    \  \:\/\ \  \:\~~\__\/
             \  \:\|  |:|     \__\::/  \  \:\
              \  \:\__|:|     /__/:/    \  \:\
               \__\::::/      \__\/      \  \:\
                   ~~~~                   \__\/
      ___           ___                       ___           ___
     /  /\         /  /\          ___        /__/\         /  /\
    /  /:/_       /  /:/_        /  /\       \  \:\       /  /::\
   /  /:/ /\     /  /:/ /\      /  /:/        \  \:\     /  /:/\:\
  /  /:/ /::\   /  /:/ /:/_    /  /:/     ___  \  \:\   /  /:/~/:/
 /__/:/ /:/\:\ /__/:/ /:/ /\  /  /::\    /__/\  \__\:\ /__/:/ /:/
 \  \:\/:/~/:/ \  \:\/:/ /:/ /__/:/\:\   \  \:\ /  /:/ \  \:\/:/
  \  \::/ /:/   \  \::/ /:/  \__\/  \:\   \  \:\  /:/   \  \::/
   \__\/ /:/     \  \:\/:/        \  \:\   \  \:\/:/     \  \:\
     /__/:/       \  \::/          \__\/    \  \::/       \  \:\
     \__\/         \__\/                     \__\/         \__\/

 "

# Obtain determined user directory - For a consistent experience between scripts for now; This script defaults to installing to the present user account
#Write-Output "-  What is the name of your user account? (e.g., C:\Users\<?>\)"
#$UserProfile = Read-Host -Prompt 'Account Name'
# Tell the user where it will install instead and give them a chance to discontinue and log in elsewhere.
Write-Output "Continuing will install VIMSetup into $HOME"
$StartScript = Read-Host -Prompt '[Press Enter to Continue]'

# Level
if (!$OPTLEVEL) {
	choose_level_type
}

# Choose the Autocompletion Type to Install:
if (!$OPTAUTOCOMPLETION) {
	choose_autocompletion_type
}

# Install all languages or not
if (!$OPT_INSTALLALL) {
	choose_languagesupport_type
}

# Choose Plugin Manager Type to Install:
if (!$OPTPLUGINMANAGER) {
	choose_pluginmanager_type
}

# References:
#	https://blog.bjornhouben.com/2014/04/04/powershell-using-powershell-5-to-automate-the-installation-of-your-favorite-windows-applications/
#	https://www.howtogeek.com/141495/geek-school-writing-your-first-full-powershell-script/


# ========================================
# Language Support
# ========================================
# Install Language Support
function install_nodejs {
	if (Get-Command node -ErrorAction SilentlyContinue) {
		NotFound-Output nodejs
		Call-Manager node
	}
	if (Get-Command npm -ErrorAction SilentlyContinue) {
		NotFound-Output npm
		Call-Manager npm
	}
	#curl -sL https://install-node.now.sh/lts | sh
}
function install_js {
	try {
		npm install -g javascript-typescript-langserver
	} catch {
		Write-Output "Could not install 'Typescript language server'." | Failure-Output
	}
	try {
		npm install -g vue-language-server
	} catch {
		Write-Output "Could not install 'Vue language server'." | Failure-Output
	}
	try {
		npm install -g jsonlint
	} catch {
		Write-Output "Could not install 'JSON Lint'." | Failure-Output
	}
	try {
		npm install -g eslint
	} catch {
		Write-Output "Could not install 'ESLint'." | Failure-Output
	}
		try {
			Detection-Overwrite "$HOME\.eslintrc.json" clobber
			# Vim-specific ctags Configuration File
			Write-Output "[+] Installing eslint's configuration file..." | AddTask-Output
			# Copy files
			Copy-Item -Path "$SCRIPTROOT\assets\.eslintrc.json" -Destination "$HOME\" -Force -Recurse
			Write-Output "ESLint setup successfully." | Success-Output
		} catch {
			Write-Output "[*] Could not copy the .eslintrc.json configuration file." | Failure-Output
		}
	# Stylelint -- Reference: [https://stylelint.io/user-guide/cli]
	try {
		npm install -g stylelint
	}
	catch {
		Write-Output "Could not install 'StyleLint'." | Failure-Output
	}
	# Prettier - These packages will help ESLint run Prettier automatically so Vim can display and fix errors from both
	#	Reference [https://davidtranscend.com/blog/configure-eslint-prettier-vim/]
	try {
		npm install -g prettier
	} catch {
		Write-Output "Could not install 'Prettier'." | Failure-Output
	}
	# ESLint-Prettier Plugin & Config
	try {
		npm install -g eslint-plugin-prettier eslint-config-prettier
	} catch {
		Write-Output "Could not install 'ESLint-Prettier Plugin & Config'."
	}
	try {
		npm install -g csslint
	} catch {
		Write-Output "Could not install 'CSSLint'."
	}
	try {
		npm install -g coffeelint
	} catch {
		Write-Output "Could not install 'CoffeeLint'."
	}
}
function install_rust {
	if (Get-Command rustup -ErrorAction SilentlyContinue) {
		NotFound-Output rustup
		# Install RustUp (Dependency): rustup installs rustc, cargo, rustup and other standard tools to Cargo's bin directory. On Unix it is located at $HOME/.cargo/bin and on Windows at %USERPROFILE%\.cargo\bin
			Call-Manager rustup.install
			rustup update
		# On Unix it is located at $HOME/.cargo/bin and on Windows at %USERPROFILE%\.cargo\bin
		### curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
		### Add-PathVar "$HOME\.cargo\bin"
		### . "$HOME\.cargo\env"
		### rustup update
		# Reference: [https://github.com/rust-lang/rustup.rs#other-installation-methods]
	}
}
function setup_rust {
	if (!Get-Command rustup -ErrorAction SilentlyContinue) {
		cd "$HOME\.vim"
		git clone https://github.com/rust-analyzer/rust-analyzer
		cd rust-analyzer
		rustup component add rls rust-analysis rust-src rustfmt
		cargo install-ra --server

		# Rust Formatter
		cargo install rustfmt
		# Ctags for Rust
		cargo install rusty-tags

		# Install Racer
		rustup toolchain add nightly
		cargo +nightly install racer
		export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

		# Enable tab completion for Rust in PowerShell
		rustup completions powershell >> $PROFILE.CurrentUserCurrentHost
	}
}
function install_bashls {
	if (!Get-Command bash-language-server -ErrorAction SilentlyContinue) {
		try {
			npm install -g bash-language-server
		} catch {
			npm install --unsafe-perm -g bash-language-server
		}
	}
}
function install_go {
	if (!command_exists go) {
		NotFound-Output go
		Call-Manager golang
		# Reference: [https://www.2daygeek.com/install-go-language-linux/]
	}
}
function install_python {
	if (!command_exists python) {
		# Install Python. Then, Pip will be installed and the next codeblock will install the python language server and its dependencies.
		NotFound-Output python
		Call-Manager python
	}
	if (!Get-Command pip -ErrorAction SilentlyContinue) {
		python -m pip install pip
		pip install -U pip
	}
	pip install virtualenv
}
function install_ruby {
	if (!command_exists gem) {
		# Install Ruby, which will include the 'gem' command.
		Call-Manager ruby
		# Add Ruby to the PATH variable if not present already
		$RBYPATH = "$(ruby -e 'puts Gem.user_dir')/bin"
		Add-PathVar $RBYPATH
		# Dependency manager
		gem install bundler
	}
}
function install_clangd {
	try {
		if (!command_exists clangd) {
			AddTask-Output "Package clangd not detected. Attempting to install the full LLVM distribution."
			Call-Manager llvm
			Write-Output "Installed clangd successfully." | Success-Output
		}
	} catch {
		Write-Output "Installation failed for your distribution. Please consider installing clangd manually instead." | Failure-Output
	}
}
function install_clang {
	if (!command_exists clang) {
		Call-Manager clang-tools
		Call-Manager clang-format
	}
}
function install_ccls {
	if (!command_exists ccls) {
		try {
			Call-Manager ccls
				New-Item -Path "$TMP\ccls" -ItemType Directory -Force
				New-Item -Path "$TMP\ccls\cache" -ItemType Directory -Force
				# Installs Dependencies of CCLS
				if (!Get-Command cmake -ErrorAction SilentlyContinue) {
					Call-Manager cmake --installargs 'ADD_CMAKE_TO_PATH=System'
				}
				if (!Get-Command ninja -ErrorAction SilentlyContinue) {
					Call-Manager ninja
				}
				if (!Get-Command cl -ErrorAction SilentlyContinue) {
					Call-Manager vcredist140
					Call-Manager visualstudio2017community --norestart --wait --quiet --add Microsoft.VisualStudio.Workload.NativeDesktop
					Call-Manager visualstudio2017-workload-nativedesktop --norestart --includeRecommended --quiet
				}
				# LLVM: Installs - clang - clang-cl - clangd - clang++ - clang-format - lld - llvm-objdump
				if (!Get-Command llvm -ErrorAction SilentlyContinue) {
					cd "$HOME\.vim"
					git clone --depth=1 --recursive https://github.com/llvm/llvm-project.git
					cd llvm-project
					cmake -Hllvm -BRelease -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_COMPILER=cl -DCMAKE_CXX_COMPILER=cl -DLLVM_TARGETS_TO_BUILD=X86
					ninja -C Release clangFormat clangFrontendTool clangIndex clangTooling clang

					# Download ccls
					cd "$HOME\.vim"
					git clone --depth=1 --recursive https://github.com/MaskRay/ccls
					cd ccls
					LLVM="C:/llvm"
					cmake -H. -BRelease -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=clang-cl -DCMAKE_PREFIX_PATH="$LLVM/Release;$LLVM/Release/tools/clang;$LLVM;$LLVM/tools/clang"
					ninja -C Release
				} else {
					Call-Manager llvm
				}
			Write-Output "Installed CCLS successfully." | Success-Output
		} catch {
			Write-Output "Error: Could not install the CCLS language server." | Failure-Output
			if (!command_exists ccls) {
				Write-Output "Installation failed for your distribution. Please consider installing CCLS manually instead." | Failure-Output
			}
		}
	}
}
function install_csharp {
	if (!command_exists mono) {
		NotFound-Output mono
		try {
			Call-Manager mono
			mono --version
			Write-Output "Installed mono successfully." | Success-Output
		} catch {
			Write-Output "Error: Could not install the mono repository." |Failure-Output
		}
	}
}
function install_java {
	if (!command_exists jdk) {
		NotFound-Output jdk
		try {
			Call-Manager jdk
			java -version
			javac -version
			Write-Output "Installed Java Development Kit successfully." | Success-Output
		} catch {
			Write-Output "Error: Could not install the JDK repository." Failure-Output
		}
		# Note: the coc-java extension will download the latest jdt.ls for you when not found.
		# Reference: [https://www.addictivetips.com/ubuntu-linux-tips/install-java-on-linux/]
	}
}
function install_latex {
	if (!command_exists latex) {
		NotFound-Output latex
		try {
			Call-Manager miktex
			Write-Output "Installed MiKTeX successfully." | Success-Output
		} catch {
			Write-Output "Error: Could not install MiKTeX." Failure-Output
		}
		# Note: the coc-java extension will download the latest jdt.ls for you when not found.
		# Reference: [https://www.addictivetips.com/ubuntu-linux-tips/install-java-on-linux/]
	}
}
function install_powershell {
	#Install-PackageProvider -Name Nuget -MinimumVersion 2.8.5.201 –Force
	try {
		Install-Module -Name PSScriptAnalyzer -Force
		Install-Module -Name PowerShell-Beautifier -RequiredVersion 1.2.3 -Force
		# try {
		# 	cd "$HOME\.vim"
		# 		git clone --depth=1 --recursive https://github.com/PowerShell/PowerShellEditorServices.git
		# 		cd PowerShellEditorServices
		# 		Install-Module InvokeBuild -Scope CurrentUser -Force
		# 		Invoke-Build Build
		# } catch {
		# 	Write-Output "Cannot install PowerShellEditorServices." | Failure-Output
		# }
		Write-Output "Installed the PowerShell Extension components successfully." | Success-Output
	} catch {
		Call-Manager psscriptanalyzer
		Write-Output "Installed the PowerShell Extension components successfully." | Success-Output
	}
	# References:
	# 	[https://github.com/PowerShell/PSScriptAnalyzer]
	# 	[https://github.com/yatli/coc-powershell]
}
function Add-PathVar {
	param([string]$path)

	# (1) Add to PATH During this session (to prevent from having to restart the terminal.
	$env:Path += ";$path"

	# (2) Add to PATH Permanently
	[Environment]::SetEnvironmentVariable(
    "Path",
    [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::Machine) + ";$path",
    [EnvironmentVariableTarget]::Machine)
	# Reference: [https://stackoverflow.com/questions/714877/setting-windows-powershell-environment-variables#1333717]
}

# ===========================================
# File Management Functions
# ===========================================
function Detection-Overwrite($dirparam, $Clobber) {
	# param([string]$dirparam, [switch]$Clobber=$false)
	if (Test-Path $dirparam -PathType Leaf -ErrorAction SilentlyContinue) {
		Write-Output "Detected an existing file. Performing backup before overwriting..."
		Write-Output "File: $dirparam"
		try {
			if (Test-Path "$dirparam.backup") {
				echo "Existing backup detected. Deleting the backup before copying..."
				echo "Existing Backup File: $dirparam.backup"
				Remove-Item -Force "$dirparam.backup" -Recurse -ErrorAction Ignore
			}
			Rename-Item -Path "$dirparam" -NewName "$dirparam.backup"
			Write-Output "Created backup of existing file '$dirparam'." | Success-Output
		} catch {
			try {
				Move-Item -Path "$dirparam" -Destination "$dirparam.backup" -Force
			} catch {
				# Do nothing
				Write-Output "Fatal Error: Could not make a backup of the detected file '$dirparam'" | Failure-Output
				exit
			}
		}
		if ( ($Clobber) -or ($PsCmdlet.ParameterSetName -eq "Clobber") ) {
			try {
				Write-Output "Clobbering file '$dirparam'..."
				Remove-Item -Force "$dirparam" -Recurse -ErrorAction Stop
			} catch {
				Write-Output "Failed to delete file '$dirparam'" | Failure-Output
			}
		}
	} elseif (Test-Path $dirparam -PathType Container -ErrorAction SilentlyContinue) {
		Write-Output "Detected an existing directory. Performing backup before overwriting..."
		Write-Output "Directory: $dirparam"
		try {
			if (Test-Path "$dirparam.backup") {
				echo "Existing backup detected. Deleting the backup before copying..."
				echo "Existing Backup Directory: $dirparam.backup"
				try {
					Remove-Item -Force "$dirparam.backup" -Recurse -ErrorAction Stop
				} catch {
					Get-ChildItem "$dirparam" -Recurse | Remove-Item -Force -ErrorAction Ignore
				}
			}
			Rename-Item -Path "$dirparam" -NewName "$dirparam.backup" -ErrorAction Stop
			Write-Output "Created backup of existing directory '$dirparam'." | Success-Output
		} catch {
			try {
				Move-Item -Path "$dirparam" -Destination "$dirparam.backup" -Force
			} catch {
				# Do nothing
				Write-Output "Fatal Error: Could not make a backup of the detected file '$dirparam'" | Failure-Output
				exit
			}
		}
		if ( ($Clobber) -or ($PsCmdlet.ParameterSetName -eq "Clobber") ) {
			try {
				Write-Output "Clobbering directory '$dirparam'..."
				Remove-Item -Force "$dirparam" -Recurse -ErrorAction Stop
			} catch {
				Write-Output "Failed to delete directory '$dirparam'" | Failure-Output
			}
		}
	}
}

# ===========================================
# Installing Dependenices
# ===========================================

# Install Packages
Write-Output "[+] Installing installation dependencies..." | AddTask-Output
# Downloading functions
try {
	Call-Manager git
	git submodule update --init --recursive
} catch {
	Write-Output "[*] Could not install git." | Failure-Output
	Write-Output $_
}
try {
	Call-Manager curl
} catch {
	Write-Output "[*] Could not install curl." | Failure-Output
	Write-Output $_
}
# Vim Plugin Manager
cd $HOME
try {
		$dir = "$HOME\.vim"
		Detection-Overwrite "$dir" clobber
		New-Item -Path "$dir" -ItemType Directory -Force

		Detection-Overwrite "$dir\bundle" clobber
		New-Item -Path "$dir\bundle" -ItemType Directory -Force

	if ($OPTPLUGINMANAGER -eq 'Vundle') {
		$dir_vundle = "$HOME\.vim\bundle\Vundle.vim"
		# Remove the directory, if it exists, before trying to clone to it -- [/cr/90372]
		Detection-Overwrite "$dir_vundle" clobber
		git clone https://github.com/VundleVim/Vundle.vim.git "$dir_vundle"
	} elseif ($OPTPLUGINMANAGER -eq 'vim-plug') {
		$dir_vimplug = "$HOME\.vim\autoload"
		# $dir_vimplug_bundle = "$HOME\.vim\bundle"
		try {
			#md $dir_vimplug
			New-Item -Path "$dir_vimplug" -ItemType Directory -Force
			#md $dir_vimplug_bundle
			# New-Item -Path $dir_vimplug_bundle -ItemType Directory -Force
			$uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
			(New-Object Net.WebClient).DownloadFile(
					$uri,
					$ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
						"$HOME\.vim\autoload\plug.vim"
						)
					)
		} catch {
			Write-Output "Could not install Vim-Plug. Please manually create the autoload directory: '$dir_vimplug'" | Failure-Output
		}
	}
} catch {
	Write-Output "[*] Could not install Vim Package Manager." | Failure-Output
	Write-Output $_
}

# Install Python
#	Reference: https://github.com/ycm-core/youcompleteme#full-installation-guide
#		Reference: https://github.com/ycm-core/YouCompleteMe/wiki/Windows-Installation-Guide
#	Reference: https://stackoverflow.com/questions/18693526/vim-completion-with-youcompleteme-on-windows
#		Reference: https://stackoverflow.com/questions/18801354/c-family-semantic-autocompletion-plugins-for-vim-using-clang-clang-complete-yo/18876388#18876388
#		Reference: https://bitbucket.org/Alexander-Shukaev/vim-youcompleteme-for-windows
#	Reference: https://stackoverflow.com/questions/35597157/gvim-crashes-when-running-python/35620795#35620795
#		let $PYTHONPATH = "C:\\Python27\\Lib;C:\\Python27\\DLLs;C:\\Python27\\Lib\\lib-tk"
#	or	let $PYTHONPATH="C:\\Python\\lib"
#	Reference: https://stackoverflow.com/questions/32025090/vim-for-windows-python-doesnt-load-properly-crashes?noredirect=1&lq=1
#	Reference: https://vi.stackexchange.com/questions/14598/drawbacks-of-using-python-to-develop-new-code-in-a-vim-plugin
#	Reference: https://stackoverflow.com/questions/23023783/vim-compiled-with-python-support-but-cant-see-sys-version
#	Reference: https://askubuntu.com/questions/585237/whats-the-easiest-way-to-get-vim-with-python-3-support
#	Reference: https://stackoverflow.com/questions/21903246/using-both-python-2-and-3-in-vim-on-windows
#Call-Manager python3
# YouCompleteMe only works with Python 2, and the architecture of the package has to match that of Vim (all 64-bit)
Call-Manager python2
# Install python dependencies
try {
	Write-Output "[+] Installing Python dependencies..." | AddTask-Output
	# Refresh the environmental variables of cmd first to increase the likelihood Python will be detected in the PATH variable...
	Call-Manager-Refresh
	# Try to upgrade PIP
	try {
		python -m pip install --upgrade pip
	} catch {
		Write-Output "[*] Could not update Python pip." | Failure-Output
		Write-Output $_
	}
	# Start installing via PIP
	pip install pep8
	pip install flake8
	pip install jedi
	# Dependency for neovim on Windows: pynvim
	pip install pynvim
} catch {
	Write-Output "[*] Could not install python dependencies." | Failure-Output
	Write-Output $_
}

if ($OPTAUTOCOMPLETION -eq 'YouCompleteMe') {
	Write-Output "[+] Installing C/C++ dependencies for YouCompleteMe..." | AddTask-Output
	# LLVM: Installs - clang - clang-cl - clangd - clang++ - clang-format - lld - llvm-objdump
	if (Get-Command llvm -ErrorAction SilentlyContinue) {
		Call-Manager llvm
	}
	# Installs CMake - Dependency of YouCompleteMe
	if (Get-Command cmake -ErrorAction SilentlyContinue) {
		Call-Manager cmake --installargs 'ADD_CMAKE_TO_PATH=System'
	}
	# Install Visual Studio Community Edition 2017 & Desktop development with C++ workload for Visual Studio 2017 - Dependencies of YouCompleteMe
	#	Reference: https://chocolatey.org/packages/VisualStudio2017Community
	#	Reference: https://docs.microsoft.com/en-us/visualstudio/install/use-command-line-parameters-to-install-visual-studio?view=vs-2017
	#	Reference: https://docs.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-community?view=vs-2017
	Call-Manager vcredist140
	Call-Manager visualstudio2017community --norestart --wait --quiet --add Microsoft.VisualStudio.Workload.NativeDesktop
	Call-Manager visualstudio2017-workload-nativedesktop --norestart --includeRecommended --quiet
} elseif ($OPTAUTOCOMPLETION -eq 'coc.nvim') {
	Write-Output "[+] Installing Node.js and Yarn for coc.nvim..." | AddTask-Output
	# Node.JS comes first since Yarn dependends on Node.JS
	Call-Manager nodejs.install
	Call-Manager yarn
}

Write-Output "[+] Installing ctags" | AddTask-Output
# Installs ctags for making tag files (see the TagBar Plugin)
Call-Manager universal-ctags

Write-Output "[+] Installing MinGW (for gdb debugger)" | AddTask-Output
Call-Manager mingw
#	Reference: https://chocolatey.org/packages/mingw

Write-Output "[+] Installing ShellCheck..." | AddTask-Output
Call-Manager shellcheck

Write-Output "[+] Installing LaTeX & Markdown dependencies..." | AddTask-Output
# MuPDF - for viewing LaTeX files
Call-Manager mupdf
# Strawberry Perl - a Windows-only dependency of latexmk, which is a dependency of Vimtex
Call-Manager strawberryperl

Write-Output "[+] Installing external programs which are plugin dependencies..." | AddTask-Output
# Ripgrep - for fast searching with FZF
Call-Manager ripgrep
# Ag  - for fast searching with Ack.vim (the_silver_searcher)
Call-Manager ag
# fzf - a fuzzy file finder
Call-Manager fzf
# lf (list files) - a Windows surrogate for ranger
Call-Manager lf
# Pandoc - for document conversion and can be used by multiple plugins -- Install for all users works to make the PATH available
Call-Manager pandoc --ia=ALLUSERS=1

# Utility -- Install this for the user to circumvent the paid utility -- /su/1371668
Call-Manager choco-cleaner

Write-Output "Dependencies installed successfully" | Success-Output


# ===========================================
# Installing Vim
# ===========================================
# This installs both Vim and gVim -- Installing Vim after installing its dependencies ensures the correct settings are built/configured on Windows.
# The specific benefit of this package is that it provides what most distros consider the full `gvim`. Chocolatey's `vim` package should more accurately be called `vim-minimal`; it doesn't have any of the bindings to python, tcl, ruby, lua, perl, etc. AFAIK this can only be properly done by way of vcredist libraries.
Call-Manager vim-tux.install /InstallPopUp /RestartExplorer

# Install Neovim via Package Manager
Call-Manager neovim


# ===========================================
# Making _vimrc
# ===========================================
Write-Output "=== Building _vimrc ==="

Write-Output "[+] Compiling the _vimrc file..." | AddTask-Output
# Concatenate the vimrcs files together -- [/so/8749929]
try {
	Write-Output "Root: $SCRIPTROOT"
	Write-Output "Group: $OPTGROUP"
	Write-Output "Level: $OPTLEVEL"
	Write-Output "Auto-completion: $OPTAUTOCOMPLETION"
	Write-Output "Plugin-manager: $OPTPLUGINMANAGER"
	# Append files to form the final _vimrc
	# (1) Settings
	Add-Content -Path "$SCRIPTROOT\build\_vimrc" -Encoding UTF8 -Value '"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""'
	Add-Content -Path "$SCRIPTROOT\build\_vimrc" -Encoding UTF8 -Value '" === SETTINGS                                                 '
	Add-Content -Path "$SCRIPTROOT\build\_vimrc" -Encoding UTF8 -Value '"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""'
	Add-Content -Path "$SCRIPTROOT\build\_vimrc" -Encoding UTF8 -Value '" === VimSetup-Specific Settings:                              '
	Add-Content -Path "$SCRIPTROOT\build\_vimrc" -Encoding UTF8 -Value '" Level: Basic vs Full                                         '
	if ($OPTLEVEL -eq 'full') {
		Add-Content -Path "$SCRIPTROOT\build\_vimrc" -Encoding UTF8 -Value "let g:vimsetup_level = 'full'"
	} elseif ($OPTLEVEL -eq 'basic') {
		Add-Content -Path "$SCRIPTROOT\build\_vimrc" -Encoding UTF8 -Value "let g:vimsetup_level = 'basic'"
	}
	Add-Content -Path "$SCRIPTROOT\build\_vimrc" -Encoding UTF8 -Value ""
	#	(2) Header
	cat "$SCRIPTROOT\vimrcs\vimrc_header.vim" | Out-File -Filepath "$SCRIPTROOT\build\_vimrc" -Encoding UTF8 -Append
	#	(3) Packagelist - Select by plugin manager
	if ($OPTPLUGINMANAGER -eq 'Vundle') {
		Get-Content "$SCRIPTROOT\vimrcs\vimrc_packagelist.vim" | Out-File -Filepath "$SCRIPTROOT\build\_vimrc" -Encoding UTF8 -Append
	} elseif ($OPTPLUGINMANAGER -eq 'vim-plug') {
		Get-Content "$SCRIPTROOT\vimrcs\vimrc_packagelist.vim-plug.vim" | Out-File -Filepath "$SCRIPTROOT\build\_vimrc" -Encoding UTF8 -Append
	}
	# (4) Auto-Completion - Write Auto-Completion mechanism to the end of the packagelist based on the appropriate package manager
	if ($OPTAUTOCOMPLETION -eq 'YouCompleteMe') {
		Add-Content -Path "$SCRIPTROOT\build\_vimrc" -Encoding UTF8 -Value ""
		Add-Content -Path "$SCRIPTROOT\build\_vimrc" -Encoding UTF8 -Value '" === Auto-Completion === '
		Add-Content -Path "$SCRIPTROOT\build\_vimrc" -Encoding UTF8 -Value '" --- YouCompleteMe (YCM) & Dependencies'
		if ($OPTPLUGINMANAGER -eq 'Vundle') {
			Add-Content -Path "$SCRIPTROOT\build\_vimrc" -Encoding UTF8 -Value "Plugin 'ycm-core/YouCompleteMe'"
			Add-Content -Path "$SCRIPTROOT\build\_vimrc" -Encoding UTF8 -Value "	Plugin 'rdnetto/YCM-Generator'"
		} elseif ($OPTPLUGINMANAGER -eq 'vim-plug') {
			Add-Content -Path "$SCRIPTROOT\build\_vimrc" -Encoding UTF8 -Value "Plug 'ycm-core/YouCompleteMe'"
			Add-Content -Path "$SCRIPTROOT\build\_vimrc" -Encoding UTF8 -Value "	Plug 'rdnetto/YCM-Generator'"
		}
		Add-Content -Path "$SCRIPTROOT\build\_vimrc" -Encoding UTF8 -Value "	let g:vimsetup_autocompletion='YouCompleteMe'"
		Add-Content -Path "$SCRIPTROOT\build\_vimrc" -Encoding UTF8 -Value ""
	} elseif ($OPTAUTOCOMPLETION -eq 'coc.nvim') {
		Add-Content -Path "$SCRIPTROOT\build\_vimrc" -Encoding UTF8 -Value ""
		Add-Content -Path "$SCRIPTROOT\build\_vimrc" -Encoding UTF8 -Value '" === Auto-Completion === '
		Add-Content -Path "$SCRIPTROOT\build\_vimrc" -Encoding UTF8 -Value '" --- coc.nvim & Dependencies'
		if ($OPTPLUGINMANAGER -eq 'Vundle') {
			Add-Content -Path "$SCRIPTROOT\build\_vimrc" -Encoding UTF8 -Value "Plugin 'neoclide/coc.nvim'"
		} elseif ($OPTPLUGINMANAGER -eq 'vim-plug') {
			Add-Content -Path "$SCRIPTROOT\build\_vimrc" -Encoding UTF8 -Value "Plug 'neoclide/coc.nvim'"
		}
		Add-Content -Path "$SCRIPTROOT\build\_vimrc" -Encoding UTF8 -Value "	let g:vimsetup_autocompletion='coc.nvim'"
		# Add-Content -Path "$SCRIPTROOT\build\_vimrc" -Encoding UTF8 -Value "	let g:coc_global_extensions = [ 'coc-json', 'coc-python', 'coc-git', 'coc-tsserver', 'coc-eslint', 'coc-snippets' ]"
		Add-Content -Path "$SCRIPTROOT\build\_vimrc" -Encoding UTF8 -Value ""
	}
	# (5) Footer - Append files to form the final _vimrc
	Get-Content "$SCRIPTROOT\vimrcs\vimrc_footer.vim" | Out-File -Filepath "$SCRIPTROOT\build\_vimrc" -Encoding UTF8 -Append

	Write-Output "_vimrc compiled successfully." | Success-Output
} catch {
	Write-Output "[*] Could not compile the _vimrc file." | Failure-Output
	Write-Host $_
	Write-Output "IMPORTANT: Please rerun this script to rebuild and install this file." | Failure-Output
}

# Delete the default _vimrc installed on Windows so that Vim searches for it in $HOME\_vimrc instead -- [/so/20138054] , [/su/86246] , [/so/10921441] , [https://www.windows-commandline.com/powershell-delete-files/]
try {
	if (Test-Path "$Env:ProgramFiles\Vim\_vimrc") {
		Remove-Item -Path "$Env:ProgramFiles\Vim\_vimrc" -Force
	}
	if (Test-Path "$Env:ProgramFiles(x86)\Vim\_vimrc") {
		Remove-Item -Path "$Env:ProgramFiles(x86)\Vim\_vimrc" -Force
	}
	Write-Output "Successfully removed the default _vimrc file." | Success-Output
} catch {
	Write-Output "[*] Could not delete the default _vimrc files from 'Program Files\Vim\_vimrc' - Please try manually deleting this file." | Failure-Output
}

# Copy the _vimrc file to the appropriate place.
Write-Output "[+] Copying over the _vimrc file..." | AddTask-Output
try {
	# Reference: /so/8749929
	cat "$SCRIPTROOT\build\_vimrc" | Set-Content "$HOME\_vimrc"
	Write-Output "_vimrc copied successfully." | Success-Output
} catch {
	Write-Output "[*] Could not copy _vimrc file to its appropriate location." | Failure-Output
	Write-Host $_
	Write-Output "IMPORTANT: Please rerun this script to rebuild and install this file." | Failure-Output
	$StopScript = Read-Host -Prompt ' [Hit Ctrl+C to Quit]'
}

# Reserve a placeholder for runtime.*.vim files before they're made (so that installing plugins doesn't break since the runtime path to the runtime.*.vim files makes Vim use plugins/settings before they're installed)
Write-Output "[+] Reserving a place for the runtime.*.vim files..." | AddTask-Output
try {
	$dir = "$HOME\.vim_runtime"
	if (Test-Path $dir) {
		Detection-Overwrite $dir clobber
		Remove-Item -Path $dir -Force -Recurse
	}
	New-Item -Path $dir -ItemType Directory

	Detection-Overwrite "$dir\runtime.basic.vim"
	Detection-Overwrite "$dir\runtime.extended.vim"
	New-Item -Path "$dir\runtime.basic.vim" -ItemType File
	# Set these basic settings since these will stop the installation due to the possibility of certain plugins (YouCompleteMe and vim-session)
	Add-Content -Path "$dir\runtime.basic.vim" -Encoding UTF8 -Value ""
	Add-Content -Path "$dir\runtime.basic.vim" -Encoding UTF8 -Value "set encoding=utf-8"
	Add-Content -Path "$dir\runtime.basic.vim" -Encoding UTF8 -Value "let g:session_autosave = 'no'"
	Add-Content -Path "$dir\runtime.basic.vim" -Encoding UTF8 -Value "let g:vimsetup_platform = 'win'"
	Add-Content -Path "$dir\runtime.basic.vim" -Encoding UTF8 -Value ""
	New-Item -Path "$dir\runtime.extended.vim" -ItemType File

	Write-Output "runtime.*.vim files reserved successfully" | Success-Output
} catch {
	Write-Output "[*] Could not reserve runtime.*.vim files in the destination directory '$dir'." | Failure-Output
	Write-Host $_
	Write-Output "IMPORTANT: Please rerun this script to rebuild and install this file." | Failure-Output
	$StopScript = Read-Host -Prompt ' [Hit Ctrl+C to Quit]'
}

echo ''

# ===========================================
# Copying Assets
# ===========================================

Write-Output "=== Copying Assets ==="
Write-Output ''

Write-Output "Copying the ctags Configuration File ==="
try {
	Write-Output "[+] Installing ctags' configuration file..." | AddTask-Output
	Detection-Overwrite "$HOME\.ctags" clobber
	# Vim-specific ctags Configuration File
	# Copy files
	Copy-Item -Path "$SCRIPTROOT\assets\.ctags" -Destination "$HOME\" -Force -Recurse
	# Credit & Reference: https://andrew.stwrt.ca/posts/vim-ctags/

	Write-Output "ctags setup successfully." | Success-Output
} catch {
	Write-Output "[*] Could not copy ctags configuration file." | Failure-Output
}
echo ''

echo "Copying Plugin Settings ==="
try {
	Write-Output "[+] Installing plugin settings..." | AddTask-Output

	Detection-Overwrite "$HOME\.vim_runtime\settings_plugins" clobber
	Copy-Item -Path "$SCRIPTROOT\assets\settings_plugins" -Destination "$HOME\.vim_runtime\" -Force -Recurse

	Write-Output "Plugin Settings: installed successfully."
} catch {
	Write-Output "[*] Could not copy plugin settings directory." | Failure-Output
}
echo ''

echo "Copying Snippets ==="

# === UltiSnips
Write-Output "UltiSnips: "
try {
	Write-Output "[+] Setting up snippets installation..." | AddTask-Output

	# Make the directory then copy it as a safe option.
	Detection-Overwrite "$HOME\.vim\plugin_ultisnips"
	New-Item -Path "$HOME\.vim\plugin_ultisnips" -ItemType Directory

	# Pull down the latest UltiSnips snippets -- [https://askubuntu.com/a/729798]
	Write-Output "[+] Installing default vim-snippets to the Ultisnips directory..." | AddTask-Output
	cd "$HOME\.vim"
	git clone --depth 1 https://github.com/honza/vim-snippets.git plugin_ultisnips
	cd plugin_ultisnips
	git filter-branch --prune-empty --subdirectory-filter UltiSnips HEAD

	Write-Output "Installed default vim-snippets successfully." | Success-Output

# Snippets
	Write-Output "[+] Installing snippets..." | AddTask-Output
	# Copy assets, overwriting files with the same names.
	Copy-Item -Path "$SCRIPTROOT\assets\plugin_ultisnips" -Destination "$HOME\.vim\" -Force -Recurse

	Write-Output "Snippets installed successfully." | Success-Output
	echo ''
} catch {
	Write-Output "[*] Could not create snippets." | Failure-Output
	Write-Output $_
}
# === User-Specific/Personal Snippets
try {
	Write-Output "[+] Setting up a user-specific personal snippets directory..." | AddTask-Output
	New-Item -Path "$HOME\.vim\user_snippets" -ItemType Directory
	# No overwriting, if it exists let this fail...
} catch {
	Write-Output "Could not create a personal user snippet directory. Consider creating this manually instead." | Failure-Output
}
cd $SCRIPTROOT

echo ''

Write-Output "Copying filetype directories ===" | AddTask-Output
try {
	Write-Output "[+] Installing ftdetect directory..."
	Detection-Overwrite "$HOME\.vim\ftdetect"
	Copy-Item -Path "$SCRIPTROOT\assets\ftdetect" -Destination "$HOME\.vim\" -Force -Recurse

	Write-Output "[+] Installing ftplugin directory..."
	Detection-Overwrite "$HOME\.vim\ftplugin"
	Copy-Item -Path "$SCRIPTROOT\assets\ftplugin" -Destination "$HOME\.vim\" -Force -Recurse

	Write-Output "Filetype directories installed successfully" | Success-Output
} catch {
	Write-Output "[*] Could not install snippet" | Failure-Output
	Write-Output $_
}

echo ''


# ===========================================
# Plugin Settings
# ===========================================

Write-Output "=== Setting up Plugins ==="

Write-Output "[+] Setting up Temporary Directories: Persistent Undo buffer, backup, swap, and ctags..." | AddTask-Output
try {
	Detection-Overwrite "$HOME\.vim\temp_dirs"
	New-Item -Path "$HOME\.vim\temp_dirs" -ItemType Directory -Force
	New-Item -Path "$HOME\.vim\temp_dirs\undo" -ItemType Directory -Force
	New-Item -Path "$HOME\.vim\temp_dirs\backup" -ItemType Directory -Force
	New-Item -Path "$HOME\.vim\temp_dirs\swap" -ItemType Directory -Force
	New-Item -Path "$HOME\.vim\temp_dirs\ctags" -ItemType Directory -Force
	Write-Output "Installed temporary directories successfully." | Success-Output
} catch {
	Write-Output "[*] Could not create/install temporary directories to target directory." | Failure-Output
	Write-Output $_
}

# Plugins
Write-Output "[+] Installing vim plugins..." | AddTask-Output
try {
	if ($OPTPLUGINMANAGER -eq 'Vundle') {
		vim +PluginInstall +qall
	} elseif ($OPTPLUGINMANAGER -eq 'vim-plug') {
		vim "+PlugInstall --sync" +qall
	}
	echo "Plugins installed successfully."
} catch {
	Write-Output "[*] Could not start vim to install plugins." | Failure-Output
	Write-Output $_
}
	# Plugin: Vim-Prettier
	try {
		if ($OPTPLUGINMANAGER -eq 'Vundle') {
			# Setup Vim-Prettier if the plugin was specified since Vundle can't do this on its own
			if (Test-Path "$HOME\.vim\bundle\vim-prettier") {
				cd "$HOME\.vim\bundle\vim-prettier"
				if (Get-Command "yarnpkg" -ErrorAction SilentlyContinue) {
					yarnpkg install --frozen-lockfile
				} else {
					yarn install --frozen-lockfile
				} # References: -- [/so/11242368]
			}
			Write-Output "Vim-Prettier plugin installed successfully." | Success-Output
		}
	} catch {
		Write-Output "[*] Could not install vim-prettier." | Failure-Output
		Write-Output $_
	}

# Auto-Completion
if ($OPTAUTOCOMPLETION -eq 'YouCompleteMe') {
	try {
		# (1) Configuring Language Support
		Write-Output "Determining Language Support for YouCompleteMe (YCM)..." | AddTask-Output
		try {
			$YCM_FLAGS=""
			if ($OPT_INSTALLALL) {
				$YCM_FLAGS = "--all"
			} else {
				# Install the language runtimes and their dependies, then set the flag for YouCompleteMe to install language support for these languages.
				if ($OPT_INSTALLRUST) {		$YCM_FLAGS="$YCM_FLAGS --rust-completer";	install_rust; setup_rust; }
				if ($OPT_INSTALLGO) {		$YCM_FLAGS="$YCM_FLAGS --go-completer"; 	install_go; }
				if ($OPT_INSTALLCLANG) {	$YCM_FLAGS="$YCM_FLAGS --clang-completer"; 	install_clang; }
				if ($OPT_INSTALLCLANGD) {	$YCM_FLAGS="$YCM_FLAGS --clangd-completer";	install_clangd; }
				if ($OPT_INSTALLCSHARP) {	$YCM_FLAGS="$YCM_FLAGS --cs-completer"; 	install_csharp; }
				if ($OPT_INSTALLJS) {		$YCM_FLAGS="$YCM_FLAGS --ts-completer"; 	install_nodejs; }
				if ($OPT_INSTALLJAVA) {		$YCM_FLAGS="$YCM_FLAGS --java-completer"; 	install_java; }
			}
			Write-Output "Configured language support for YouCompleteMe successfully." | Failure-Output
		} catch {
				Write-Output "Errors configuring language support for YouCompleteMe." | Failure-Output
		}
		# (2) Installation
		try  {
			Write-Output "[+] Setting up YouCompleteMe (YCM)..." | AddTask-Output
			# Must have CMake added to PATH before installing YCM via python will work
			cd "$HOME\.vim\bundle\YouCompleteMe"
			python install.py --clang-completer $YCM_FLAGS
			Write-Output "Plugin YouCompleteMe installed successfully." | Success-Output
		} catch {
			Write-Output "Error occurred while installing YouCompleteMe." | Failure-Output
		}
		# (3) Configuration
		# To solve the following error: "NoExtraConfDetected: No .ycm_extra_conf.py file detected, so no compile flags are available. Thus no semantic support for C/C++/ObjC/ObjC++. Go READ THE DOCS *NOW..."...
		#	Go here: https://github.com/ycm-core/YouCompleteMe#option-1-use-a-compilation-database
		Write-Output "Configuring YouComplteMe (YCM)..." | AddTask-Output
		try {
			New-Item -Path "$HOME\.vim\plugin_YouCompleteMe" -ItemType Directory -Force
			New-Item -Path "$HOME\.vim\plugin_YouCompleteMe\buildflags" -ItemType Directory -Force
			New-Item -Path "$HOME\.vim\plugin_YouCompleteMe\buildflags\ycm_global_ycm_extra_conf.py" -ItemType File -Force
			# Keep misalignment here to preserve Python's spaced indentation requirements...
			echo "def Settings( **kwargs ):
		  return {
			'flags': [ '-x', 'c++', '-Wall', '-Wextra', '-Werror' ],
		  }" | Out-File "$HOME\.vim\plugin_YouCompleteMe\buildflags\ycm_global_ycm_extra_conf.py" -Encoding UTF8 -Force
			# Write-Output "YouCompleteMe installed successfully." | Success-Output
			Write-Output "Plugin Settings setup complete." | Success-Output
		} catch {
			Write-Output "Could not configure YouCompleteMe -- consider configuring it manually and referring to its documentation."
		}
	} catch {
		Write-Output "[*] Could not install YouCompleteMe." | Failure-Output
		Write-Output $_
	}
} elseif ($OPTAUTOCOMPLETION -eq 'coc.nvim') {
	Write-Output "[+] Setting up coc.nvim..." | AddTask-Output

	# (1) coc.nvim Executable and Settings - Install
	try {
		# Must have yarn to compile coc.nvim
		cd "$HOME\.vim\bundle\coc.nvim"
		try {
			if (Get-Command "yarnpkg" -ErrorAction SilentlyContinue) {
				yarnpkg install --frozen-lockfile
			} else {
				yarn install --frozen-lockfile
			} # References: -- [/so/11242368]
			# Restart the RPC & Install coc.nvim Extensions
			vim "+call coc#rpc#restart()" +qall
			vim -c 'CocInstall -sync coc-git|q'
			vim -c 'CocInstall -sync coc-snippets|q'
			vim -c 'CocInstall -sync coc-pairs|q'
			vim -c 'CocInstall -sync coc-lists|q'
			vim -c 'CocInstall -sync coc-highlight|q'
		} catch {
			Write-Output "Installing coc.nvim from source code failed. Attempting to install via precompiled binary instead..." | Failure-Output
			# To install via binary instead:
			vim "+call coc#util#install()" +qall
		}

		# Create the coc-settings.json file...
		# Copy assets, overwriting files with the same names.
		try {
			# $dir_cocsettings = "$HOME\vimfiles\coc-settings.json"
			# $dir_cocsettings_path = "$HOME\vimfiles\"
			# $dir_cocsettings_win = "$HOME\vimfiles\coc-settings.windows.json"
			$dir_cocsettings = "$HOME\.vim\coc-settings.json"
			$dir_cocsettings_path = "$HOME\.vim\"
			$dir_cocsettings_win = "$HOME\.vim\coc-settings.windows.json"
			# If it exists already, rename it/back it up first. (If that doesn't work/there is already a backup, delete it.)
			try {
				if (Test-Path $dir_cocsettings) {
					try {
						Rename-Item -Path $dir_cocsettings -NewName "coc-settings.json.backup"
						Write-Output "Renamed existing settings to '*.backup'."
					} catch {
						Remove-Item -Force "$dir_cocsettings.backup" -ErrorAction Ignore
						Write-Output "Deleted existing settings backup."
						Rename-Item -Path $dir_cocsettings -NewName "coc-settings.json.backup"
						Write-Output "Performed a backup of existing settings."
					}
				} else {
					Write-Output "No existing coc-settings.json detected."
				}
			} catch {
				Write-Output "Unable to remove existing coc-settings file: $dir_cocsettings" | Failure-Output
			}
			Remove-Item -Force $dir_cocsettings_win -ErrorAction Ignore
			Copy-Item -Path "$SCRIPTROOT\assets\coc-settings.windows.json" -Destination $dir_cocsettings_path -Force -Recurse
			Rename-Item -Path $dir_cocsettings_win -NewName "coc-settings.json"
			Write-Output "Copied coc-settings.json file successfully." | Success-Output
		} catch {
			Write-Output "[*] Could not properly configure coc.nvim: Failed to copy coc-settings.json file." | Failure-Output
			Write-Output $_
		}
		# References: https://github.com/phux/.dotfiles/blob/master/roles/neovim/files/conf/coc-settings.json
		Write-Output "coc.nvim installation complete." | Success-Output
	} catch {
		Write-Output "[*] Could not install coc.nvim." | Failure-Output
		Write-Output $_
	}

	# (2) coc.nvim Extensions - Install
	# ...

	# Language Servers - Install
		# Shell
		try {
			if ($OPT_INSTALLALL -or $OPT_INSTALLBASHLS) {
				install_bashls
				bash-language-server.cmd --version
				Write-Output "Installed the Bash Language Server successfully." | Success-Output
			}
		} catch {
			Write-Output "Could not install the bash language server. Consider installing this manually." | Failure-Output
		}
		# Rust
		try {
			if (!Get-Command rustup -ErrorAction SilentlyContinue -and ($iall -or $installall -or $irs -or $installrust) ) {
				install_rust
				rustc --version
			}
			if (Get-Command rustup -ErrorAction SilentlyContinue) {
				setup_rust
				# Install coc-rls
				vim -c 'CocInstall -sync coc-rls|q'
				vim -c 'CocInstall -sync coc-rust-analyzer|q'
				Write-Output "Installed Rust language server dependencies successfully." | Success-Output
			}
		} catch {
			Write-Output "Could not install RustUp, a dependency of the Rust Language Server" | Failure-Output
		}
		# Go
		try {
			if (!Get-Command go -ErrorAction SilentlyContinue -and ($iall -or $installall -or $igo -or $installgo) ) {
				install_go
				go version
			}
			if (Get-Command go -ErrorAction SilentlyContinue) {
				try {
					go get -u github.com/sourcegraph/go-langserver
				} catch {
					go get golang.org/x/tools/gopls@latest
				}
				vim -c 'CocInstall -sync coc-go|q'
				Write-Output "Installed Go language server dependencies successfully." | Success-Output
			}
		} catch {
			Write-Output "Could not install the GoLang language dependency." | Failure-Output
		}
		# C/C++ (ClangD) -- Easier to install; Faster
		try {
			if (!Get-Command clangd -ErrorAction SilentlyContinue -and ($iall -or $installall -or $icl -or $installclangd) ) {
				# Installs: clang, clangd, clang-format
				install_clangd
				# Install this if this was not previously installed or installed by the YouCompleteMe option.
				Write-Output "Installed ClangD language dependencies successfully." | Success-Output
			}
		} catch {
			Write-Output "Could not install the 'clangd' C/C++ Language dependencies." | Failure-Output
		}
		# C/C++ (CCLS) -- More features; Slower
		try {
			if ($icc -or $installccls) {
				install_ccls
			}
		} catch {
			Write-Output "Could not install the 'ccls' C/C++ Language Server." | Failure-Output
		}
		# Python
		try {
			if ($iall -or $installall -or $ipy -or $installpython) {
				install_python
			}
			if (Get-Command pip -ErrorAction SilentlyContinue) {
				# If pip, and by proxy python, are installed (or were installed with the python install flags), install the python language server.
				pip install --user 'python-language-server[all]'
				#Call-Manager python-language-server

				# Install Linters
				sudo pip install --user autopep8
				sudo pip install --user pylint
				# sudo pip install --user yapf
				vim -c 'CocInstall -sync coc-python|q'
				Write-Output "Installed python language server successfully." | Success-Output
			} else {
				Write-Output "Pip not installed. skipping installation of Python."
			}
		} catch {
			Write-Output "Could not install language server 'python-language-server'. Consider installing it manually." | Failure-Output
		}
		# PHP
		try {
			if ($iall -or $installall -or $iph -or $installphp) {
				install_nodejs
				npm install intelephense -g
				Write-Output "Installation of Intelephense language server successful." | Success-Output
			}
		} catch {
			Write-Output "Could not install coc.nvim extension: PHP" | Failure-Output
		}
		# Ruby
		try {
			if ($iall -or $installall -or $irb -or $installruby) {
				install_ruby
			}
			if (Get-Command gem -ErrorAction SilentlyContinue) {
				gem install solargraph
				Write-Output "Installation of Ruby language server successful." | Success-Output
			} else {
				Write-Output "No Ruby (Gem) installation detected in PATH. Skipping SolarGraph installation."
			}
		} catch {
			Write-Output "Could not install coc.nvim extension: Ruby" | Failure-Output
		}
		# Vim, eruby, and markdown - EFM Language Server
		try {
			if($iall -or $installall -or $ivi -or $installvim -or $irb -or $installruby -or $imd -or $installmarkdown) {
				install_go
			}
			if($ivi -or $installvim) {
				vim -c 'CocInstall -sync coc-vimlsp|q'
			}
			if($ivi -or $installvim -or $irb -or $installruby -or $imd -or $installmarkdown) {
				if (!Get-Command go -ErrorAction SilentlyContinue) {
					Write-Output "No Go installation detected in PATH." | Failure-Output
				} else {
					Write-Output "Go detected."
					# Prepare to install configuration file
					try {
						New-Variable -Name "efmPATH" -Value "$($env:APPDATA)\efm-langserver"
						New-Variable -Name "efmPATHcfg" -Value "$($env:APPDATA)\efm-langserver\config.yaml"
						New-Item -Path $efmPATH -ItemType Directory -Force
					} catch {
						Write-Output "Could not create configuration directory for efm-langserver." | Failure-Output
					}
					# Copy the configuration file
					try {
						Copy-Item -Path "$SCRIPTROOT\assets\plugin_cocnvim\config.efm-langserver.yaml" -Destination "$efmPATH" -Force -Recurse
					} catch {
						Write-Output "Could not insert configuration into config directory." | Failure-Output
					}
					# Install efm-langserver
					try {
						go get "https://github.com/mattn/efm-langserver/cmd/efm-langserver"
					} catch {
						Write-Output "Could not install efm-langserver via go." | Failure-Output
					}
					# Install Linters:
					# (1) HTMLBeautifier - eruby linter
					if (Get-Command gem -ErrorAction SilentlyContinue) {
						# For HTML
						gem install htmlbeautifier
						Write-Output "Installation of HTMLBeautifier successful." | Success-Output
						# For SCSS
						gem install compass
						Write-Output "Installation of compass successful." | Success-Output
					} else {
						Write-Output "Could not install HTMLBeautifier and/or compass."
					}
					# (2) vint - vim linter
					if (Get-Command pip -ErrorAction SilentlyContinue) {
						pip install vim-vint
						Write-Output "Installation of vint successful." | Success-Output
					} else {
						Write-Output "Could not install vint."
					}
					# (3) yamllint - yaml linter
					if (Get-Command pip -ErrorAction SilentlyContinue) {
						# yamllint - Linting of yaml code
						pip install yamllint
						Write-Output "Installation of vint successful." | Success-Output

						# coc-yaml - Auto-completion of yaml code
						vim -c 'CocInstall -sync coc-yaml|q'
						Write-Output "Installation of coc-yaml successful." | Success-Output
					} else {
						Write-Output "Could not install yamllint and/or coc-yaml."
						# Try installing js-yaml
						sudo npm install -g js-yaml
					}
					# (4) mdk (MarkdowLinter)
					if (Get-Command gem -ErrorAction SilentlyContinue) {
						gem install mdl
						Write-Output "Successfully installed MarkdownLinter (mdl)." | Success-Output
					} else {
						Write-Output "Could not install MarkdownLinter (mdl)..." | Failure-Output
					}
				}
			} else {
				Write-Output 'Skipping EFM Language Server...'
			}
		} catch {
			Write-Output "Could not install the EFM Language Server" | Failure-Output
			Write-Output $_
		}
		# JavaScript: TypeScript Language Server, Vue.js Language Sever
		try {
			if ($iall -or $installall -or $ijs -or $installjs) {
				install_nodejs
				install_js
				typescript-language-server --stdio --version

				vim -c 'CocInstall -sync coc-json|q'
				vim -c 'CocInstall -sync coc-tsserver|q'
				vim -c 'CocInstall -sync coc-eslint|q'
				vim -c 'CocInstall -sync coc-prettier|q'
				vim -c 'CocInstall -sync coc-html|q'
				vim -c 'CocInstall -sync coc-css|q'
				# vim -c 'CocInstall -sync coc-emmet|q'
				# vim -c 'CocInstall -sync coc-angular|q'
				# vim -c 'CocInstall -sync coc-vetur|q'
				# vim -c 'CocInstall -sync coc-ember|q'

				Write-Output "Installation of JavaScript language server components successful." | Success-Output
			}
		} catch {
			Write-Output "Could not install coc.nvim dependencies for JavaScript" | Failure-Output
		}
		# C# (CSharp)
		try {
			if ($iall -or $installall -or $installcsharp -or $ics) {
				install_csharp
			}
			if (command_exists mono) {
				# Install coc-omnisharp
				vim -c 'CocInstall -sync coc-omnisharp|q'
				Write-Output "Installation of Java language server successful." | Success-Output
			}
		} catch {
			Write-Output "Could not install coc.nvim dependencies for C#" | Failure-Output
		}
		# Java
		try {
			if ($iall -or $installall -or $ija -or $installjava) {
				install_java
			}
			if (command_exists java) {
				# Install coc-java
				vim -c 'CocInstall -sync coc-java|q'
				Write-Output "Installation of Java language server successful." | Success-Output
			}
		} catch {
			Write-Output "Could not install coc.nvim dependencies for Java" | Failure-Output
		}
		# LaTeX
		try {
			if ($iall -or $installall -or $ija -or $installjava) {
				install_latex
			}
			if (command_exists latex) {
				vim -c 'CocInstall -sync coc-vimtex|q'
				Write-Output "Installation of MiKTeX successful"
			}
		} catch {
			Write-Output "Could not install coc.nvim dependencies for LaTeX" | Failure-Output
		}
		# Docker
		try {

			if ($iall -or $installall -or $ija -or $installjava) {
				install_nodejs
				npm install -g dockerfile-language-server-nodejs
				Write-Output "Installed dockerfile language server dependencies successfully." | Success-Output
			}
		} catch {
			Write-Output "Could not install the dockerfile language server. Consider installing this manually." | Failure-Output
		}
		# PowerShell
		try {
			if ($iall -or $installall -or $ips -or $installpowershell) {
				install_powershell
			}
			vim -c 'CocInstall -sync coc-powershell|q'
		} catch {
			Write-Output "Could not install the Powershell language server. Consider installing this manually." | Failure-Output
		}
		Write-Output "Plugin settings, language server, and extensions setup complete." | Success-Output
}
echo ''

# ===========================================
# Building runtime.*.vim files
# ===========================================
# Runtime.*.vim files contain _vimrc configurations and all plugin settings and has to be added in after the plugins are installed.
Write-Output "=== Building runtime.*.vim files ==="
cd $SCRIPTROOT
Write-Output "[+] Compiling the runtime.*.vim files" | AddTask-Output
try {
	Remove-Item -Force "$SCRIPTROOT\build\runtime.basic.vim" -Recurse -ErrorAction Ignore
	Remove-Item -Force "$SCRIPTROOT\build\runtime.extended.vim" -Recurse -ErrorAction Ignore
	cat "$SCRIPTROOT\vimrcs\basic.vim" | Set-Content "$SCRIPTROOT\build\runtime.basic.vim"
	cat "$SCRIPTROOT\vimrcs\extended.vim", "$SCRIPTROOT\vimrcs\filetypes.vim", "$SCRIPTROOT\vimrcs\schemes_config.vim" | Set-Content "$SCRIPTROOT\build\runtime.extended.vim"
	Write-Output "runtime.*.vim files compiled successfully." | Success-Output
} catch {
	Write-Output "[*] Could not compile runtime.*.vim files." | Failure-Output
	Write-Host $_
	Write-Output "IMPORTANT: Please rerun this script to rebuild and install this file." | Failure-Output
	$StopScript = Read-Host -Prompt ' [Press Enter to Quit]'
}
# This will fill in the runtime.*.vim file previously reserved when building the .vimrc file
Write-Output "[+] Copying over the runtime.*.vim files..." | AddTask-Output
try {
	cat "$SCRIPTROOT\build\runtime.basic.vim" | Set-Content "$HOME\.vim_runtime\runtime.basic.vim"
	cat "$SCRIPTROOT\build\runtime.extended.vim" | Set-Content "$HOME\.vim_runtime\runtime.extended.vim"
	Write-Output "runtime.*.vim files copied successfully." | Success-Output
} catch {
	Write-Output "[*] Could not copy runtime.*.vim files to their appropriate location." | Failure-Output
	Write-Host $_
	Write-Output "IMPORTANT: Please rerun this script to rebuild and install this file." | Failure-Output
	$StopScript = Read-Host -Prompt ' [Press Enter to Quit]'
}
echo ''


# ===========================================
# Font Installation
# ===========================================

# Function to install fonts -- [/so/16023238]
#	References: https://www.itprotoday.com/scripting/trick-installing-fonts-vbscript-or-powershell-script

Write-Output "[+] Creating fonts directory..." | AddTask-Output
try {
	Detection-Overwrite "$HOME\.vim\fonts"
	New-Item -Path "$HOME\.vim\fonts" -ItemType Directory -Force
	Write-Output "Fonts directory created successfully." | Success-Output
} catch {
	Write-Output "[*] Error: could not create Font directory to install fonts." | Failure-Output
	Write-Output $_
}
cd "$HOME\.vim\fonts"

# Download Fonts -- TODO: Refactor this into a function to download fonts given the filename and URL. -- [/so/2710748] , [/su/344927]
Write-Output "[+] Downloading Font: Hack Regular..." | AddTask-Output
try {
	# Change to SSL/TLS 1.2 to prevent using 1.0 by default, leading to error 'Could not create SSL/TLS secure channel.' -- [/so/41618766]
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
	# Using this newer method requires PowerShell 3.0: Invoke-WebRequest -OutFile "$HOME\.vim\fonts\filename.ttf" https://url
	#	The Method for <= 2.0 was (new-object System.Net.WebClient).DownloadString("url") > "filename") -- This didn't download fonts properly.
	Invoke-WebRequest -OutFile "$HOME\.vim\fonts\Hack Regular Nerd Font Complete Mono Windows Compatible.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete%20Mono%20Windows%20Compatible.ttf
	Invoke-WebRequest -OutFile "$HOME\.vim\fonts\Hack Regular Nerd Font Complete Windows Compatible.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete%20Windows%20Compatible.ttf
	Write-Output "Downloading 'Hack' font succeeded." | Success-Output
} catch {
	Write-Output "[*] Could not install font 'Hack'" | Failure-Output
	Write-Output $_
}

Write-Output "[+] Downloading Font: Droid Sans Mono..." | AddTask-Output
try {
	# Change to SSL/TLS 1.2 to prevent using 1.0 by default, leading to error 'Could not create SSL/TLS secure channel.' -- [/so/41618766]
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

	# Using this newer method requires PowerShell 3.0: Invoke-WebRequest -OutFile "$HOME\.vim\fonts\filename.ttf" https://url
	#	The Method for <= 2.0 was (new-object System.Net.WebClient).DownloadString("url") > "filename") -- This didn't download fonts properly.
	Invoke-WebRequest -OutFile "$HOME\.vim\fonts\Droid Sans Mono Nerd Font Complete Mono Windows Compatible.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete%20Mono%20Windows%20Compatible.otf
	Invoke-WebRequest -OutFile "$HOME\.vim\fonts\Droid Sans Mono Nerd Font Complete Windows Compatible.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete%20Windows%20Compatible.otf
	Write-Output "Downloading 'Droid Sans Mono' font succeeded." | Success-Output
} catch {
	Write-Output "[*] Could not install font 'Droid Sans Mono'" | Failure-Output
	Write-Output $_
}

Write-Output "[+] Downloading Font: FiraCode..." | AddTask-Output
try {
	# Change to SSL/TLS 1.2 to prevent using 1.0 by default, leading to error 'Could not create SSL/TLS secure channel.' -- [/so/41618766]
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

	# Using this newer method requires PowerShell 3.0: Invoke-WebRequest -OutFile "$HOME\.vim\fonts\filename.ttf" https://url
	#	The Method for <= 2.0 was (new-object System.Net.WebClient).DownloadString("url") > "filename") -- This didn't download fonts properly.
	Invoke-WebRequest -OutFile "$HOME\.vim\fonts\Fura Code Regular Nerd Font Complete Mono Windows Compatible.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/complete/Fura%20Code%20Regular%20Nerd%20Font%20Complete%20Mono%20Windows%20Compatible.otf
	Invoke-WebRequest -OutFile "$HOME\.vim\fonts\Fura Code Regular Nerd Font Complete Windows Compatible.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/complete/Fura%20Code%20Regular%20Nerd%20Font%20Complete%20Windows%20Compatible.otf
	Invoke-WebRequest -OutFile "$HOME\.vim\fonts\Fura Code Bold Nerd Font Complete Mono Windows Compatible.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Bold/complete/Fura%20Code%20Bold%20Nerd%20Font%20Complete%20Mono%20Windows%20Compatible.otf
	Invoke-WebRequest -OutFile "$HOME\.vim\fonts\Fura Code Bold Nerd Font Complete Windows Compatible.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Bold/complete/Fura%20Code%20Bold%20Nerd%20Font%20Complete%20Windows%20Compatible.otf
	Invoke-WebRequest -OutFile "$HOME\.vim\fonts\Fura Code Retina Nerd Font Complete Mono Windows Compatible.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Retina/complete/Fura%20Code%20Retina%20Nerd%20Font%20Complete%20Mono%20Windows%20Compatible.otf
	Invoke-WebRequest -OutFile "$HOME\.vim\fonts\Fura Code Retina Nerd Font Complete Windows Compatible.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Retina/complete/Fura%20Code%20Retina%20Nerd%20Font%20Complete%20Windows%20Compatible.otf
	Write-Output "Downloading 'FiraCode' font succeeded." | Success-Output
} catch {
	Write-Output "[*] Could not install font 'FiraCode'" | Failure-Output
	Write-Output $_
}


# Install Fonts
Write-Output "[+] Installing Fonts" | AddTask-Output
try {
	# Reference: [https://deployhappiness.com/installing-fonts-with-powershell/] - Install fonts without editing the registry
	#Font Locations
		#Local Location (temp place to store fonts)
	$LocalPath= "$HOME\.vim\fonts\"

	$FONTS = 0x14
	$objShell = New-Object -ComObject Shell.Application
	$objFolder = $objShell.Namespace($FONTS)

	$Fontdir = dir $LocalPath
	foreach($File in $Fontdir) {
		if ((Test-Path "C:\Windows\Fonts\$File") -eq $False) {
			$objFolder.CopyHere($File.fullname,0x14)
			# Reference: [https://stackoverflow.com/questions/2359372/how-do-i-overwrite-existing-items-with-folder-copyhere-in-powershell#5711383]
		}
	}
	Write-Output "Fonts installed successfully." | Success-Output
} catch {
	Write-Output "[*] Could not install fonts." | Failure-Output
	Write-Output $_
	Write-Output "Please consider manually removing VIMSetup's fonts." | Failure-Output
}

# Install Fonts via Call-Manager
try {
	Call-Manager hackfont
	Call-Manager firacode
	Write-Output "Installed fonts via call-manager successfully." | Success-Output
} catch {
	Write-Output "Fonts could not be installed via call manager." | Failure-Output
}

# Return to Script Root Directory.
cd $SCRIPTROOT


# ===========================================
# Neovim (nvim) Settings
# ===========================================

try {
	# Create the Neovim (nvim) installation directory:
	Write-Output " === Neovim Installation ==="
	Write-Output "[+] Installing neovim..." | AddTask-Output
	Write-Output "Setting up neovim config directory..."

	# Create the nvim directory if it does not yet exist
	if (Test-Path "$HOME\AppData\Local\nvim") {
		Detection-Overwrite "$HOME\AppData\Local\nvim"
		Remove-Item -Force "$HOME\AppData\Local\nvim" -Recurse -ErrorAction Ignore
	}
	Detection-Overwrite "$HOME\AppData\Local\nvim"
	New-Item -Path "$HOME\AppData\Local\nvim" -ItemType Directory -Force

	Write-Output "[+] Setting up init.vim..."
	# Create the init.vim file.
	try {
		Detection-Overwrite "$HOME\AppData\Local\nvim\init.vim"
		# New-Item -Path "$HOME\AppData\Local\nvim\init.vim" -ItemType File -Force
		Copy-Item -Path "$SCRIPTROOT\assets\basic.init.vim" -Destination "$HOME\AppData\Local\nvim\init.vim" -Force -Recurse

		Detection-Overwrite "$HOME\AppData\Local\nvim\ginit.vim"
		# New-Item -Path "$HOME\AppData\Local\nvim\ginit.vim" -ItemType File -Force
		Copy-Item -Path "$SCRIPTROOT\assets\basic.ginit.vim" -Destination "$HOME\AppData\Local\nvim\ginit.vim" -Force -Recurse
	} catch {
		Write-Output "[*] Could not create the init.vim and/or ginit.vim placeholder files for Neovim" | Failure-Output
		Write-Output $_
	}
	### # Set default init.vim that sets neovim to use the same configuration files as vim (this will overwrite init.vim if it already exists in this directory, consistent with a new installation)
	### try {
	### 	# Use Out-File rather than > to ensure UTF-8 encoding -- [/so/18469104]
	### 	Add-Content -Path "$HOME\AppData\Local\nvim\init.vim" -Encoding UTF8 -Value '" Neovim Configuration for Python'
	### 	Add-Content -Path "$HOME\AppData\Local\nvim\init.vim" -Encoding UTF8 -Value '	let g:python3_host_prog="$HOME/Envs/neovim3/Scripts/python.exe"'
	### 	Add-Content -Path "$HOME\AppData\Local\nvim\init.vim" -Encoding UTF8 -Value '	let g:python_host_prog="$HOME/Envs/neovim/Scripts/python.exe"'
	### 	Add-Content -Path "$HOME\AppData\Local\nvim\init.vim" -Encoding UTF8 -Value ''
	### 	Add-Content -Path "$HOME\AppData\Local\nvim\init.vim" -Encoding UTF8 -Value '" Setting RuntimePath'
	### 	Add-Content -Path "$HOME\AppData\Local\nvim\init.vim" -Encoding UTF8 -Value '	set runtimepath^=~\.vim'
	### 	Add-Content -Path "$HOME\AppData\Local\nvim\init.vim" -Encoding UTF8 -Value '	set runtimepath+=~\.vim\after'
	### 	Add-Content -Path "$HOME\AppData\Local\nvim\init.vim" -Encoding UTF8 -Value '	let &packpath = &runtimepath'
	### 	Add-Content -Path "$HOME\AppData\Local\nvim\init.vim" -Encoding UTF8 -Value '	source $HOME\_vimrc'
	### 	Add-Content -Path "$HOME\AppData\Local\nvim\init.vim" -Encoding UTF8 -Value 'let g:coc_config_home = "~/.vim"'
	### 	Add-Content -Path "$HOME\AppData\Local\nvim\init.vim" -Encoding UTF8 -Value ''
	### 	Add-Content -Path "$HOME\AppData\Local\nvim\ginit.vim" -Encoding UTF8 -Value '
	### """ Neovim GUI Settings: -----------------------------------------
	### " Reference: [https://github.com/jdhao/nvim-config/blob/master/ginit.vim]
	### " To check if neovim-qt is running, use `exists("g:GuiLoaded")`,
	### " see https://github.com/equalsraf/neovim-qt/issues/219
	### if exists("g:GuiLoaded")
	### 	" call GuiWindowMaximized(1)
	### 	GuiTabline 0
	### 	GuiPopupmenu 0
	### 	GuiLinespace 2
	### 	if has("win16") || has("win32") || has("win64")
	### 		GuiFont! Hack:h10:l
	### 	else

	### 	endif

	### 	" Use shift+insert for paste inside neovim-qt,
	### 	" see https://github.com/equalsraf/neovim-qt/issues/327#issuecomment-325660764
	### 	inoremap <silent>  <S-Insert>  <C-R>+
	### 	cnoremap <silent> <S-Insert> <C-R>+

	### 	" For Windows, Ctrl-6 does not work. So we use this mapping instead.
	### 	nnoremap <silent> <C-6> <C-^>
	### endif
	### '
	### 	Write-Output "Added init.vim to vim runtime." | Success-Output
	### 	# Symlink - coc-settings.json
	### 	# mklink "/home/$HOME_NAME/.config/nvim/coc-settings.json" ~/.vim/coc-settings.json
	### } catch {
	### 	Write-Output "[*] Could not create the init.vim file and insert default contents for Neovim." | Failure-Output
	### 	Write-Output $_
	### }

	# Run nvim and quit just to load all changes from vim into neovim (may be seen as unnecessary but if there's an error, it will pause the installation here)
	Write-Output "Initializing neovim..."
	try {
		nvim +qall
		Write-Output "Neovim installed successfully." | Success-Output
	} catch {
		Write-Output "[*] Configuration of Neovim failed." | Failure-Output
		Write-Output "	Please consider manually configuring Neovim after the installation has been completed." | Failure-Output
	}
} catch {
	Write-Output "[*] Could not install Neovim." | Failure-Output
	Write-Output $_
}
echo ''



# ===========================================
# Final Steps
# ===========================================

vim --version

echo "
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMmmMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMm+/sodMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMh/////////////////////////sMMoohhyoodMMMMNo++++++++++++++++++++++++oMMMM
MMMMMMMM-/------------------------sMMdyyyyhyoodMMy:------------------------ydMMM
MMMMMMMM-/-----------------------:sMMdyyyyyyhyoNMy:-----------------------/sdMMM
MMMMMMMMhoyys+:-------------+ooyyydMMhyyyyyyyyhmMN+yyyo/----------------/osdMMMM
MMMMMMMMMMMMy.:-------------+ooMMMNmhyyyyyyyyyyyhNMMh-\`:--------------/oshMMMMMM
MMMMMMMMMMMMy.:-------------+ooMMmyyyyyyyyyyyyyhNMh-\`-:-------------/oshNMMMMMMM
MMMMMMMMMMMMy.:-------------+ooMMmyyyyyyyyyyyhNMh-\`-:-------------/oshNMMMMMMMMM
MMMMMMMMMMMMy.:-------------+ooMMmyyyyyyyyyhNMh-\`-:-------------:oshNMMMMMMMMMMM
MMMMMMMMMMMMy.:-------------+ooMMmyyyyyyyhNMh- -:-------------:oshNMMMMMMMMMMMMM
MMMMMMMMMMMMy.:-------------+ooMMmyyyyydNMh- -:-------------:oshNMMMMMMMMMMMMMMM
MMMMMMMMMMMMy.:-------------+ooMMmyyydNMy- -:-------------:osyNMmMMMMMMMMMMMMMMM
MMMMMMMMMMMMy.:-------------+ooMMmydNMy- -:-------------:+syNMmhoodMMMMMMMMMMMMM
MMMMMMMMMMMMy.:-------------+ooMMNNMy. -:-------------:+syNMmhyyhyoodMMMMMMMMMMM
MMMMMMMMMmNMy.:-------------+ooMMMy. -:--------------+syNMNhyyyyyyhyoodMMMMMMMMM
MMMMMMMm+:mMy.:-------------+ooMy. -:--------------+symMNhyyyyyyyyyyhyoodMMMMMMM
MMMMMd+:oyNMy.:-------------+oo- -:--------------+symMNhyyyyyyyyyyyyyyhyoodMMMMM
MMMm+:oyyyNMy.:-------------+o--:--------------+symMNhyyyyyyyyyyyyyyyyyyhyoodMMM
MMMNdddhyyNMy.:-------------+o:--------------+ssmMNdyyyyyyyyyyyyyyyyyyyyydmmMMMM
MMMMMNdddhNMy.:-------------:-------------:+ssmMNdyyyyyyyyyyyyyyyyyyyyydmmNMMMMM
MMMMMMMNddNMy.:-------------------------ydyyydMdyyyyyyyyyyyyyyyyyyyyydmmNMMMMMMM
MMMMMMMMMNMMy.:------------------------yh----hmyyyyyyyyyyyyyyyyyyyydmmNMMMMMMMMM
MMMMMMMMMMMMy.:----------------------/sMo///sNhyyyyyyyyyyyyyyyyyydmmNMMMMMMMMMMM
MMMMMMMMMMMMy.:--------------------/osdMNddddyyyyyyyyyyyyyyyyyydmmNMMMMMMMMMMMMM
MMMMMMMMMMMMy.:------------------:smhddddddNhymddddddmhyhmddddNmNMMNmmmmNMMMMMMM
MMMMMMMMMMMMy.:----------------:osmNyo----+NhdNy/----+hhho----:yhhy:----:mMMMMMM
MMMMMMMMMMMMy.:--------------:osdMMmM+---:Ndyydm----::::::----::::::----/MMMMMMM
MMMMMMMMMMMMy.:------------:osdMMmhmy----hmyyhM/---hNmmNMy---/MMMMMd----dMMMMMMM
MMMMMMMMMMMMy.:----------:osdMMmhydm----+NhyyNy---+Mhdmmm----mMMMMN:---oMMMMMMMM
MMMMMMMMMMMMy.:--------:+shMMmhyyhN/---:Nhyydm----mmmmNM+---sMMMMMs---:NMMMMMMMM
MMMMMMMMMMMMy.:-------+shNMMdddhyNs----dmyyhM/---yNmNMMh---:NMMMMm----hMMMMMMMMM
MMMMMMMMMMMMy.:-----+shNMMMMMNddmd----oNmhyNy---/NMMMMN:---dMMMMM/---/NMMMMMMMMM
MMMMMMMMMMMMMyyyyyyhhNMMMMMMMMMNMyooooosNhdMssssshMMMMdsssssNMMMmsssssyMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMmdmdhhhyydmmMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNdddhydmmNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNddmmNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM

" | Success-Output

Write-Output ""
Write-Output "VimSetup installed successfully. Please restart your device before using VIMSetup." | Success-Output
$StopScript = Read-Host -Prompt ' [Press Enter to Quit]'


# ===========================================
# Stop Logging Output (for debugging)
# ========
