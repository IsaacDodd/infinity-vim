#!/usr/bin/env bash

# NAME
#	VIMSetup
#
# SYNOPSIS
#	This script installs VimSetup on Linux Distributions
#
# DESCRIPTION
#	Use this script to automate the installation of all the requirements for having VIMSetup on a Linux machine.
#
# EXAMPLE
#	$ ./install.sh
#
# LINK
#	https://github.com/IsaacDodd
#	References added where appropriate.
#

#set -e

VERSION="0.01"

# ===========================================
# Bash Framework Code
# ===========================================
# Bash Infinity Framework -- [Waiting for major revision of Bash Inity to start using code.]
# 	https://github.com/niieani/bash-oo-framework
#source "$( cd "${BASH_SOURCE[0]%/*}" && pwd )/scripts/bash-framework/lib/oo-bootstrap.sh"
## load the type system
#import util/log util/exception util/tryCatch util/namedParameters
## load the standard library for basic types and type the system
#import util/class
## Load logging system for UI elements
#import util/log

# Bash Infinity Exception Handling -- [/so/22009364]
set -o pipefail
shopt -s expand_aliases
declare -ig __oo__insideTryCatch=0

# If try-catch is nested, then set +e before so the parent handler doesn't catch it
alias try="[[ \$__oo__insideTryCatch -gt 0 ]] && set +e;
			__oo__insideTryCatch+=1; ( set -e;
			trap \"Exception.Capture \${LINENO}; \" ERR;"
alias catch=" ); Exception.Extract \$? || "
# Capture Exception
Exception.Capture() {
	local script="${BASH_SOURCE[1]#./}"

	if [[ ! -f /tmp/stored_exception_source ]]; then
		echo "$script" > /tmp/stored_exception_source
	fi
	if [[ ! -f /tmp/stored_exception_line ]]; then
		echo "$1" > /tmp/stored_exception_line
	fi
	return 0
}
# Extract Exception
Exception.Extract() {
	if [[ $__oo__insideTryCatch -gt 1 ]]
	then
		set -e
	fi

	__oo__insideTryCatch+=-1

	__EXCEPTION_CATCH__=( $(Exception.GetLastException) )

	local retVal=$1
	if [[ $retVal -gt 0 ]]
	then
		# BACKWARDS COMPATIBILE WAY:
		# export __EXCEPTION_SOURCE__="${__EXCEPTION_CATCH__[(${#__EXCEPTION_CATCH__[@]}-1)]}"
		# export __EXCEPTION_LINE__="${__EXCEPTION_CATCH__[(${#__EXCEPTION_CATCH__[@]}-2)]}"
		export __EXCEPTION_SOURCE__="${__EXCEPTION_CATCH__[-1]}"
		export __EXCEPTION_LINE__="${__EXCEPTION_CATCH__[-2]}"
		export __EXCEPTION__="${__EXCEPTION_CATCH__[@]:0:(${#__EXCEPTION_CATCH__[@]} - 2)}"
		return 1 # so that we may continue with a "catch"
	fi
}
# Get Last Exception
Exception.GetLastException() {
	if [[ -f /tmp/stored_exception ]] && [[ -f /tmp/stored_exception_line ]] && [[ -f /tmp/stored_exception_source ]]
	then
		cat /tmp/stored_exception
		cat /tmp/stored_exception_line
		cat /tmp/stored_exception_source
	else
		echo -e " \n${BASH_LINENO[1]}\n${BASH_SOURCE[2]#./}"
	fi

	rm -f /tmp/stored_exception /tmp/stored_exception_line /tmp/stored_exception_source
	return 0
}


# ===========================================
# Capture Arguments
# ===========================================
# declaring a couple of associative arrays
declare -A arguments
declare -A variables

# declaring an index integer
declare -i index=1;

# Argument Variables: These are passed to an associative array and the values are parsed.
# 	On the left left side is argument label or key (entered at the command line along with it's value)
# 	On the right side is the variable name the value of these arguments should be mapped to.

# Installation Variables:
# Help
variables["-h"]="OPT_HELP";
variables["--help"]="OPT_HELP";
# Verbose
variables["-v"]="OPT_VERBOSE";
variables["--verbose"]="OPT_VERBOSE";
# Home Name
variables["-n"]="HOME_NAME";
variables["--name"]="HOME_NAME";
# Force
variables["-f"]="OPT_FORCE";
variables["--force"]="OPT_FORCE";

# Level: Options = full | basic
variables["--l"]="OPTLEVEL";
variables["--lvl"]="OPTLEVEL";
variables["--level"]="OPTLEVEL";

# Group: Overrides some other prespecified options - Options = all/latest | stable
variables["-g"]="OPTGROUP";
variables["--group"]="OPTGROUP";

# Auto-Completion: Options = coc.nvim | YouCompleteMe
variables["-a"]="OPTAUTOCOMPLETION";
variables["-ac"]="OPTAUTOCOMPLETION";
variables["--auto"]="OPTAUTOCOMPLETION";
variables["--auto-completion"]="OPTAUTOCOMPLETION";


# Auto-Completion Language Support:
# These options will perform one of two methods based on the Auto-Completion mechanism chosen:
# (1) coc.nvim: Language Server Variables: (only for when coc.nvim is chosen for auto-completion)
# (2) YouCompleteMe: Choose which language flags are sent to the YCM installation script.
# Install all language servers/supported languages available (only major, well-used languages are supported here)
variables["-iall"]="OPT_INSTALLALL";
variables["--install-all"]="OPT_INSTALLALL";
# Rust
variables["-irs"]="OPT_INSTALLRUST";
variables["--install-rust"]="OPT_INSTALLRUST";
# Go
variables["-igo"]="OPT_INSTALLGO";
variables["--install-go"]="OPT_INSTALLGO";
# ClangD -- This is installed by -iall by default, instead of CCLS (i.e., to install one or the other not both)
variables["-icl"]="OPT_INSTALLCLANGD";
variables["--install-clangd"]="OPT_INSTALLCLANGD";
# CCLS
variables["-icc"]="OPT_INSTALLCCLS";
variables["--install-ccls"]="OPT_INSTALLCCLS";
# Ruby
variables["-irb"]="OPT_INSTALLRUBY";
variables["--install-rust"]="OPT_INSTALLRUBY";
# JavaScript
variables["-ijs"]="OPT_INSTALLJS";
variables["--install-js"]="OPT_INSTALLJS";
# VimScript/VimL
variables["-ivi"]="OPT_INSTALLVIM";
variables["--install-vim"]="OPT_INSTALLVIM";
# Markdown
variables["-imd"]="OPT_INSTALLMARKDOWN";
variables["--install-markdown"]="OPT_INSTALLMARKDOWN";
# Python
variables["-ipy"]="OPT_INSTALLPYTHON";
variables["--install-python"]="OPT_INSTALLPYTHON";
# PHP
variables["-iph"]="OPT_INSTALLPHP";
variables["--install-php"]="OPT_INSTALLPHP";
# Bash Language Server ('Shell')
variables["-ish"]="OPT_INSTALLBASHLS";
variables["-ibs"]="OPT_INSTALLBASHLS";
variables["--install-bash"]="OPT_INSTALLBASHLS";
variables["--install-bashls"]="OPT_INSTALLBASHLS";
# DockerFile
variables["-ido"]="OPT_INSTALLDOCKER";
variables["--install-docker"]="OPT_INSTALLDOCKER";
# C#
variables["-ics"]="OPT_INSTALLCSHARP";
variables["--install-csharp"]="OPT_INSTALLCSHARP";
# Java
variables["-ija"]="OPT_INSTALLJAVA";
variables["--install-java"]="OPT_INSTALLJAVA";

# Parse Arguments
# $@ here represents all arguments passed in
for i in "$@"
do
	arguments[$index]=$i;
	prev_index="$(expr $index - 1)";

	# this if block does something akin to "where $i contains ="
	# "%=*" here strips out everything from the = to the end of the argument leaving only the label
	if [[ $i == *"="* ]]
	then argument_label=${i%=*}
	else argument_label=${arguments[$prev_index]}
	fi

	if [[ -n $argument_label ]] ; then
		# this if block only evaluates to true if the argument label exists in the variables array
		if [[ -n ${variables[$argument_label]} ]] ; then
			# dynamically creating variables names using declare
			# "#$argument_label=" here strips out the label leaving only the value
			if [[ $i == *"="* ]]
			then declare ${variables[$argument_label]}=${i#$argument_label=}
			else declare ${variables[$argument_label]}=${arguments[$index]}
			fi
		fi
	fi

	index=index+1;
done;

# Groups: Set default options by naming a group
if [[ "$OPTGROUP" == 'all' ]] || [[ "$OPTGROUP" == 'latest' ]] ; then
	OPTLEVEL='full'
	OPTPLUGINMANAGER='vim-plug'
	OPTAUTOCOMPLETION='coc.nvim'
	OPT_INSTALLALL=true
elif [[ "$OPTGROUP" == 'stable' ]]; then
	OPTLEVEL='basic'
	OPTPLUGINMANAGER='Vundle'
	OPTAUTOCOMPLETION='YouCompleteMe'
	OPT_INSTALLALL=true
fi

# Then you could simply use the variables like so:
## echo "$OPT_INSTALLCCLS";
# echo "$OPT_INSTALLALL";
# echo "$OPT_INSTALLCCLS";
# Reference: [https://stackoverflow.com/questions/7069682/how-to-get-arguments-with-flags-in-bash#49060084]


# ===========================================
# Capture Working Directory
# ===========================================
# Capture the directory the script has run from into a variable to return to it later -- [/so/2314750]
SCRIPTROOT="`pwd`"


# ===========================================
# Output Functions
# ===========================================
# Print messages based on results or actions being taken with color-coding
function print_success {
	printf "\r\033[2K  [\033[00;32m OK  \033[0m] $1\n"
}
function print_failure {
	printf "\r\033[2K  [\033[0;31m FAIL\033[0m] $1\n"
	if [[ $2 ]]; then
		printf "\r \033[2K   |\033[0;31m [*] ERROR @ Line $2 \033[0m| \n"
	fi
}
function print_addtask {
	printf "\r  [\033[00;34m +++\033[0m ] $1\n"
}
function print_minustask {
	printf "\r\033[2K  [\033[0;31m ---\033[0m ] $1\n"
}
function print_action {
	printf "\r  [\033[00;34m ... \033[0m] $1\n"
}
function print_hrule {
	printf -v _hr "%*s" $(tput cols) && echo ${_hr// /${1-.}}
	# Reference: https://brettterpstra.com/2015/02/20/shell-trick-printf-rules/
	echo ''
	echo ''
}
function print_prompt {
	printf "\r  [\033[0;33m ??? \033[0m] $1\n"
}
function print_notfound {
	printf "$1 not found. Installing $1..."
}
function command_exists {
	command -v "$1" >/dev/null 2>&1;
	# Reference: [https://github.com/neoclide/coc.nvim/blob/master/install.sh]
}
function show_supported_languageservers {
	echo '	  Rust:'
	echo '			-irs | --install-rust'
	echo '	  Go:'
	echo '			-igo | --install-go'
	echo '	  C-Family-Languages (C/C++/Obj-C/Obj-C++/±Cuda):'
	echo '		  ClangD: ** '
	echo '				-icl | --install-clangd'
	echo '		  CCLS:'
	echo '				-icc | --install-ccls'
	echo '	  Ruby:'
	echo '			-irb | --install-ruby'
	echo '	  JavaScript:'
	echo '			-ijs | --install-js'
	echo '	  Vim:'
	echo '			-ivi | --install-vim'
	echo '	  Markdown:'
	echo '			-imd | --install-markdown'
	echo '	  Python:'
	echo '			-ipy | --install-python'
	echo '	  PHP:'
	echo '			-iph | --install-php'
	echo '	  Bash:'
	echo '			-ish | --install-bash | --install-bashls'
	echo '	  Docker File:'
	echo '			-ido | --install-docker'
	echo '	  C#:'
	echo '			-ics | --install-csharp'
	echo '	  Java:'
	echo '			-ija | --install-java'
}
function show_help {
	print_hrule
    echo 'VIMSETUP INSTALLATION HELP:'
	echo ''
	echo 'DESCRIPTION:'
    echo '	This file installs Vim to a specified user directory on Linux along with'
    echo '	different options for autoc-completion and plugin management.'
	echo ''
    echo 'SYNTAX:'
    script_name=`basename "$0"`			# Reference -- [/so/192319]
    echo "  ./$script_name [ options ]"
	echo ''
	echo 'OPTIONS:'
    echo '-h '
	echo '    Help: Print this help message'
    echo " 	./$script_name -h"
    echo '-v '
	echo '    Verbose Output: Print any extra details during execution.'
    echo "	./$script_name -v=true"
	echo "		-v | --verbose"
    echo '-n '
	echo "    Home Directory Name"
	echo '	   Set a home directory name to installl to prevent being prompted for this.'
    echo "	./$script_name -n='username'"
	echo "	   This installs to /home/username/"
	echo ''
	echo 'Auto-Completion Options: coc.nvim'
	echo '  * Install All Language Servers'
	echo "		./$script_name --install-all=true "
	echo " 	OR 	./$script_name -iall=true"
	echo '		Warning: The "all" option may consume several gigabytes of drive space.'
	echo ''
	echo '  * Install Individual Language Servers'
	echo '		'
	echo '	Note: Installing a language server installs the executable as well as its '
	echo '		dependencies.'
	echo '		(e.g., Installing Rust installs RustUp and rust-analysis)'
	show_supported_languageservers
    echo ''
	echo '  ** Note: With the C/C++ family language servers, ClangD is installed with the --install-all option by default instead of CCLS.'
	print_hrule
    exit
}
# Some excerpts from: https://github.com/mscoutermarsh/dotfiles/blob/master/install

# Handle Command-Line Arguments -- [/so/192249]
#   Initialize default variables:
## OPTIND=1            # Set OPTIND POSIX variable -- Reset in case getopts has been used previously in the shell.
## HOME_NAME=""
## output_verbose=0

## # Iterate over Getops
## while getopts "h?vn:" opt; do
##     case "$opt" in
##     h|\?)
##         show_help
##         exit 0
##         ;;
##     v)  output_verbose=1
##         ;;
##     n)  HOME_NAME=$OPTARG
##         ;;
##     esac
## done
##
## shift $((OPTIND-1))
## [ "${1:-}" = "--" ] && shift

# Help
while test $# -gt 0; do
	case "$1" in
		-h|--help)
			show_help
			exit 0
			;;
		*)
			shift
			break
			;;
	esac
done


#================================================================================
# LISTBOX Element
#================================================================================
# Credit: Developed by Gorodinskiy Constantin (gko) - https://konstantin.io/
#	https://github.com/gko/listbox.git
#	Thank you for originally creating this amazing UI element for Bash.

listbox() {
  while [[ $# -gt 0 ]]
  do
	key="$1"

	case $key in
	  -h|--help)
		echo "choose from list of options"
		echo "Usage: listbox [options]"
		echo "Example:"
		echo "  listbox -t title -o \"option 1|option 2|option 3\" -r resultVariable -a '>'"
		echo "Options:"
		echo "  -h, --help                         help"
		echo "  -t, --title                        list title"
		echo "  -o, --options \"option 1|option 2\"  listbox options"
		echo "  -r, --result <var>                 result variable"
		echo "  -a, --arrow <symbol>               selected option symbol"
		return 0
		;;
	  -o|--options)
		local OIFS=$IFS;
		IFS="|";
		# check if zsh/bash
		if [ -n "$ZSH_VERSION" ]; then
		  IFS=$'\n' opts=($(echo "$2" | tr "|" "\n"))
		else
		  IFS="|" read -a opts <<< "$2";
		fi
		IFS=$OIFS;
		shift
		;;
	  -t|--title)
		local title="$2"
		shift
		;;
	  -r|--result)
		local __result="$2"
		shift
		;;
	  -a|--arrow)
		local arrow="$2"
		shift
		;;
	  *)
	esac
	shift
  done

  if [[ -z $arrow ]]; then
	arrow=">"
  fi

  local len=${#opts[@]}

  local choice=0
  local titleLen=${#title}

  if [[ -n "$title" ]]; then
	echo -e "\n  $title"
	printf "  "
	printf %"$titleLen"s | tr " " "-"
	echo ""
  fi

  draw() {
	local idx=0
	for it in "${opts[@]}"
	do
	  local str="";
	  if [ $idx -eq $choice ]; then
		str+="$arrow "
	  else
		str+="  "
	  fi
	  echo "$str$it"
	  idx=$((idx+1))
	done
  }

  move() {
	for it in "${opts[@]}"
	do
	  tput cuu1
	done
	tput el1
  }

  listen() {
	while true
	do
	  key=$(bash -c "read -n 1 -s key; echo \$key")

	  if [[ $key = q ]]; then
		break
	  elif [[ $key = B ]]; then
		if [ $choice -lt $((len-1)) ]; then
		  choice=$((choice+1))
		  move
		  draw
		fi
	  elif [[ $key = A ]]; then
		if [ $choice -gt 0 ]; then
		  choice=$((choice-1))
		  move
		  draw
		fi
	  elif [[ $key = "" ]]; then
		# check if zsh/bash
		if [ -n "$ZSH_VERSION" ]; then
		  choice=$((choice+1))
		fi

		if [[ -n $__result ]]; then
		  eval "$__result=\"${opts[$choice]}\""
		else
		  echo -e "\n${opts[$choice]}"
		fi
		break
	  fi
	done
  }

  draw
  listen
}




#================================================================================
# CHECK PREREQUISITES
#================================================================================

# Prerequisites -- Reference: [https://www.unix.com/shell-programming-and-scripting/173276-how-loop-through-space-separated-values.html]
# 	This also includes fc-cache fc-list fc-match, but these are installed later on if missing. Not every distribution has these by default.
cmdvar="touch mkdir cat sudo cp"
for cmd in $cmdvar
do
    if ! [ -x "$(command -v $cmd)" ]; then
		print_failure "Error: Command '$cmd' is not installed and is a requirement." >&2
		exit 1
    fi
done


# ================================================================================
# SPLASHSCREEN
# ================================================================================
echo '
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

 '

echo ''

# ===========================================
# PROMPTS: Capture Intended Home Directory & Installation Options
# ===========================================
# Prompt: Home-Name
# If the command-line argument -n was not set, prompt for the directory.
if [[ "$HOME_NAME" == '' ]] ; then
	print_prompt " • Destination: What is your user account's 'home' name? (e.g., /home/?/...)"
	read -e HOME_NAME
	print_hrule
else
	echo "Home Directory Name:"
	echo "	$HOME_NAME"
	echo "Installing To:"
	echo "	/home/$HOME_NAME/"
	print_hrule
fi

# Prompt: Level
if [[ "$OPTLEVEL" == '' ]]; then
	print_prompt " • Setup Level Options:"
	echo "		Which setup level would you like to install?"
	echo "
	1) FULL
	-------
		Includes all vimrc options available to be installed.

	2) BASIC
	--------
		Installs a reduced, minimal level of vimrc options for a
		lean installation.

(Use arrow keys; using '>' select which one to install; Hit Enter)"
	listbox -t "Setup Level: " -o "full|basic" -r OPTLEVEL -a '>'
	echo "Level to Install: $OPTLEVEL"
	print_hrule
else
	echo 'Setup Level:'
	echo "	$OPTLEVEL"
	print_hrule
fi

# Prompt: Auto-Completion
if [[ "$OPTAUTOCOMPLETION" == '' ]]; then
	print_prompt " • Auto-Completion Options:"
	echo "		Which would you like to install?"
	echo "
	  Functions: Completion menus, hover tooltips (nvim), jump-to-definition,
		reference-finding, workspace symbols, diagnostics, and more...

	  1) coc.nvim [Installs Node.js]
	  -----------
	  <https://github.com/neoclide/coc.nvim>
		Description:
			Intellisense engine for vim8 & neovim, full language server protocol
			support as VSCode
		Language Servers:
			Available for [C-family languages; Dart, Go, PHP, Dockerfile, Bash, Lua,
			OCaml and ReasonML, PureScript, Flow, Haskell, vim/erb/markdown, Elixir,
			Scala, TeX]
		Extensions:
			For JSON, Type/JavaScript, HTML, Handlebars, Razor, CSS/SCSS/Less, Vue,
			PHP, Java, SolarGraph, Rust, YAML, Python, Highlight, Emmet, Snippets,
			Lists, Git, Yank, F#, TailwindCSS, Angular, VIML

	  2) YouCompleteMe [Installs Clang, CMake, and Python]
	  ----------------
	  <https://github.com/ycm-core/YouCompleteMe>
		Description:
			A code-completion engine for Vim: YouCompleteMe is a fast, as-you-type,
			fuzzy-search code completion engine for Vim.
		Completion Engines:
			Available for [C-family languages; Python; C#; Go, Type/JavaScript;
			Rust; Java; + ]
			+ = Additionally, any language supported by Vim's Omnicompletion System

	(Use arrow keys; using '>' select which one to install; Hit Enter)"
	listbox -t "Auto-Completion Mechanism: " -o "coc.nvim|YouCompleteMe" -r OPTAUTOCOMPLETION -a '>'
	echo "Auto-Completion Option to Install: $OPTAUTOCOMPLETION"
	print_hrule
else
	echo 'Auto-Completion Mechanism:'
	echo "	$OPTAUTOCOMPLETION"
	print_hrule
fi

# Language Server/Support: Per Package Manager
if [[ "$OPTAUTOCOMPLETION" == "coc.nvim" ]] && [[ "$OPT_INSTALLALL" == '' ]]; then
    script_name=`basename "$0"`			# Reference -- [/so/192319]
	# Prompt Language Server Options:
	print_prompt " • Language Server Options:"
	echo "		Which would you like to install?"
	echo "
	COC.NVIM OPTIONS:

	1) ALL
	------
	[Installs All Language Servers]
		Installs all required language runtimes and dependencies for all supported
		language servers (i.e., the packages GoLang, RustUp, Ruby, etc.)
		WARNING: This will consume a lot of drive space.

	2) DEFAULT
	----------
	[Only Pre-Installed or Pre-Spcified Language Servers]
		Installs only the language servers for which there are already existing
		language installations installed (i.e., only install the EFM langserver
		if Go is installed already, and so on)
		OR if command-line options were specified (i.e., -igo or --install-go=true).
		(See Help: ./$scriptname -h for more help.)

	Supported Language Servers:"
	show_supported_languageservers
	echo "
(Use arrow keys; using '>' select which option to install; Hit Enter)"
	listbox -t "Language Server Option: " -o "All|Default" -r OPTLANGUAGESERVER -a '>'
	echo ''
	if [[ "$OPTLANGUAGESERVER" == "All" ]]; then
		OPT_INSTALLALL=true
		echo "	Language Server Option: Install ALL = $OPT_INSTALLALL"
	fi
	print_hrule
fi

if [[ "$OPTAUTOCOMPLETION" == "Vundle" ]] && [[ "$OPT_INSTALLALL" == '' ]]; then
    script_name=`basename "$0"`			# Reference -- [/so/192319]
	# Prompt Language Server Options:
	print_prompt " • Language Support Options:"
	echo "		Which would you like to install?"
	echo "
	VUNDLE OPTIONS:

	1) ALL: (Recommended)
	-------
	[Installs All Supported Language Flags]
		Installs all required language runtimes and dependencies for all supported
		languages (i.e., the packages GoLang, RustUp, Ruby, etc.)
		WARNING: This will consume a lot of drive space.

	2) DEFAULT:
	-----------
	[Only Pre-Installed or Pre-Spcified Language Servers]
		Installs only the language servers for which there are already existing
		language installations installed
		OR if command-line options were specified (i.e., -igo or --install-go=true).
		(See Help: ./$scriptname -h for more help.)

	Supported Language Support:"
	show_supported_languageservers
	echo "
(Use arrow keys; using '>' select which option to install; Hit Enter)"
	listbox -t "Language Support Option: " -o "All|Default" -r OPTLANGUAGESERVER -a '>'
	echo ''
	if [[ "$OPTLANGUAGESERVER" == "All" ]]; then
		OPT_INSTALLALL=true
		echo "	Language Support Option: Install ALL = $OPT_INSTALLALL"
	fi
	print_hrule
fi

# Prompt: Plugin-Manager
if [[ "$OPTPLUGINMANAGER" == '' ]]; then
	print_prompt " • Plugin-Manager Options: Which would you like to use to install plugins?"
	echo "
	  1) Vim-Plug
	  -----------
	  [Newer, more optimized]
	  <https://github.com/junegunn/vim-plug>
		Features:
			Parallel installations/updates, shallow clones to reduce drive space
			& download time, faster startup times, on-demand loading,
			conditional plugin activation

	  2) Vundle
	  ---------
	  [Older, stable]
	  <https://github.com/VundleVim/Vundle.vim>
		Features:
			Reliable, simple syntax, manages plugins via a linear list

	(Use arrow keys; using '>' select which one to install; Hit Enter)"
	listbox -t "Plugin Manager: " -o "vim-plug|Vundle" -r OPTPLUGINMANAGER -a '>'
	echo ''
	echo "	Plugin-Manager Option to Install: $OPTPLUGINMANAGER"
	print_hrule
else
	echo 'Plugin Manager:'
	echo "	$OPTPLUGINMANAGER"
	print_hrule
fi


# ===========================================
# Instructions for Windows Users
# ===========================================

function instructions_windows {
	# For those running Unix-like Cygwin, MSys, or MingGW
	echo "
	For Windows Installations:

	This script only supports the Linux or MacOS operating systems.
	Please use the Windows installation script to install in a manner consistent with all of Windows via PowerShell. Thank you."
}

if [[ "$OSTYPE" == "win32" || "$OSTYPE" == "win64" ]]; then
	instructions_windows
	# Stop the script here -- [/so/1378274]
	exit 1

fi
# Reference: [https://stackoverflow.com/questions/394230/how-to-detect-the-os-from-a-bash-script]


# ===========================================
# Instructions for MacOSX Users
# ===========================================

function instructions_macos {
	# For those running MacOS
	echo "
	For MacOS Installations:

	This script only supports MacOS with a third-party package manager installed (Homebrew, MacPorts, Fink, or pkgsrc)."
}

if [[ "$OSTYPE" == "darwin"* ]]; then
	if [[ "$PACKAGEMANAGER" != 'brew' ]] && [[ "$PACKAGEMANAGER" != 'fink' ]] && [[ "$PACKAGEMANAGER" != 'macports' ]] && [[ "$PACKAGEMANAGER" != 'pkgsrc' ]]; then
		instructions_macos
		# Stop the script here -- [/so/1378274]
		exit 1
	fi
fi
# Reference: [https://stackoverflow.com/questions/394230/how-to-detect-the-os-from-a-bash-script]

# ===========================================
# Git Setup
# ===========================================
# On *nix-based systems, use input line endings in Git to store as LF but check out in the working directory in an OS-compatible way
# Reference: [/so/2825428]
git config --local core.autocrlf input

# ===========================================
# Linux/MacOS - Determine Package Manager
# ===========================================
# Linux/MacOS Package Manager:
# call_manager: Used to run the system package manager.
function call_manager {

	# Linux
    if [[ "$PACKAGEMANAGER" == 'apt' ]] || [[ "$PACKAGEMANAGER" == 'apt-get' ]]; then
        use_apt "$1";
    elif [[ "$PACKAGEMANAGER" == 'bsd-free' ]]; then
        use_bsd_free "$1";
    elif [[ "$PACKAGEMANAGER" == 'bsd-netopen' ]]; then
        use_bsd_netopen "$1";
    elif [[ "$PACKAGEMANAGER" == 'dnf' ]]; then
        use_dnf "$1";
    elif [[ "$PACKAGEMANAGER" == 'eopkg' ]]; then
        use_eopkg "$1";
    elif [[ "$PACKAGEMANAGER" == 'emerge' ]]; then
        use_portage "$1";
    elif [[ "$PACKAGEMANAGER" == 'nixpkgs' ]]; then
        use_nixpkgs "$1";
    elif [[ "$PACKAGEMANAGER" == 'paludis' ]]; then
		use_paludis "$1"
    elif [[ "$PACKAGEMANAGER" == 'portage' ]] || [[ "$PACKAGEMANAGER" == 'emerge' ]]; then
		use_portage "$1";
    elif [[ "$PACKAGEMANAGER" == 'pacman' ]]; then
        use_pacman "$1";
    elif [[ "$PACKAGEMANAGER" == 'sbopkg' ]] || [[ "$PACKAGEMANAGER" == 'slackware' ]]; then
        use_sbopkg "$1";
    elif [[ "$PACKAGEMANAGER" == 'swupd' ]]; then
		use_swupd "$1";
    elif [[ "$PACKAGEMANAGER" == 'urpmi' ]]; then
		use_urpmi "$1";
    elif [[ "$PACKAGEMANAGER" == 'xbps' ]]; then
        use_xbps "$1";
    elif [[ "$PACKAGEMANAGER" == 'yum' ]] || [[ "$PACKAGEMANAGER" == 'yum_general' ]]; then
        use_yum_general "$1";
    elif [[ "$PACKAGEMANAGER" == 'yum_rhel' ]]; then
        use_yum_rhel "$1";
    elif [[ "$PACKAGEMANAGER" == 'zypper' ]]; then
        use_zypper "$1";

	# MacOS
	elif [[ "$PACKAGEMANAGER" == 'brew' ]]; then
		use_brew "$1";
	elif [[ "$PACKAGEMANAGER" == 'fink' ]]; then
		use_fink "$1";
	elif [[ "$PACKAGEMANAGER" == 'macports' ]]; then
		use_macports "$1";
	elif [[ "$PACKAGEMANAGER" == 'pkgsrc' ]]; then
		use_pkgsrc "$1";
    else
        print_failure 'No supported package manager was found.'
        exit 7
    fi
	# Since a package manager was found, print a status message before exiting...
	print_action "Downloading & Installing '$1' using $PACKAGEMANAGER"
}
# Package Manager: apt
function use_apt {
	# Ubuntu/Debian/Mint/Deepin/ElementaryOS/Kali
	if [[ "$1" == "gvim" ]]; then
		if [[ $SYSTEM_WSL == true ]]; then
			# Vim--gtk comes installed with better defaults on WSL -- [https://github.com/nickjj/dotfiles]
			PACKAGE='vim-gtk'
		else
			# Ubuntu doesn't have a 'gvim' package. Install vim-gnome instead. -- [https://askubuntu.com/questions/77503/how-to-install-gvim]
			PACKAGE='vim-gnome'
		fi
	elif [[ "$1" == "the_silver_searcher" ]]; then
		PACKAGE="silversearcher-ag"
	elif [[ "$1" == "python" ]]; then
		#PACKAGE='python3'
		# PACKAGE='python'
		PACKAGE='build-essential python3-dev'
	elif [[ "$1" == "pip" ]]; then
		# If pip, then install python-pip instead
		#PACKAGE='python-pip3'
		PACKAGE='python-pip'
	elif [[ "$1" == "fc-cache" ]]; then
		PACKAGE='fontconfig'
	elif [[ "$1" == "ripgrep" ]]; then
		if sudo apt search ripgrep | grep ripgrep ; then
			PACKAGE='ripgrep'
		else
			curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
			sudo dpkg -i ripgrep_11.0.2_amd64.deb
			rm -f ripgrep_11.0.2_amd64.deb
		fi
	elif [[ "$1" == "firacode" ]]; then
		PACKAGE='fonts-firacode'
	elif [[ "$1" == "clang-tools" ]]; then
		# PACKAGE='clang-tools-8'
		sudo apt-get update
		sudo apt-get install clang-tools-8 -y
		sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-8 100
		return 0
	elif [[ "$1" == "ccls" ]]; then
		if [[ "$MANAGEROSTYPE" == "ubuntu" ]]; then
			sudo apt install clang cmake libclang-dev llvm-dev rapidjson-dev -y
			sudo apt install zlib1g-dev libncurses-dev libncurses5 -y
			cd "/home/$HOME_NAME/.vim"
			git clone --depth=1 --recursive https://github.com/MaskRay/ccls
			cd ccls
			cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release \
				-DCMAKE_PREFIX_PATH=/usr/lib/llvm-7 \
				-DLLVM_INCLUDE_DIR=/usr/lib/llvm-7/include \
				-DLLVM_BUILD_INCLUDE_DIR=/usr/include/llvm-7/
			cmake --build Release
			return 0
		else
			PACKAGE="ccls"
		fi
	elif [[ "$1" == "ruby" ]]; then
		if command_exists snap; then
			sudo snap install ruby --classic
			return 0;
		else
			PACKAGE="ruby-full"
		fi
	elif [[ "$1" == "mono" ]]; then
		if [[ "$MANAGEROSTYPE" == 'ubuntu' ]]; then
			sudo apt install gnupg ca-certificates
			sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
			echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
			sudo apt update
		elif [[ "$MANAGEROSTYPE" == 'debian' ]]; then
			sudo apt install apt-transport-https dirmngr gnupg ca-certificates
			sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
			echo "deb https://download.mono-project.com/repo/debian stable-buster main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
			sudo apt update
		elif [[ "$MANAGEROSTYPE" == 'raspbian' ]]; then
			sudo apt install apt-transport-https dirmngr gnupg ca-certificates
			sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
			echo "deb https://download.mono-project.com/repo/debian stable-raspbianbuster main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
			sudo apt update
		fi
		PACKAGE='mono-devel'
	elif [[ "$1" == "jdk" ]]; then
		PACKAGE='default-jdk'
	elif [[ "$1" == "neovim" ]]; then
		try {
			# Build from source because the Neovim in the apt repository is outdated, indicating it won't be maintained quickly enough to keep up with all the latest changes
			sudo apt-get update
			# Build Requirements
			sudo apt-get install checkinstall build-essential ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip -y
			# Install
			sudo mkdir -p "/home/$HOME_NAME/.vim/neovim"
			cd "/home/$HOME_NAME/.vim/"
			git clone --depth 1 https://github.com/neovim/neovim.git
			cd neovim
			sudo make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=/home/$HOME_NAME/.vim/neovim"
			# Checkinstall instead of make install - it turns the installation into a deb package uninstallable by the package manager instead.
			sudo checkinstall
			pathvar_add "/home/$HOME_NAME/.vim/neovim/bin"
			return 0
		}
		catch {
			PACKAGE='neovim'
		}

	else
		PACKAGE=$1
	fi
	sudo apt-get update
    sudo apt-get install $PACKAGE -y
}
function remove_apt {
	sudo apt-get purge --auto-remove $1
	sudo apt --purge autoremove
	sudo apt-get clean
}
# Package Manager: PKG for FreeBSD
function use_bsd_free {
	# FreeBSD - Uses Pkgsrc - https://pkgsrc.joyent.com/
	# Reference: [https://www.tecmint.com/pkg-command-examples-to-manage-packages-in-freebsd/]
	pkg install $1
}
function remove_bsd_free {
	pkg remove $1
	pkg autoremove
}
# Package Manager: PKGSRC for NetBSD/OpenBSD
function use_bsd_netopen {
	# NetBSD/OpenBSD
	pkg_add -f $1
}
function remove_bsd_netopen {
	pkg_delete -f $1
}
# Package Manager: DNF
function use_dnf {
	# Fedora >=22
	if [[ "$1" == 'libjansson-dev' ]]; then
		PACKAGE='jansson-devel'
	elif [[ "$1" == 'libseccomp-dev' ]]; then
		PACKAGE='libseccomp-devel'
	elif [[ "$1" == 'libyaml-dev' ]]; then
		PACKAGE='libyaml-devel'
	elif [[ "$1" == 'libxml2-dev' ]]; then
		PACKAGE='libxml2-devel'
	elif [[ "$1" == 'pkg-config' ]]; then
		PACKAGE='pkgconfig'
	elif [[ "$1" == 'firacode' ]]; then
		sudo dnf copr enable evana/fira-code-fonts -q -y
		PACKAGE='fira-code-fonts'
	elif [[ "$1" == 'mono' ]] && [[ "$MANAGEROSTYPE" == 'fedora' ]]; then
		sudo rpm --import "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF"
		su -c 'curl https://download.mono-project.com/repo/centos8-stable.repo | tee /etc/yum.repos.d/mono-centos8-stable.repo'
		PACKAGE='mono-devel'
	elif [[ "$1" == 'jdk' ]]; then
		PACKAGE='java-11-openjdk'
	elif [[ "$1" == 'python' ]]; then
		PACKAGE='gcc-c++ make python3-devel'
	else
		PACKAGE=$1
	fi
	sudo dnf update
    sudo dnf install $PACKAGE -q -y
}

function remove_dnf {
	sudo dnf remove $1
}
# Package Manager: PACMAN
function use_pacman {
	# ArchLinux, Manjaro Linux, Antergos
	if [[ "$1" == "firacode" ]]; then
		PACKAGE='otf-fira-code'
	elif [[ "$1" == 'jdk' ]]; then
		sudo pacman -S jre-openjdk --noconfirm
		PACKAGE='jdk-openjdk'
	else
		PACKAGE=$1
	fi
	if [[ "$MANAGEROSTYPE" == "arch" ]]; then
		if [[ "$1" == "ccls" ]]; then
			# PACKAGE='ccls-git'
			PACKAGE='ccls'
		elif [[ "$1" == 'clang-tools' ]]; then
			PACKAGE='clang-tools-extra'
		fi
	fi
    sudo pacman -S $PACKAGE --noconfirm
}
function remove_pacman {
	sudo pacman -Rns $1
}
# Package Manager: Paludis
function use_paludis {
	sudo cave resolve -x $1
	# Reference: [https://wiki.gentoo.org/wiki/Paludis]
}
function remove_paludis {
	sudo cave uninstall $1
	sudo cave purge
}
# Package Manager: NixPkgs
function use_nixpkgs {
	sudo nix-env --install $1
	# Reference: [https://nixos.org/nix/manual/]
}
function remove_nixpkgs {
	sudo nix-env --uninstall $1
	sudo nix-collect-garbage
}
# Package Manager: PORTAGE
function use_portage {
	if [[ "$1" == "firacode" ]]; then
		PACKAGE='media-fonts/fira-code'
	elif [[ "$1" == "the_silver_searcher" ]]; then
		sudo emerge -av sys-apps/the_silver_searcher
		return 0;
	elif [[ "$1" == "ripgrep" ]]; then
		sudo emerge -av sys-apps/ripgrep
		return 0;
	elif [[ "$1" == "ruby" ]]; then
		sudo emerge --ask dev-lang/ruby
		return 0;
	else
		PACKAGE=$1
	fi
	sudo emerge -av $PACKAGE
	# References:
	#	[https://wiki.gentoo.org/wiki/Handbook:AMD64/Working/Portage]
	#	[https://www.linode.com/docs/tools-reference/linux-package-management/]
}
function remove_portage {
	sudo emerge -c $1
	# sudo emerge --unemerge $1
	# Clean orphaned dependencies
	sudo emerge --depclean
}
# Package Manager: Urpmi
function use_urpmi {
	# Mageia
	sudo urpmi $1
	# Reference: [https://wiki.mageia.org/en/URPMI]
}
function remove_urpmi {
	sudo urpme $1
}
# Package Manager: XBPS
function use_xbps {
	# Void Linux
	sudo xbps-install -Sf $1
}
function remove_xbps {
	sudo xbps-remove $1
}
# Package Manager: SBOPKG for Slackware
function use_sbopkg {
	# Slackware
    sudo sbopkg -i $1
	# References:
	#	[https://www.sbopkg.org/docs.php]
	#	[https://blog.jeaye.com/2015/07/09/sbopkg/]
}
function remove_sbopkg {
	sudo sbopkg remove $1
}
# Package Manager: swupd for Clear Linux*
function use_swupd {
	sudo swupd bundle-add $1
}
function remove_swupd {
	sudo swupd bundle-remove $1
}
# Package Manager: EOPKG
function use_eopkg {
	if [[ "$1" == "firacode" ]]; then
		PACKAGE='font-firacode-ttf font-firacode-otf'
	else
		PACKAGE=$1
	fi
	sudo eopkg install $PACKAGE
}
function remove_eopkg {
	sudo eopkg remove $1
}
# Package Manager: YUM
function use_yum_general {
	# CentOS, Fedora <=21
	if [[ "$1" == 'ruby' ]]; then
		if command_exists snap; then
			sudo snap install ruby --classic
			return 0;
		else
			PACKAGE='ruby'
		fi
	elif [[ "$1" == "mono" ]] && [[ "$MANAGEROSTYPE" == 'centos' ]]; then
		rpmkeys --import "http://pool.sks-keyservers.net/pks/lookup?op=get&search=0x3fa7e0328081bff6a14da29aa6a19b38d3d831ef"
		su -c 'curl https://download.mono-project.com/repo/centos8-stable.repo | tee /etc/yum.repos.d/mono-centos8-stable.repo'
		PACKAGE='mono-devel'
	elif [[ "$1" == 'mono' ]] && [[ "$MANAGEROSTYPE" == 'fedora' ]]; then
		rpm --import "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF"
		su -c 'curl https://download.mono-project.com/repo/centos8-stable.repo | tee /etc/yum.repos.d/mono-centos8-stable.repo'
		PACKAGE='mono-devel'
	elif [[ "$1" == 'mono' ]]; then
		PACKAGE='mono-devel'
	else
		PACKAGE=$1
	fi
    sudo yum -y install $PACKAGE
}
function use_yum_rhel {
	# RHEL7+
	if [[ "$1" == "ruby" ]]; then
		if command_exists snap; then
			sudo snap install ruby --classic
			return 0;
		else
			PACKAGE='ruby'
		fi
	elif [[ "$1" == 'mono' ]]; then
		PACKAGE='mono-devel'
	else
		PACKAGE=$1
	fi
    sudo yum epel-release.noarch install $PACKAGE
}
function remove_yum {
	sudo yum remove -y $1
}
# Package Manager: ZYPPER
function use_zypper {
	# OpenSUSE
	if [[ "$1" == 'jdk' ]]; then
		PACKAGE='java-11-openjdk'
	else
		PACKAGE=$1
	fi
    sudo zypper -n install $PACKAGE --force
}
function remove_zypper {
	sudo zypper remove $1
}
# Package Manager: BREW
function use_brew {
	# Homebrew - MacOS or Linux
	if [[ "$1" == "firacode" ]]; then
		brew tap homebrew/cask-fonts
		PACKAGE='font-fira-code'
	elif [[ "$1" == "vim" ]]; then
		PACKAGE='vim --with-override-system-vi'
		# Reference: [https://davidtranscend.com/blog/set-up-vim-tmux-macos/]
		# "This command will override the Vim bundled with macOS with Homebrew's version. This will also make updating Vim easier (brew upgrade vim)."
	else
		PACKAGE=$1
	fi
	brew cask install $PACKAGE
}
function remove_brew {
	brew uninstall --ignore-dependencies $1
}
# Package Manager: FINK
function use_fink {
	# Fink - MacOS
	fink install $1
}
function remove_fink {
	fink remove $1
}
# Package Manager: MACPORTS
function use_macports {
	# MacPorts - MacOS -- Reference: [https://guide.macports.org/]
	sudo port install $1
	if [ $? -ne 0 ]; then
		print_failure "Error: Could not install package '$1'. Cleaning..." >&2
		sudo port clean $1
	fi
}
function use_pkgsrc {
	# Pkgsrc -- Supports multiple platforms (include NetBSD above)
	pkg_add -f $1
}
function remove_pkgsrc {
	pkg_delete -r $1
	# Reference: [https://www.netbsd.org/docs/pkgsrc/using.html]
}
# Fetch: Use either wget or curl to download a payload from a URL (From coc.nvim)
function fetch {
	local command
	if hash curl 2>/dev/null; then
		set +e
		command="curl --fail -L $1"
		curl --compressed --fail -L "$1"
		returncode=$?
		set -e
	else
		if hash wget 2>/dev/null; then
			set +e
			command="wget -O- -q $1"
			wget -O- -q "$1"
			returncode=$?
			set -e
		else
			echo "No HTTP download program (curl, wget) found…"
			exit 1
		fi
	fi

	if [ $returncode -ne 0 ]; then
	  echo "Command failed with exit code '$returncode' for command: ${command}"
	  exit $rc
	fi
}
# Reference: [https://github.com/neoclide/coc.nvim/blob/master/install.sh]

### Set the Package Manager variable

# Determine the system package manager: -- [/un/46081] , [/un/125241] , [/un/6345] , [/so/8597411]
declare -A pmWhich;
pmWhich[/etc/debian_version]=apt
pmWhich[/etc/redhat-release]=dnf
pmWhich[/etc/gentoo-release]=portage
pmWhich[/etc/arch-release]=pacman
pmWhich[/etc/SuSE-release]=zypper
pmWhich[/etc/xbps.d]=xbps

for f in ${!pmWhich[@]}
do
    if [[ -f $f ]];then
        PACKAGEMANAGER=${pmWhich[$f]}
    fi
done
# References -- [http://linuxjournal.com/content/bash-arrays]

# Another method using /etc/os-release -- [/so/41763871] , [https://github.com/ggreer/the_silver_searcher]

if cat /etc/*release | grep ^NAME | grep CentOS; then
	PACKAGEMANAGER='yum'
	MANAGEROSTYPE='centos'
elif cat /etc/*release | grep ^NAME | grep Red; then
	PACKAGEMANAGER='yum_rhel'
	MANAGEROSTYPE='redhat'
elif cat /etc/*release | grep ^NAME | grep Fedora; then
	version=$(cat /etc/*release | grep VERSION_ID | grep -Eo '[0-9]{1,}' | sed 's/[^0-9]*//g' )
	if [[ "$version" > 21 ]]; then
		PACKAGEMANAGER='dnf'
		MANAGEROSTYPE='fedora'
	else
		# Safer to use yum rather than dnf for Fedora <22
		PACKAGEMANAGER='yum'
		MANAGEROSTYPE='fedora'
	fi
elif cat /etc/*release | grep ^NAME | grep Ubuntu; then
	PACKAGEMANAGER='apt'
	MANAGEROSTYPE='ubuntu'
elif cat /etc/*release | grep ^NAME | grep Debian ; then
	PACKAGEMANAGER='apt'
	MANAGEROSTYPE='debian'
elif cat /etc/*release | grep ^NAME | grep Raspbian ; then
	PACKAGEMANAGER='apt'
	MANAGEROSTYPE='Raspbian'
elif cat /etc/*release | grep ^NAME | grep Gentoo ; then
	PACKAGEMANAGER='portage'
	MANAGEROSTYPE='gentoo'
elif cat /etc/*release | grep ^NAME | grep Exherbo ; then
	PACKAGEMANAGER='paludis'
	MANAGEROSTYPE='exherbo'
elif cat /etc/*release | grep ^NAME | grep Mint ; then
	PACKAGEMANAGER='apt'
	MANAGEROSTYPE='mint'
elif cat /etc/*release | grep ^NAME | grep Knoppix ; then
	PACKAGEMANAGER='apt'
	MANAGEROSTYPE='knoppix'
elif cat /etc/*release | grep ^NAME | grep Solus ; then
	PACKAGEMANAGER='eopkg'
	MANAGEROSTYPE='solus'
elif cat /etc/*release | grep ^NAME | grep Void ; then
	PACKAGEMANAGER='xbps'
	MANAGEROSTYPE='void'
elif cat /etc/*release | grep ^NAME | grep Slackware ; then
	PACKAGEMANAGER='sbopkg'
	MANAGEROSTYPE='slackware'
elif cat /etc/*release | grep ^NAME | grep Arch ; then
	PACKAGEMANAGER='pacman'
	MANAGEROSTYPE='arch'
elif cat /etc/*release | grep ^NAME | grep Manjaro ; then
	PACKAGEMANAGER='pacman'
	MANAGEROSTYPE='manjaro'
elif cat /etc/*release | grep ^NAME | grep Mageia; then
	PACKAGEMANAGER='urpmi'
	MANAGEROSTYPE='mageia'
elif which brew 2> /dev/null ; then
	PACKAGEMANAGER='brew'
elif [ -d "/opt/local/lib/port" ] ; then
	PACKAGEMANAGER='macports'
elif [ -d "/sw/bin/fink" ] ; then
	PACKAGEMANAGER='fink'
elif [ -d "/opt/pkg/bin/" ] ; then
	PACKAGEMANAGER='pkgsrc'
elif [ "$(uname -o)" = Android ]; then
	MANAGEROSTYPE='android'
fi

# Method using $OSTYPE -- [/so/18434831]
case "$OSTYPE" in
	'FreeBSD')
		PACKAGEMANAGER='bsd-free';;
	CYGWIN*|MINGW*|MSYS*)
		instructions_windows ;;
esac

# Check for WSL
if cat /proc/version | grep Microsoft; then
	    SYSTEM_WSL=true
fi

# References:
#   https://unix.stackexchange.com/questions/46081/identifying-the-system-package-manager
#   https://wiki.archlinux.org/index.php/Pacman/Rosetta
#   https://unix.stackexchange.com/questions/82016/how-to-use-zypper-in-bash-scripts-for-someone-coming-from-apt-get
#   https://dnf.readthedocs.io/en/latest/command_ref.html#install-command-label
#   http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO.html#toc6
#   https://www.gnu.org/software/bash/manual/html_node/index.html#SEC_Contents
#	https://www.reddit.com/r/bashonubuntuonwindows/comments/752kvy/how_does_a_bash_script_know_its_running_in_wsl/


# ========================================
# Determine Platform
# ========================================
# References:
#	https://github.com/canha/golang-tools-install-script/blob/master/goinstall.sh
#	https://github.com/rust-lang/rustup.rs/blob/master/rustup-init.sh


# ========================================
# Language Support
# ========================================
# Install Language Support
function install_nodejs {
	if ! command_exists node; then
		print_notfound nodejs
		call_manager node
	fi
	if ! command_exists npm; then
		print_notfound npm
		call_manager npm
		sudo npm install -g npm
		npm rebuild
		# node_modules: Where to put the node_modules directory
		export NODE_PATH="/home/$HOME_NAME/.vim/node_modules"
		# References: [https://stackoverflow.com/questions/26293049/specify-path-to-node-modules-in-package-json#26293141]
	fi
	#curl -sL https://install-node.now.sh/lts | sh
}
function install_js {
	if ! command_exists npm; then
		print_notfound npm
		call_manager npm
	fi
	# TypeScript Language Server
	try {
		sudo npm install -g javascript-typescript-langserver
	}
	catch {
		print_failure "Could not install 'TypeScript language server'."
	}
	# Vue
	try {
		sudo npm install -g vue-language-server
	}
	catch {
		print_failure "Could not install 'Vue language server'."
	}
	# JSON Lint
	try {
		sudo npm install -g jsonlint
	}
	catch {
		print_failure "Could not install 'JSON lint'."
	}
	# ESLint
	try {
		sudo npm install -g eslint
	}
	catch {
		print_failure "Could not install 'ESLint'."
	}
		try {
			detection_overwrite "/home/$HOME_NAME/.eslintrc.json" clobber
			\cp -rf ./assets/.eslintrc.json "/home/$HOME_NAME/"
			print_success "ESLint setup successfully."
		}
		catch {
			print_failure "Could not copy .eslintrc.json configuration file."
		}
	# Stylelint -- Reference: [https://stylelint.io/user-guide/cli]
	try {
		sudo npm install -g stylelint
	}
	catch {
		print_failure "Could not install 'StyleLint'."
	}
	# Prettier - These packages will help ESLint run Prettier automatically so Vim can display and fix errors from both
	#	Reference [https://davidtranscend.com/blog/configure-eslint-prettier-vim/]
	try {
		sudo npm install -g prettier
	}
	catch {
		print_failure "Could not install 'Prettier'."
	}
	# ESLint-Prettier Plugin & Config
	try {
		sudo npm install -g eslint-plugin-prettier eslint-config-prettier
	}
	catch {
		print_failure "Could not install 'ESLint-Prettier Plugin & Config'."
	}
	# CSS Lint
	try {
		sudo npm install -g csslint
	}
	catch {
		print_failure "Could not install 'CSSLint'."
	}
	# CoffeeScript
	try {
	sudo npm install -g coffeelint
	}
	catch {
		print_failure "Could not install 'CoffeeLint'."
	}
}
function install_rust {
	if ! command_exists rustup; then
		print_notfound rustup
		# Install RustUp (Installs Rust and its Dependencies): RustUp installs Rust (rustc), cargo, the rustup command, and other standard tools to Cargo's bin directory.
		# On Unix it is located at $HOME/.cargo/bin and on Windows at %USERPROFILE%\.cargo\bin
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
		pathvar_add "$HOME/.cargo/bin"
		source "$HOME/.cargo/env"
		rustup update
		# Reference: [https://github.com/rust-lang/rustup.rs#other-installation-methods]
	fi
}
function setup_rust {
	if ! command_exists rustup; then
		cd "/home/$HOME_NAME/.vim"
		git clone https://github.com/rust-analyzer/rust-analyzer && cd rust-analyzer
		rustup component add rls rust-analysis rust-src rls-preview
		cargo install-ra --server

		# Rust Formatter
		cargo install rustfmt
		# Ctags for Rust
		cargo install rusty-tags

		# Install Racer
		rustup toolchain add nightly
		cargo +nightly install racer
		export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
	fi
}
function install_bashls {
	if ! command_exists bash-language-server; then
		# sudo npm install --unsafe-perm -g bash-language-server
		try {
			sudo npm install -g bash-language-server
		}
		catch {
			sudo npm install -unsafe-perm -g bash-language-server
		}
	fi
}
function install_go {
	if ! command_exists go; then
		print_notfound go
		call_manager golang
		# Reference: [https://www.2daygeek.com/install-go-language-linux/]
	fi
}
function install_python {
	call_manager python
	if ! command_exists python; then
		# Install Python. Then, Pip will be installed and the next codeblock will install the python language server and its dependencies.
		print_notfound python
		call_manager python3
	fi
	if ! command_exists pip; then
		try {
			python -m pip install pip
			sudo pip install -U pip
		}
		catch {
			call_manager python-pip
		}
	fi
	sudo pip install virtualenv
}
function install_ruby {
	if ! command_exists gem; then
		# Install Ruby, which will include the 'gem' command.
		call_manager ruby
		# Add Ruby to the PATH variable if not present already
		RBYPATH="`ruby -e 'puts Gem.user_dir'`/bin"
		if grep -q $RBYPATH $PATH > /dev/null; then
			echo "Ruby already found in PATH"
			echo $PATH
		else
			echo "Ruby not detected in the PATH variable. Adding Ruby to the PATH variable..."
			# PATH="$RBYPATH:$PATH"
			pathvar_add $RBYPATH
		fi
		# Dependency manager
		gem install bundler
	fi
}
function install_clangd {
	if ! command_exists clangd; then
		call_manager clang-tools
		call_manager clang-format
		call_manager bear
		if ! command_exists clangd; then
			print_addtask "Package clang-tools not detected. Attempting to install the full LLVM distribution instead."
			# If a clang-tools package is not available, use the full LLVM package instead (especially for MacOS)
			call_manager llvm
			if ! command_exists clangd; then
				print_failure "Installation failed for your distribution. Please consider installing clangd manually instead."
			fi
		fi
		if [ $? -eq 0 ]; then
			print_success "Installed clangd successfully."
		else
			print_failure "Error: Could not install the clangd language server." >&2
		fi
	fi
}
function install_clang {
	if ! command_exists clang; then
		call_manager clang-tools
		call_manager clang-format
	fi
}
function install_ccls {

	if ! command_exists ccls; then
		call_manager ccls
		if ! command_exists ccls; then
			print_failure "Installation failed for your distribution. Please consider installing CCLS manually instead."
		fi
		if [ $? -eq 0 ]; then
			print_success "Installed CCLS successfully."
		else
			print_failure "Error: Could not install the CCLS language server." >&2
		fi
	fi
}
function install_csharp {
	if ! command_exists mono; then
		print_notfound mono
		call_manager mono
		mono --version
	fi
	if [ $? -eq 0 ]; then
		print_success "Installed mono successfully."
	else
		print_failure "Error: Could not install the mono repository." >&2
	fi
}
function install_java {
	if ! command_exists jdk; then
		print_notfound jdk
		call_manager jdk
		# Note: the coc-java extension will download the latest jdt.ls for you when not found.
		# Reference: [https://www.addictivetips.com/ubuntu-linux-tips/install-java-on-linux/]
	fi
	java -version
	javac -version
	if [ $? -eq 0 ]; then
		print_success "Installed Java Development Kit successfully."
	else
		print_failure "Error: Could not install the JDK repository." >&2
	fi
}
function install_latex {
	if ! command_exists latex; then
		print_notfound latex
		call_manager miktex
	fi
	if [ $? -eq 0 ]; then
		print_success "Installed a LaTeX distribution successfully."
	else
		print_failure "Error: Could not install a LaTeX distribution." >&2
	fi
}
function pathvar_add {
	PATH="${PATH:+${PATH}:}$1"
	case ":$PATH:" in
		*:$1:*)
			echo "Path '$1' already exists in the PATH variable."
			;;
		*)
			newelement=${1%/}
			if [ -d "$1" ] && ! echo $PATH | grep -E -q "(^|:)$newelement($|:)" ; then
				if [ "$2" = "after" ] ; then
					PATH="$PATH:$newelement"
				else
					PATH="$newelement:$PATH"
				fi
			fi
			;;
	esac
	#Reference:
	#	[https://unix.stackexchange.com/a/415028]
	#	[https://unix.stackexchange.com/a/32054]
}
function pathvar_remove {
	PATH="$(echo $PATH | sed -e "s;\(^\|:\)${1%/}\(:\|\$\);\1\2;g" -e 's;^:\|:$;;g' -e 's;::;:;g')"
	# Reference: [https://unix.stackexchange.com/a/270558]
}

# ===========================================
# File Management Functions
# ===========================================
function detection_overwrite {
	if [[ -f "$1" ]] ; then
		echo "Detected an existing file. Performing backup before overwriting..."
		echo "File: $1"
		try {
			if [[ -e "$1.backup" ]]; then
				echo "Existing backup detected. Deleting the backup before copying..."
				echo "Existing Backup File: $1.backup"
				sudo rm -rf "$1.backup"
			fi
			sudo mv "$1" "$1.backup" 2> /dev/null
			print_success "Created backup of existing file '$1'."
		} catch {
			print_failure "Fatal Error: Could not make a backup of the detected file '$1'" >&2
			exit 7
		}
		if [[ "$2" == 'clobber' ]] && [[ -e "$1" ]]; then
			try {
				echo "Clobbering file '$1'..."
				sudo rm -r "$1"
			} catch {
				print_failure "Failed to delete file '$1'"
			}
		fi
	elif [[ -d "$1" ]] ; then
		echo "Detected an existing directory. Performing backup before overwriting..."
		echo "Directory: $1"
		try {
			if [[ -e "$1_backup" ]]; then
				echo "Existing backup detected. Deleting the backup before copying..."
				echo "Existing Backup Directory: $1_backup"
				sudo rm -rf "$1_backup"
			fi
			sudo mv "$1" "$1_backup" 2> /dev/null
			print_success "Created backup of existing directory '$1'."
		} catch {
			print_failure "Fatal Error: Could not make a backup of the detected directory '$1'" >&2
			echo "You may want to backup the directory manually and restart the installation."
			exit 7
		}
		if [[ "$2" == 'clobber' ]] && [[ -e "$1" ]]; then
			echo "Clobbering directory '$1'..."
			sudo rm -rf "$1"
		fi
	fi
	### Reference: [https://bencane.com/2014/09/02/understanding-exit-codes-and-how-to-use-them-in-bash-scripts/]
	# try {
		# if [[ -f "$1" ]] ; then
		# 	try {
		# 		echo "Detected an existing file. Performing backup before overwriting..."
		# 		sudo mv "$1" "$1.backup"
		# 	} catch {
		# 		print_failure "Fatal Error: Could not make a backup of the detected file '$1'"
		# 		exit 7;
		# 	}
		# elif [[ -d "$1" ]] ; then
		# 	try {
		# 		echo "Detected an existing directory. Performing backup before overwriting..."
		# 		sudo mv "$1" "$1_backup"
		# 	} catch {
		# 		print_failure "Fatal Error: Could not make a backup of the detected directory '$1'"
		# 		echo "You may want to backup the directory manually and restart the installation."
		# 		exit 7;
		# 	}
		# fi
	# } catch {
	# 	print_failure "Fatal Error: Could not provide overwrite protection."
	# 	exit 7
	# }
} # Reference: [https://spacevim.org/install.sh]



# ===========================================
# Installing Dependenices
# ===========================================
echo "=== Installing Vim Dependencies ==="

print_addtask "Installing font dependencies..."
# Check if they exist. If not, install them -- [/so/592620]
if ! [ -x "$(command -v fc-cache)" ]; then
	print_action 'fc-cache not installed. Installing fc-cache...'
	try {
		call_manager fc-cache
	} catch {
		# Raise a Fatal Error and stop the installation.
		print_failure "Fatal Error: Could not install fc-cache." $__EXCEPTION_LINE__
		exit 7
	}
fi

print_addtask "Installing package manager dependencies..."
# Check if they exist. If not, install them -- [/so/592620]
if ! [ -x "$(command -v git)" ]; then
	print_action 'Git not installed. Installing Git...'
	try {
		call_manager git
		# Update the submodules
		git submodule init
		git submodule update
	} catch {
		# Raise a Fatal Error and stop the installation since all else depends on git.
		print_failure "Fatal Error: Could not install git." $__EXCEPTION_LINE__
		exit 7
	}
fi

if ! [ -x "$(command -v curl)" ]; then
	print_action 'Installing Curl...'
	try {
		call_manager curl
	} catch {
		# Raise an error, but continue since it only affects 1 part of installation.
		print_failure "Could not install Curl. Font installation may fail -- consider installing fonts manually."
	}
fi

print_addtask "Installing vim plugins manager..."
try {
	dir="/home/$HOME_NAME/.vim"
	detection_overwrite "$dir" clobber
	# sudo rm -rf $dir
	mkdir -p $dir
	# Reference: [/so/793858]
	detection_overwrite "$dir/bundle" clobber
	mkdir -p "/home/$HOME_NAME/.vim/bundle"
	if [[ "$OPTPLUGINMANAGER" == 'Vundle' ]]; then
		git clone https://github.com/VundleVim/Vundle.vim.git "/home/$HOME_NAME/.vim/bundle/Vundle.vim"
	elif [[ "$OPTPLUGINMANAGER" == 'vim-plug' ]]; then
		mkdir -p "/home/$HOME_NAME/.vim/autoload"
		curl -fLo "/home/$HOME_NAME/.vim/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	fi
} catch {
	print_failure "Fatal Error: Could not clone Package Manager. " $__EXCEPTION_LINE__
	exit 7
}

try {
	if [[ "$OPTAUTOCOMPLETION" == 'YouCompleteMe' ]]; then
		print_addtask "Installing build tools for auto-completion plugins (YouCompleteMe)..."
		if ! command_exists clang; then
			print_notfound clang
			call_manager clang
		fi
		if ! command_exists cmake; then
			print_notfound cmake
			call_manager cmake
		fi
	elif [[ "$OPTAUTOCOMPLETION" == 'coc.nvim' ]]; then
		# Install node.js
		install_nodejs
		# Optional install yarn if you want install extension by CocInstall command
		if ! command_exists yarn; then
			print_notfound yarn
			call_manager yarn
		fi
		#curl --compressed -o- -L https://yarnpkg.com/install.sh | bash
	fi
	# Install python - Dependency of YouCompleteMe + Several other plugins
	install_python
	print_addtask "Installing flake8, pep8, and jedi for Python-enabled vim components..."
	try {
		sudo pip install pep8
		sudo pip install flake8
		sudo pip install jedi
		sudo pip install pynvim
		# Reference: [https://jedi.readthedocs.io/en/latest/docs/installation.html]
	}
	catch {
		print_failure "Could not install python language dependencies."
	}

	print_addtask "Installing ctags for tagging plugins (Tagbar or Vista)..."
	try {
		# Install the newer Universal ctags - Download and compile
		try {
			call_manager libjansson-dev
			call_manager libseccomp-dev
			call_manager libyaml-dev
			call_manager libxml2-dev
			call_manager automake
			call_manager autoconf
			call_manager pkg-config
		}
		catch {
			print_failure "Could not install one or more of ctags' required libraries. Proceeding with installation regardless."
		}
		cd /home/$HOME_NAME/.vim
		git clone https://github.com/universal-ctags/ctags.git --depth=1
		cd ctags
		./autogen.sh
		./configure
		make
		# User-specific instead of system-global using sudo:
		# make install
		# ./configure --prefix=$HOME
		sudo make install
		ctags --version
		cd ..
		sudo rm -rf ctags

		# References:
		#	[https://askubuntu.com/questions/796408/installing-and-using-universal-ctags-instead-of-exuberant-ctags]
		#	[https://github.com/universal-ctags/ctags/blob/master/docs/autotools.rst]
	}
	catch {
		# Install the older Exuberant ctags, instead
		call_manager ctags
	}
	# Intro: [https://andrew.stwrt.ca/posts/vim-ctags/]
	# Reference: [https://github.com/liuchengxu/vista.vim]

	print_addtask "Installing shellcheck, an add-on to ALE..."
	call_manager shellcheck

	print_addtask "Installing muPDF viewer for PDF-generating plugins (vimtex)..."
	call_manager mupdf

	print_addtask "Installing xdotool, a dependency for vimtex..."
	call_manager xdotool

	print_addtask "Installing Ripgrep, a dependency replacement for FZF..."
	call_manager ripgrep

	print_addtask "Installing Ag (the Silver Searcher), a dependency replacement for Ack for plugin ack.vim..."
	call_manager the_silver_searcher
	# Ack = Perl script for better regexp searches of source code than grep - https://beyondgrep.com/
	# Ag = The Silver Searcher - Not dependent on Perl dependencies (i.e., Strawberry Perl on Windows for consistency)

	print_addtask "Installing fzf, a fuzzy file finder..."
	try {
		if [ -d "/home/$HOME_NAME/.fzf" ]; then
			rm -rf "/home/$HOME_NAME/.fzf"
		fi
		git clone --depth 1 https://github.com/junegunn/fzf.git "/home/$HOME_NAME/.fzf"
		cd "/home/$HOME_NAME/.fzf/"
		./install --all
		cd "$SCRIPTROOT"
	}
	catch {
		# Give this a try instead:
		call_manager fzf
	}

	print_addtask "Installing pandoc, a dependency for pandoc.vim..."
	call_manager pandoc
	# Ack = A command-line program for converting files between different markup formats - https://pandoc.org/

	print_success "Dependencies installed successfully."
	echo ''
} catch {
	print_failure "Could not install one or more plugin dependencies."
}


# ===========================================
# Installing Vim
# ===========================================

# Vim or gVim
try {
	call_manager gvim
	# This package usually includes Vim and gVim
} catch {
	call_manager vim
	# If the gvim package did not work, install the vim package (which is usually already installed on most GNU/Linux-based systems and would simply lead to a reinstallation)
}
# Neovim and Neovim-QT
try {
	call_manager neovim
	call_manager neovim-qt
} catch {
	# Do nothing
	print_failure "Error: Could not install Neovim"
}
# Tmux
try {
	call_manager tmux
} catch {
	# Do nothing
	print_failure "Error: Could not install Tmux"
}

if [ $? -eq 0 ]; then
	print_success "Installed vim components successfully."
else
	print_failure "Fatal Error: Could not install gvim and/or neovim." >&2
	exit 7
fi

# vim - This is the normal vim package. It is in conflict with gvim, which will overwrite it. Vim also comes already installed on most Linux distributions.
# gvim - This is a GUI front to vim which adds a helpful menu with many vim options
# neovim - (a.k.a. nvim) Neovim is a fork of vim which adds better support for multiple asynchronous plugins (necessary when turning vim into an IDE)
# neovim-qt - This is a GUI front to nvim.
# tmux - This is a terminal multiplexer/terminal manager - https://tmux.github.io/
echo ''


# ===========================================
# Making .vimrc
# ===========================================

echo "=== Building .vimrc ==="

print_addtask "[+] Compiling the .vimrc file..."

try {
	cd "$SCRIPTROOT"
	# Build the final .vimrc file

	# (1) Settings
	echo '"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""' > ./build/.vimrc
	echo '" === SETTINGS                                                 ' >> ./build/.vimrc
	echo '"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""' >> ./build/.vimrc
	echo '" === VimSetup-Specific Settings:                              ' >> ./build/.vimrc
	echo '" Level: Basic vs Full                                         ' >> ./build/.vimrc
	if [[ "$OPTLEVEL" == 'full' ]]; then
		echo "let g:vimsetup_level = 'full'" >> ./build/.vimrc
	elif [[ "$OPTLEVEL" == 'basic' ]]; then
		echo "let g:vimsetup_level = 'basic'" >> ./build/.vimrc
	fi
	echo "" >> ./build/.vimrc

	# (2) Header
	cat ./vimrcs/vimrc_header.vim >> ./build/.vimrc

	# (3) Package List - Select by plugin manager
	if [[ "$OPTPLUGINMANAGER" == 'Vundle' ]]; then
		cat ./vimrcs/vimrc_packagelist.vim >> ./build/.vimrc
	elif [[ "$OPTPLUGINMANAGER" == 'vim-plug' ]]; then
		cat ./vimrcs/vimrc_packagelist.vim-plug.vim >> ./build/.vimrc
	fi

	# (4) Add Auto-Completion Plugin to the end of the Build (after PackageList)
	if [[ "$OPTAUTOCOMPLETION" == 'YouCompleteMe' ]]; then
		echo '"' \ "=== Autocompletion ===" >> ./build/.vimrc
		echo '"' \ "--- YouCompleteMe (YCM) & Dependencies" >> ./build/.vimrc
		if [[ "$OPTPLUGINMANAGER" == 'Vundle' ]]; then
			echo "Plugin 'ycm-core/YouCompleteMe'" >> ./build/.vimrc
			echo "Plugin 'rdnetto/YCM-Generator'" >> ./build/.vimrc
			# Use Tagbar instead of Vista.vim for a Vundle-managed YouCompleteMe installation
			echo "Plugin 'majutsushi/tagbar'" >> ./build/.vimrc
		elif [[ "$OPTPLUGINMANAGER" == 'vim-plug' ]]; then
			echo "Plug 'ycm-core/YouCompleteMe'" >> ./build/.vimrc
			echo "Plug 'rdnetto/YCM-Generator'" >> ./build/.vimrc
		fi
		echo "	let g:vimsetup_autocompletion='YouCompleteMe'" >> ./build/.vimrc
		echo "" >> ./build/.vimrc
	elif [[ "$OPTAUTOCOMPLETION" == 'coc.nvim' ]]; then
		echo '"' \ "=== Autocompletion ===" >> ./build/.vimrc
		echo '"' \ "--- coc.nvim & Dependencies" >> ./build/.vimrc
		if [[ "$OPTPLUGINMANAGER" == 'Vundle' ]]; then
			echo "Plugin 'neoclide/coc.nvim'" >> ./build/.vimrc
		elif [[ "$OPTPLUGINMANAGER" == 'vim-plug' ]]; then
			# echo "Plug 'neoclide/coc.nvim'" >> ./build/.vimrc
			echo "Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}" >> ./build/.vimrc
		fi
		echo "	let g:vimsetup_autocompletion='coc.nvim'" >> ./build/.vimrc
		# echo "	let g:coc_global_extensions = [ 'coc-json', 'coc-python', 'coc-git', 'coc-tsserver', 'coc-eslint', 'coc-snippets' ]" >> ./build/.vimrc
		echo "" >> ./build/.vimrc
	fi
	# (5) Footer
	cat ./vimrcs/vimrc_footer.vim >> ./build/.vimrc

	print_success ".vimrc compiled successfully."
} catch {
	print_failure "Fatal Error: Could not build .vimrc file." $__EXCEPTION_LINE__
	print_failure "IMPORTANT: Please rerun this script to rebuild and install this file."
	exit 7
}
print_addtask "[+] Copying over the .vimrc file..."
try {
	detection_overwrite "/home/$HOME_NAME/.vimrc"
	#try {
	#	if [[ -f "/home/$HOME_NAME/.vimrc" ]]; then
	#		echo "Detected an existing .vimrc file. Performing backup before overwriting..."
	#		mv "/home/$HOME_NAME/.vimrc" "/home/$HOME_NAME/.vimrc.backup"
	#	fi
	#}
	#catch {
	#	print_failure "Fatal Error: Could not make a backup of the detected .vimrc file '/home/$HOME_NAME/.vimrc'"
	#	exit 7;
	#}
	cat ./build/.vimrc > "/home/$HOME_NAME/.vimrc"
} catch {
	print_failure "Fatal Error: Could not relocate .vimrc file to destination directory '/home/$HOME_NAME/'"
	exit 7
}
print_addtask ".vimrc copied successfully."

# Since the file is referred to within .vimrc, reserve a blank file for it to prevent errors, then finish making it after plugins are installed
print_addtask "[+] Reserving a place for the runtime.*.vim files..."
try {
	try {
		dir="/home/$HOME_NAME/.vim_runtime"
		detection_overwrite $dir clobber
		# sudo rm -rf "/home/$HOME_NAME/.vim_runtime"
		mkdir -p $dir
		print_success "Successfully created the .vim_runtime directory."
	} catch {
		print_failure "Could not backup and recreate the .vim_runtime directory. Proceeding regardless..."
	}
	touch "/home/$HOME_NAME/.vim_runtime/runtime.basic.vim"
	echo "
		set encoding=utf-8
		let g:session_autosave = 'no'

	if has('win16') || has('win95') || has('win32') || has('win64')
		let g:vimsetup_platform = 'win'
	else
		let s:os = substitute(system('uname'), '\n', '', '')
		if has('macunix') || system('uname') =~? '^darwin'
			let g:vimsetup_platform = 'mac'
		elseif system('cat /proc/sys/kernel/osrelease') =~? 'Microsoft' || has('wsl')
			let g:vimsetup_platform = 'wsl'
		elseif has('win32unix')
			let g:vimsetup_platform = 'cygwin'
		elseif has('linux') || s:os == 'Linux' || system('uname') =~? '^linux'
			let g:vimsetup_platform = 'linux'
		elseif executable('lemonade')
			let g:vimsetup_platform = 'lemonade'
		else
			let g:vimsetup_platform = 'unknown'
		endif
	endif
	" > "/home/$HOME_NAME/.vim_runtime/runtime.basic.vim"
	touch "/home/$HOME_NAME/.vim_runtime/runtime.extended.vim"

	print_success "runtime.vim files reserved successfully."

} catch {
	# This is a non-fatal error: only fatal if the attempt to build and copy the final runtime.vim files fail.
	print_failure "Could not reserve a placeholder runtime.vim file in the destination directory '/home/$HOME_NAME/.vim_runtime/'." $__EXCEPTION__
	print_failure "IMPORTANT: Please rerun this script to rebuild and install this file."
	exit 7
}

echo ''


# ===========================================
# Copying Assets
# ===========================================

echo "=== Copying Assets ==="
echo ''

echo "Copying the ctags Configuration File ==="
# Vim-specific ctags Configuration File
# Copy files (\ is for using cp without an alias if cp is aliased to cp -i by default by the user's Linux distribution)
try {
	print_addtask "Installing ctags' configuration file..."
	detection_overwrite "/home/$HOME_NAME/.ctags" clobber
	# Vim-specific ctags Configuration File
	# Copy files
	\cp -rf ./assets/.ctags "/home/$HOME_NAME/"
	# Credit & Reference: https://andrew.stwrt.ca/posts/vim-ctags/

	print_success "ctags setup successfully."
} catch {
	print_failure "Could not copy ctags configuration file."
}
echo ''


echo "Copying Plugin Settings ==="
echo ''
# Copy files (\ is for using cp without an alias if cp is aliased to cp -i by default by the user's Linux distribution)
try {
	print_addtask "Installing plugin configuration files..."

	detection_overwrite "/home/$HOME_NAME/.vim_runtime/settings_plugins" clobber
	# sudo rm -rf "/home/$HOME_NAME/.vim_runtime/settings_plugins"
	\cp -rf ./assets/settings_plugins "/home/$HOME_NAME/.vim_runtime/"

	print_success "Plugin Settings: installed successfully."
} catch {
	print_failure "Could not copy plugin settings directory."
}
echo ''

print_action "Copying Snippets ==="

# === UltiSnips
# Pull down the latest UltiSnips snippets -- [https://askubuntu.com/a/729798]
print_addtask "[+] Installing default vim-snippets to the Ultisnips directory..."
	try {
		print_addtask "Setting up snippets installation..."
		detection_overwrite "/home/$HOME_NAME/.vim/plugin_ultisnips"
		cd "/home/$HOME_NAME/.vim/"
		git clone --depth 1 https://github.com/honza/vim-snippets.git plugin_ultisnips
		cd plugin_ultisnips
		git filter-branch --prune-empty --subdirectory-filter UltiSnips HEAD
		print_success "Installed default vim-snippets successfully."
	} catch {
		print_failure "Could not create installation directory for snippets."
	}
# Snippets
	print_addtask "Installing snippets..."
	try {
		\cp -r $SCRIPTROOT/assets/plugin_ultisnips "/home/$HOME_NAME/.vim/"
	} catch {
		print_failure "Could not copy snippet assets directory to target directory."
	}

print_success "Snippets installed successfully."
# === User-Specific/Personal Snippets
	try {
		print_addtask "Creating a user-specific personal snippet directory if it does not already exist..."
		mkdir -p "/home/$HOME_NAME/.vim/user_snippets"
		# No overwriting, if it exists let this fail...
	} catch {
		print_failure "Could not create installation directory for snippets."
	}

cd "$SCRIPTROOT"

echo ''

print_action "Copying filetype directories ==="
try {
	print_addtask "Installing ftdetect directory..."
	detection_overwrite "/home/$HOME_NAME/.vim/ftdetect"
	\cp -r $SCRIPTROOT/assets/ftdetect "/home/$HOME_NAME/.vim/"

	print_addtask "Installing ftplugin directory..."
	detection_overwrite "/home/$HOME_NAME/.vim/ftplugin"
	\cp -r $SCRIPTROOT/assets/ftplugin "/home/$HOME_NAME/.vim/"

	print_success "Installed filetype directories successfully."
} catch {
	print_failure "Could not install filetype directories to target directory."
}

echo ''


# ===========================================
# Plugin Settings
# ===========================================

echo "=== Setting up Plugins ==="

print_addtask "[+] Setting up Temporary Directories: Persistent Undo buffer, backup, swap, and ctags..."
try {
	# Create initial temporary directories for Backup files, Swap files, and Undo files. If these are delete.
	#	Local storage can be accomplished using directories: ./backup, ./backup/undo, and ./backup/swap ... or ./backup.vim, ./backup.vim/undo, and ./backup.vim/swap
	detection_overwrite "/home/$HOME_NAME/.vim/temp_dirs"
	mkdir -p "/home/$HOME_NAME/.vim/temp_dirs"
	mkdir -p "/home/$HOME_NAME/.vim/temp_dirs/undo"
	mkdir -p "/home/$HOME_NAME/.vim/temp_dirs/backup"
	mkdir -p "/home/$HOME_NAME/.vim/temp_dirs/swap"
	mkdir -p "/home/$HOME_NAME/.vim/temp_dirs/ctags"
	print_success "Temporary directories created successfully."
} catch {
	print_failure "Could not create/install temporary directories to target directory."
}

# Plugins
print_addtask "Installing vim plugins..."
try {
	if [[ "$OPTPLUGINMANAGER" == 'Vundle' ]]; then
		vim +PluginInstall +qall
	elif [[ "$OPTPLUGINMANAGER" == 'vim-plug' ]]; then
		vim "+PlugInstall --sync" +qall
	fi
	print_success "Plugins installed successfully."
} catch {
	print_failure "Error occurred while installing vim plugins." $__EXCEPTION_LINE__
}
	# Plugin: Vim-Prettier
	try {
		# Setup Vim-Prettier if the plugin was specified since Vundle can't do this on its own
		if [[ "$OPTPLUGINMANAGER" == 'Vundle' ]]; then
			if [[ -d "/home/$HOME_NAME/.vim/bundle/vim-prettier" ]] ; then
				cd "/home/$HOME_NAME/.vim/bundle/vim-prettier"
				if command_exists yarnpkg; then
					yarnpkg install --frozen-lockfile
				else
					yarn install --frozen-lockfile
				fi
			fi
			print_success "Vim-Prettier plugin installed successfully."
		fi
	} catch {
		print_failure "Error occurred while installing vim-prettier." $__EXCEPTION_LINE__
	}

# Auto-Completion
print_addtask "Setting up Auto-Completion: $OPTAUTOCOMPLETION"
if [[ "$OPTAUTOCOMPLETION" == 'YouCompleteMe' ]]; then
	# (1) Configuring Language Support
	print_addtask "Determining Language Support for YouCompleteMe (YCM)..."
	try {
		YCM_FLAGS=""
		if [[ $OPT_INSTALLALL == true ]]; then
			YCM_FLAGS="--all"
		else
			# Install the language runtimes and their dependencies, then set the flag for YouCompleteMe to install language support for these languages.
			if [[ "$OPT_INSTALLRUST" ]];	then YCM_FLAGS="$YCM_FLAGS --rust-completer";	install_rust; setup_rust; fi
			if [[ "$OPT_INSTALLGO" ]]; 		then YCM_FLAGS="$YCM_FLAGS --go-completer";		install_go; fi
			if [[ "$OPT_INSTALLCLANG" ]]; 	then YCM_FLAGS="$YCM_FLAGS --clang-completer";	install_clang; fi
			if [[ "$OPT_INSTALLCLANGD" ]]; 	then YCM_FLAGS="$YCM_FLAGS --clangd-completer";	install_clangd; fi
			if [[ "$OPT_INSTALLCSHARP" ]]; 	then YCM_FLAGS="$YCM_FLAGS --cs-completer";		install_csharp; fi
			if [[ "$OPT_INSTALLJS" ]]; 		then YCM_FLAGS="$YCM_FLAGS --ts-completer";		install_nodejs; fi
			if [[ "$OPT_INSTALLJAVA" ]]; 	then YCM_FLAGS="$YCM_FLAGS --java-completer";	install_java; fi
		fi
		print_success "Configured language support for YouCompleteMe successfully."
	} catch {
		print_failure "Errors configuring languages for YouCompleteMe." $__EXCEPTION_LINE__
	}
	# (2) Installation
	print_addtask "Setting up YouCompleteMe (YCM)..."
	try {
		cd "/home/$HOME_NAME/.vim/bundle/YouCompleteMe"
		./install.py --clang-completer $YCM_FLAGS
		print_success "Plugin YouCompleteMe installed successfully."
	} catch {
		print_failure "Error occurred while installing YouCompleteMe." $__EXCEPTION_LINE__
	}
	# (3) Configuration
	# To solve the following error: "NoExtraConfDetected: No .ycm_extra_conf.py file detected, so no compile flags are available. Thus no semantic support for C/C++/ObjC/ObjC++. Go READ THE DOCS *NOW..."...
	#	Go here: https://github.com/ycm-core/YouCompleteMe#option-1-use-a-compilation-database
	print_addtask "Configuring YouCompleteMe (YCM)..."
	try {
		mkdir -p "/home/$HOME_NAME/.vim/plugin_YouCompleteMe"
		mkdir -p "/home/$HOME_NAME/.vim/plugin_YouCompleteMe/buildflags"
		touch "/home/$HOME_NAME/.vim/plugin_YouCompleteMe/buildflags/ycm_global_ycm_extra_conf.py"
		echo "def Settings( **kwargs ):
		  return {
			'flags': [ '-x', 'c++', '-Wall', '-Wextra', '-Werror' ],
		  }" > "/home/$HOME_NAME/.vim/plugin_YouCompleteMe/buildflags/ycm_global_ycm_extra_conf.py"

		print_success "Plugin Settings setup complete."
	} catch {
		print_failure "Could not configure YouCompleteMe -- consider configuring it manually and referring to its documentation."
	}
elif [[ "$OPTAUTOCOMPLETION" == "coc.nvim" ]]; then
	print_addtask "Setting up coc.nvim..."
	cd "/home/$HOME_NAME/.vim/bundle/coc.nvim"
	try {
		try {
			# Try to install from a binary compiled from source
				# git clean -xfd
			if command_exists yarnpkg; then
				yarnpkg install --frozen-lockfile
			else
				yarn install --frozen-lockfile
			fi
			# Restart the RPC & Install coc.nvim Extensions
			vim "+call coc#rpc#restart()" +qall
			vim -c 'CocInstall -sync coc-git|q'
			vim -c 'CocInstall -sync coc-snippets|q'
			vim -c 'CocInstall -sync coc-pairs|q'
			vim -c 'CocInstall -sync coc-lists|q'
			vim -c 'CocInstall -sync coc-highlight|q'
		} catch {
			print_failure "Installing coc.nvim from source code failed. Attempting to install via precompiled binary instead..."
			# To install via binary instead:
			vim "+call coc#util#install()" +qall
		}

		print_success "Auto-Completion with coc.nvim installed and setup successfully."
		print_success "Plugin Settings setup complete."
	}
	catch {
		print_failure "Could not install/configure coc.nvim -- consider performing these tasks manually after referring to its documentation."
	}
	try {
		print_addtask "Installing language-servers..."
		# Create the coc-settings.json file...
		# 	Copy files (\ is for using cp without an alias if cp is aliased to cp -i by default by the user's Linux distribution)
		cd "$SCRIPTROOT"
		try {
			\cp -rf ./assets/coc-settings.json "/home/$HOME_NAME/.vim/coc-settings.json"
			print_success "coc-settings.json file copied successfully."
		}
		catch {
			print_failure "Could not copy coc.nvim configuration file."
		}
		# References: [https://github.com/phux/.dotfiles/blob/master/roles/neovim/files/conf/coc-settings.json]

		# Language Servers: Install
			# Shell - Bash Language Server
			try {
				if [[ "$OPT_INSTALLALL" ]] || [[ "$OPT_INSTALLBASHLS" ]]; then
					install_bashls
				fi
				#call_manager bash-language-server
				bash-language-server --version
				print_success "Installed the Bash Language Server successfully."
			}
			catch {
				print_failure "Could not install language server 'bash-language-server'. Consider installing it manually."
			}
			# Rust
			try {
				if [[ "$OPT_INSTALLALL" ]] || [[ "$OPT_INSTALLRUST" ]]; then
					install_rust
					rustc --version
				fi
				if command_exists rustup; then
					cd "/home/$HOME_NAME/.vim/"
					setup_rust
					# Install coc-rls
					vim -c 'CocInstall -sync coc-rls|q'
					vim -c 'CocInstall -sync coc-rust-analyzer|q'
					print_success "Installed Rust language server dependencies successfully."
				fi
			}
			catch {
				print_failure "Could not install Rust language server dependencies. Consider installing it manually."
			}
			# Go
			try {
				if [[ "$OPT_INSTALLALL" ]] || [[ "$OPT_INSTALLGO" ]]; then
					install_go
					go version
				fi
				if command_exists go; then
					try {
						go get -u github.com/sourcegraph/go-langserver
						# References:
						#	[https://golang.org/doc/code.html#GOPATH]
						#	[https://github.com/golang/go/wiki/SettingGOPATH]
						print_success "Installed go-langserver by Sourcegraph successfully."
					} catch {
						print_failure "Error: Could not install the go language server from Sourcegraph. Trying gopls..."
						try {
							go get golang.org/x/tools/gopls@latest
						} catch {
							print_failure "Error: Could not install gpls."
						}
					}
					vim -c 'CocInstall -sync coc-go|q'
				fi
			}
			catch {
				print_failure "Could not install Go language server dependencies. Consider installing it manually."
			}
			# C/C++ (ClangD) -- Easier to install, faster; Less features
			try {
				if [[ "$OPT_INSTALLCLANGD" ]] || [[ "$OPT_INSTALLALL" ]]; then
					install_clangd
				else
					echo 'Skipping clangd installation...'
				fi
			}
			catch {
				print_failure "Could not install language server 'clangd'. Consider installing it manually."
			}
			# C/C++ (CCLS) -- More features; Slower, more difficult to install
			try {
				if [[ "$OPT_INSTALLCCLS" ]]; then
					install_ccls
				else
					echo 'Skipping CCLS installation...'
				fi
			}
			catch {
				print_failure "Could not install language server 'CCLS'. Consider installing it manually."
			}
			# Python
			#	Use of extension coc-python instead is encouraged
			try {
				if [[ "$OPT_INSTALLALL" ]] || [[ "$OPT_INSTALLPYTHON" ]]; then
					install_python
				fi
				if command_exists pip; then
					# If pip, and by proxy python, are installed (or were installed with the python install flags), install the python language server.
					sudo pip install 'python-language-server[all]'

					# Install Linters
					sudo pip install autopep8
					sudo pip install pylint
					# sudo pip install yapf
					vim -c 'CocInstall -sync coc-python|q'
					#call_manager python-language-server
				fi
			}
			catch {
				print_failure "Could not install language server 'python-language-server'. Consider installing it manually."
			}
			# PHP
			try {
				if [[ "$OPT_INSTALLALL" ]] || [[ "$OPT_INSTALLPHP" ]]; then
					install_nodejs
					# sudo npm install --unsafe-perm intelephense -g
					sudo npm install -g intelephense
				fi
			}
			catch {
				print_failure "Could not install language server 'intelephense'"
			}
			# Ruby
			#	Use of extension coc-solargraph instead is encouraged
			try {
				if [[ "$OPT_INSTALLALL" ]] || [[ "$OPT_INSTALLRUBY" ]]; then
					install_ruby
				fi
				if command_exists gem; then
					try {
						sudo gem install sorbet
						sudo gem install sorbet-runtime
						srb --version
						print_success "Successfully installed Sorbet for Ruby."
					} catch {
						print_failure "Could not install sorbet for Ruby. Trying solargraph..."
						try {
							sudo gem install solargraph
							vim -c 'CocInstall -sync coc-solargraph|q'
						print_success "Successfully installed Solargraph for Ruby."
						} catch {
							print_failure "Could not install solargraph for Ruby."
						}
					}
				else
					if [[ "$OPT_INSTALLALL" ]] || [[ "$OPT_INSTALLRUBY" ]]; then
						print_failure "Could not install Ruby language server: 'gem' from Ruby not detected. Consider installing the LSP manually."
					else
						echo 'Skipping language server support installation for Ruby...'
					fi
				fi
			}
			catch {
				print_failure "Could not install language server 'solargraph'. Consider installing it manually."
			}
			# Vim, eruby, and markdown - EFM Language Server
			try {
				if [[ "$OPT_INSTALLALL" ]] || [[ "$OPT_INSTALLVIM" ]] || [[ "$OPT_INSTALLRUBY" ]] || [[ "$OPT_INSTALLMARKDOWN" ]]; then
					install_go
				fi
				if [[ "$OPT_INSTALLVIM" ]]; then
					vim -c 'CocInstall -sync coc-vimlsp|q'
				fi
				if [[ "$OPT_INSTALLVIM" ]] || [[ "$OPT_INSTALLRUBY" ]] || [[ "$OPT_INSTALLMARKDOWN" ]]; then
					if ! command_exists go; then
						print_failure "Could not install efm language server: 'Go' not detected. Consider installing the LSP manually."
					else
						echo "Go detected."
						# Prepare to install configuration file
						try {
							# Create the efm-langserver directory if it does not yet exist
							sudo mkdir -p "/home/$HOME_NAME/.config"
							detection_overwrite "$HOME/.config/efm-langserver" clobber
							sudo mkdir -p "/home/$HOME_NAME/.config/efm-langserver"
							# sudo touch "/home/$HOME_NAME/.config/efm-langserver/config.yaml"
							sudo chown -R $HOME_NAME:$HOME_NAME "/home/$HOME_NAME/.config/efm-langserver"
							print_addtask "Setting up efm-langserver.vim..."
						}
						catch {
							print_failure "Could not create configuration directory for efm-langserver."
						}
						# Copy the Configuration File
						try {
							dir_efmcfg="/home/$HOME_NAME/.config/efm-langserver/config.yaml"
							\cp -rf ./assets/plugin_cocnvim/config.efm-langserver.yaml $dir_efmcfg
						}
						catch {
							print_failure "Could not insert configuration into config directory."
						}
						# Install efm-langserver
						try {
							go get https://github.com/mattn/efm-langserver/cmd/efm-langserver
						}
						catch {
							print_failure "Could not install efm-langserver via go."
						}
						# Install Linters:
						# (1) htmlbeautifier
						if command_exists gem; then
							# For HTML
							gem install htmlbeautifier
							print_success "Successfully installed htmlbeautifier."
							# For SCSS
							gem install compass
							print_success "Successfully installed compass."
						else
							print_failure "Could not install htmlbeautifier and/or compass."
						fi
						# (2) vint
						if command_exists pip; then
							sudo pip install vim-vint
							print_success "Successfully installed vint."
						else
							print_failure "Could not install vint."
						fi
						# (3) yamllint
						if command_exists pip; then
							# yamllint - Linting of yaml code
							sudo pip install yamllint
							print_success "Successfully installed yamllint."

							# coc-yaml - Auto-completion of yaml code
							vim -c 'CocInstall -sync coc-yaml|q'
							print_success "Successfully installed coc-yaml."
						else
							print_failure "Could not install yamllint and/or coc-yaml."
							# Try installing js-yaml
							sudo npm install -g js-yaml
						fi
						# (4) mdl (MarkdownLinter)
						if command_exists gem; then
							gem install mdl
							print_success "Successfully installed MarkdownLinter (mdl)."
						else
							print_failure "Could not install MarkdownLinter (mdl)..."
						fi
					fi
				else
					echo 'Skipping EFM Language Server installation...'
				fi
			}
			catch {
				print_failure "Could not install language server 'efm-langserver'. Consider installing it manually."
			}
			# JavaScript: TypeScript Language Server, Vue.js Language Sever
			try {
				if [[ "$OPT_INSTALLALL" ]] || [[ "$OPT_INSTALLJS" ]]; then
					# NodeJS (installed earlier for coc.nvim, but just to guarantee it will be installed, have the function check for it again)
					try {
						install_nodejs
						install_js
						typescript-language-server --stdio --version
					}
					catch {
						print_failure "Could not install JavaScript language components. Consider installing them manually."
					}

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

					print_success "Installed JavaScript language server components successfully."
				fi
			}
			catch {
				print_failure "Could not install JavaScript-related language servers. Consider installing them manually."
			}
			# C# (CSharp)
			try {
				if [[ "$OPT_INSTALLALL" ]] || [[ "$OPT_INSTALLCHSARP" ]]; then
					install_csharp
				fi
				if command_exists mono; then
				# Install coc-omnisharp
				vim -c 'CocInstall -sync coc-omnisharp|q'
					print_success "Installed C# language server dependencies successfully."
				fi
			}
			catch {
				print_failure "Could not install C# language server dependencies. Consider installing them manually."
			}
			# Java
			try {
				if [[ "$OPT_INSTALLALL" ]] || [[ "$OPT_INSTALLJAVA" ]]; then
					install_java
				fi
				if command_exists java; then
					# Install coc-java
					vim -c 'CocInstall -sync coc-java|q'
					print_success "Installed Java language server dependencies successfully."
				fi
			}
			catch {
				print_failure "Could not install Java language server dependencies. Consider installing it manually."
			}
			# LaTeX
			try {
				if [[ "$OPT_INSTALLALL" ]] || [[ "$OPT_INSTALLLATEX" ]]; then
					install_latex
				fi
				if command_exists latex; then
					try {
						vim -c 'CocInstall -sync coc-vimtex|q'
					}
					catch {
						if command_exists npm && command_exists cargo; then
							cd "/home/$HOME_NAME/.vim"
							git clone --depth=1 --recursive https://github.com/latex-lsp/texlab
							cd texlab
							cargo build --release
						fi
						# Install coc-texlab - If neither npm nor cargo are available, it will install the prebuilt binary for texlab.
						vim -c 'CocInstall -sync coc-texlab|q'
					}
					print_success "Installed LaTeX language server dependencies successfully."
				fi
			}
			catch {
				print_failure "Could not install LaTeX language server dependencies. Consider installing them manually."
			}
			# Docker
			try {
				if [[ "$OPT_INSTALLALL" ]] || [[ "$OPT_INSTALLDOCKER" ]]; then
					install_nodejs
					sudo npm install -g dockerfile-language-server-nodejs
				fi
				print_success "Installed dockerfile language server dependencies successfully."
			}
			catch {
				print_failure "Could not install language server 'dockerfile'"
			}
	}
	catch {
		print_failure "Could not install language server(s) for coc.nvim -- consider installing these manually."
	}
fi
echo ''


# ===========================================
# Building runtime.vim
# ===========================================
# Runtime.vim files contain .vimrc configurations and all vim-specific settings, and they have to be added in after the plugins are installed.
echo "=== Building runtime.vim files ==="
cd "$SCRIPTROOT"
print_addtask "Compiling the runtime.vim files"
try {
	cat ./vimrcs/basic.vim > ./build/runtime.basic.vim
	cat ./vimrcs/extended.vim > ./build/runtime.extended.vim
	cat ./vimrcs/filetypes.vim >> ./build/runtime.extended.vim
	cat ./vimrcs/schemes_config.vim >> ./build/runtime.extended.vim
	print_success "runtime.vim files compiled successfully."
} catch {
	print_failure "Fatal Error: Failed to build/compile runtime.vim files." $__EXCEPTION_LINE__
	exit 7
}

# This will fill in the runtime.vim files previously reserved when building the .vimrc file
print_addtask "Copying over the runtime.vim files..."
try {
	cat ./build/runtime.basic.vim > "/home/$HOME_NAME/.vim_runtime/runtime.basic.vim"
	cat ./build/runtime.extended.vim > "/home/$HOME_NAME/.vim_runtime/runtime.extended.vim"
	print_success "runtime.vim files copied successfully."
} catch {
	print_failure "Fatal Error: Failed to install runtime.vim files to their destination directory." $__EXCEPTION_LINE__
	exit 7
}
echo ''


# ===========================================
# Font Installation
# ===========================================
echo "=== Installing Fonts ==="
echo "Note: These fonts may also be dependencies for plugin 'vim-devicons'"
try {
	detection_overwrite "/home/$HOME_NAME/.local/share/fonts" clobber
	# sudo rm -rf "/home/$HOME_NAME/.local/share/fonts"
	sudo mkdir -p "/home/$HOME_NAME/.local/share/fonts"

	detection_overwrite "/home/$HOME_NAME/.local/share/fonts/NerdFonts" clobber
	# sudo rm -rf "/home/$HOME_NAME/.local/share/fonts/NerdFonts"
	sudo mkdir -p "/home/$HOME_NAME/.local/share/fonts/NerdFonts"

	cd "/home/$HOME_NAME/.local/share/fonts/NerdFonts/"

	print_addtask "Installing Font: Hack Regular..."
	sudo curl -fLo "Hack Regular Nerd Font Complete Mono.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete%20Mono.ttf
	sudo curl -fLo "Hack Regular Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf

	print_addtask "Installing Font: Hack Bold..."
	sudo curl -fLo "Hack Bold Nerd Font Complete Mono.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Bold/complete/Hack%20Bold%20Nerd%20Font%20Complete%20Mono.ttf
	sudo curl -fLo "Hack Bold Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Bold/complete/Hack%20Bold%20Nerd%20Font%20Complete.ttf

	print_addtask "Installing Font: Hack BoldItalic..."
	sudo curl -fLo "Hack Bold Italic Nerd Font Complete Mono.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/BoldItalic/complete/Hack%20Bold%20Italic%20Nerd%20Font%20Complete%20Mono.ttf
	sudo curl -fLo "Hack Bold Italic Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/BoldItalic/complete/Hack%20Bold%20Italic%20Nerd%20Font%20Complete.ttf

	print_addtask "Installing Font: Hack Italic..."
	sudo curl -fLo "Hack Italic Nerd Font Complete Mono.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Italic/complete/Hack%20Italic%20Nerd%20Font%20Complete%20Mono.ttf
	sudo curl -fLo "Hack Italic Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Italic/complete/Hack%20Italic%20Nerd%20Font%20Complete.ttf

	print_addtask "Installing Font: Droid Sans Mono Regular..."
	sudo curl -fLo "Droid Sans Mono Nerd Font Complete Mono.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete%20Mono.otf
	sudo curl -fLo "Droid Sans Mono Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf

	print_addtask "Installing Font: Fira Code Regular..."
	sudo curl -fLo "Fira Code Regular Nerd Font Complete Mono.otf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/Regular/complete/Fura%20Code%20Regular%20Nerd%20Font%20Complete%20Mono.otf
	sudo curl -fLo "Fira Code Regular Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/Regular/complete/Fura%20Code%20Regular%20Nerd%20Font%20Complete.otf

	print_addtask "Installing Font: Fira Code Bold..."
	sudo curl -fLo "Fira Code Bold Nerd Font Complete Mono.otf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/Bold/complete/Fura%20Code%20Bold%20Nerd%20Font%20Complete%20Mono.otf
	sudo curl -fLo "Fira Code Bold Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/Bold/complete/Fura%20Code%20Bold%20Nerd%20Font%20Complete.otf

	print_addtask "Installing Font: Fira Code Retina..."
	sudo curl -fLo "Fira Code Retina Nerd Font Complete Mono.otf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/Retina/complete/Fura%20Code%20Retina%20Nerd%20Font%20Complete%20Mono.otf
	sudo curl -fLo "Fira Code Retina Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/Retina/complete/Fura%20Code%20Retina%20Nerd%20Font%20Complete.otf

	# Reset the font cache to include this font
	print_addtask "Refreshing font cache ..."
	fc-cache -f -v
	# Verify Correct Installation:
	## fc-list | grep "Hack"
	## fc-match hack
	## fc-list | grep "Droid"
	## fc-match droid
	## fc-list | grep "Fira"
	## fc-match fira

	print_success "Fonts installed successfully."
} catch {
	print_failure "Could not install fonts to their proper destination directory." $__EXCEPTION_LINE__
}
echo ''


# ===========================================
# Neovim (nvim) Settings
# ===========================================
echo " === Neovim Installation ==="
print_addtask "Installing neovim..."
echo "Setting up neovim config directory..."
# try {
	# Create the nvim directory if it does not yet exist
	sudo mkdir -p "/home/$HOME_NAME/.config"

	detection_overwrite "/home/$HOME_NAME/.config/nvim" clobber
	sudo mkdir -p "/home/$HOME_NAME/.config/nvim"
	sudo chown -R $HOME_NAME:$HOME_NAME "/home/$HOME_NAME/.config/nvim"

	## # Create nvim's share directory if it does not yet exist
	## detection_overwrite "/home/$HOME_NAME/.local/share/nvim" clobber
	## sudo mkdir -p "/home/$HOME_NAME/.local/share/nvim"
	## sudo chown -R $HOME_NAME:$HOME_NAME "/home/$HOME_NAME/.local/share/nvim"

	print_addtask "Setting up init.vim..."
	# Create the init.vim file.
	detection_overwrite "/home/$HOME_NAME/.config/nvim/init.vim" clobber
	# Set default init.vim that sets neovim to use the same configuration files as vim (this will overwrite init.vim if it already exists in this directory, consistent with a new installation)
	## echo 'set runtimepath^=~/.vim
	## 	set runtimepath+=~/.vim/after
	## 	let &packpath = &runtimepath
	## 	source ~/.vimrc' > "/home/$HOME_NAME/.config/nvim/init.vim"
	\cp -rf ./assets/basic.init.vim "/home/$HOME_NAME/.config/nvim/init.vim"
	print_success "Added init.vim to vim runtime."

	# Create the ginit.vim file.
	detection_overwrite "/home/$HOME_NAME/.config/nvim/ginit.vim" clobber
	## echo '""" Neovim GUI Settings: -----------------------------------------
	## " Reference: [https://github.com/jdhao/nvim-config/blob/master/ginit.vim]
	## " To check if neovim-qt is running, use `exists("g:GuiLoaded")`,
	## " see https://github.com/equalsraf/neovim-qt/issues/219
	## if exists("g:GuiLoaded")
	## 	" call GuiWindowMaximized(1)
	## 	GuiTabline 0
	## 	GuiPopupmenu 0
	## 	GuiLinespace 2
	## 	if has("win16") || has("win32") || has("win64")
	## 		GuiFont! Hack:h10:l
	## 	endif

	## 	" Use shift+insert for paste inside neovim-qt,
	## 	" see https://github.com/equalsraf/neovim-qt/issues/327#issuecomment-325660764
	## 	inoremap <silent>  <S-Insert>  <C-R>+
	## 	cnoremap <silent> <S-Insert> <C-R>+

	## 	" For Windows, Ctrl-6 does not work. So we use this mapping instead.
	## 	nnoremap <silent> <C-6> <C-^>
	## endif
	## ' > "/home/$HOME_NAME/.config/nvim/ginit.vim"
	\cp -rf ./assets/basic.ginit.vim "/home/$HOME_NAME/.config/nvim/ginit.vim"

	# print_addtask "Creating a symlink between vim and neovim coc-settings.json files..."
	# Symlink - coc-settings.json
	# ln -sf ~/.vim/coc-settings.json "/home/$HOME_NAME/.config/nvim/coc-settings.json"

	# Run nvim and quit just to load all changes from vim into neovim (may be seen as unnecessary but if there's an error, it will pause the installation here)
	print_addtask "Initializing neovim..."
	try {
		nvim +qall
		print_success "Neovim installed successfully."
	}
	catch {
		print_failure "Configuration of Neovim failed. Please consider manually configuring Neovim after the installation has been completed."
	}
# } catch {
# 	print_failure "Error occurred while installing Neovim." $__EXCEPTION__
# }
echo ''

# ===========================================
# Final Steps
# ===========================================

vim --version


print_success "
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

 "

echo ''
print_success "Vim installation & configuration complete."
echo ''

# vim:set foldenable foldmethod=marker:
