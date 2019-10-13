
# VimDistro


Automatically install and configure (Neo)Vim with the most powerful customizations and plugins known
===============================================

<p align="center">
<a href="#build" alt="build"><img src="https://img.shields.io/badge/build-passing-brightgreen.svg" /></a>
<a href="#platform" alt="platform"><img src="https://img.shields.io/badge/platform-MacOSX%20%7C%20Linux%2064bit%20%7C%20Docker-brightgreen.svg" /></a>
<a href="stargazers" alt="stars"><img src="https://img.shields.io/github/stars/IsaacDodd/infinity-vimdistro.svg?style=popout&label=stars" /></a>
<a href="forks" alt="forks"><img src="https://img.shields.io/github/forks/IsaacDodd/infinity-vimdistro.svg?style=popout&label=forks" /></a>
<a href="graphs/contributors" alt="contributors"><img src="https://img.shields.io/github/contributors/IsaacDodd/infinity-vimdistrio" /></a>
<a href="blob/master/LICENSE" alt="lincense"><img src="https://img.shields.io/badge/license-MIT-blue.svg" /></a>
</p>

## Introduction
VimDistro is an installer that will setup and install a customized version of the [Vim](https://en.wikipedia.org/wiki/Vim_(text_editor)) and Neovim editors, which are among the greatest software tools (and [languages](https://thoughtbot.com/blog/mastering-the-vim-language)) for text editing. VimDistro installs **Vim and Neovim** alongside of one another along with several advanced tools that add features to allow Vim to function akin to an advanced IDE-like editor for several languages for web and desktop development and engineering.

* **Cross-Platform**: Install Vim, gVim (or MacVim), and Neovim on most GNU/Linux distributions, MacOS, and Windows. Painstaking care has been taken to ensure a *uniform* experience across all platforms and distributions.
* **Optimization for Speed & Performance**: The code is optimized for speed with efficient. Careful attention has been paid to potential usage bottlenecks (such as plugins that slow down `au CursorHoldI`), `autocmd` groups, and startup speeds for truly unimpaired use.
* **High Customizability**: Modify either the entire installation directory and make it your own or use a tidy local configuration file.
* **Package Management Options**: Choose between the asynchronous and fast [Vim-Plug](https://github.com/junegunn/vim-plug) or the highly stable [Vundle](https://github.com/VundleVim/Vundle.vim) package managers, the best available for Vim.
- **Flexible Usability**: Considerable thought has been poured into the default keymappings, taking care not to conflict with known popular plugins, not overriding Vim's default keymappings, and making keymappings consistent with native insert and normal mode commands.
* **Multi-User GNU/Linux Installation**: Install to any pre-specified home directory on GNU/Linux.
* **Neovim Synchronized Configuration**: Configuring Vim will also configure Neovim with the same features, or configure Neovim's `init.vim` separately.
* **Perfect for Advanced Vim Users**: Sane features and pre-configured design decisions make this setup perfect for advanced users looking for a deeply configurable distribution. Pull requests are always welcome with steady development that won't break your future configurations.
* **Perfect for Learning Vim**: The code behind the distribution is heavily annotated and referenced so you can learn every line in your Vimrc and distribution. Use this distribution as a branching-off point and head start on your own fully personalized custom configuration that fits your unique needs.
* **State of the Art**: Up to date the latest language-server-protocol and >Vim8.1/Neovim 4 changes.

The installation includes many plugins useful for advanced/experienced engineers as well as beginners. The distribution was designed to be used to easily install the setup on any system without much pre-configuration. There are two versions:

1. **Full**: This includes all the useful plugins carefully hand-picked for utility and optimized for performance speed.
2. **Basic**: This version of the distribution is for those who prefer a minimalist approach with lightweight plugins for a setup that is still very powerful but lean. The goals for Basic are to have sensible defaults like [vim-sensible](https://github.com/tpope/vim-sensible) and the stripped-down feel of [Amix Basic](https://github.com/amix/vimrc) while still providing powerful language-server plugins and advanced features.


## Installation Instructions

**Requirements**: (1) Internet Access, (2) Drive Space; The installation is self-contained, downloading what is needing and setting it up without much intervention.

**Step 1**:
The first thing you want to do is download an offline copy of VimDistro. You can do this by manually downloading this repository from GitHub (Clone or Download > Download Zip), or if you have git already installed run:

```Git
git clone https://github.com/IsaacDodd/VimSetup
```

**Step 2: For GNU/Linux, MacOS & \*nix Users**:
To install, download VimDistro and navigate to the directory (i.e., `cd /path/to/VimSetup/`), then just run the following in a terminal:

````Bash
./install.sh
````

You will be prompted to enter a home user directory name (e.g., the YourUsername in /home/YourUsername/). Enter it verbatim and hit enter. The script will then install everything. The setup will automatically detect the proper package manager to use. Follow the prompts.

**Step 2: For Windows Users**:
To install, right-click on the `windows_install.cmd` file and choose 'Run as administrator'. Approve the *User Account Control* prompt by hitting **Yes**.
If you don't already have the Windows package manager '[Chocolatey](https://chocolatey.org/)' installed, the script will install it the first time you run it -- run the script **again** the same way to continue installing VimDistro. The script will then use Chocolatey to install all the dependencies for VimDistro so that you have a working copy of Vim.

**_Caveats of Installing on Windows_**:
- Install Size is >4-5 GB of hard drive space
- The installation is semi-automated since there are a few processes that don't have an option yet to force or bypass confirmation messages:
	- Chocolatey may prompt you after these installations that you need to restart your system.
	- If prompted to associate all .py files with Python, please manually approve the message by hitting 'Yes'. (This does not appear all the time.)
- The Windows script will always install to the user account you are **presently** logged into (for now, to install to another user account on the system, log into that user account and run the installation from there).
- After installing, some fonts are stored in `\.vim\fonts` -- keep these there so that the Windows uninstallation script knows which fonts to remove from your system font folder if you decide to uninstall VimDistro.


### Supported Distributions of GNU/Linux

All major distributions of GNU/Linux are represented (and many minor distributions):
<table>
	<tr>
		<td><a href="https://distrowatch.com/table.php?distribution=arch"><img src="https://distrowatch.com/images/yvzhuwbpy/arch.png"/></a><p align="center"></p></td>
		<td><a href="https://distrowatch.com/table.php?distribution=manjaro"><img src="https://distrowatch.com/images/yvzhuwbpy/manjaro.png"/></a><p align="center"></p></td>
		<td><a href="https://distrowatch.com/table.php?distribution=antergos"><img src="https://distrowatch.com/images/yvzhuwbpy/antergos.png"/></a><p align="center"></p></td>
		<td><a href="https://distrowatch.com/table.php?distribution=ubuntu"><img src="https://distrowatch.com/images/yvzhuwbpy/ubuntu.png"/></a><p align="center"></p></td>
		<td><a href="https://distrowatch.com/table.php?distribution=debian"><img src="https://distrowatch.com/images/yvzhuwbpy/debian.png"/></a><p align="center"></p></td>
		<td><a href="https://distrowatch.com/table.php?distribution=kali"><img src="https://distrowatch.com/images/yvzhuwbpy/kali.png"/></a><p align="center"></p></td>
		<td><a href="https://distrowatch.com/table.php?distribution=deepin"><img src="https://distrowatch.com/images/yvzhuwbpy/deepin.png"/></a><p align="center"></p></td>
		<td><a href="https://distrowatch.com/table.php?distribution=mint"><img src="https://distrowatch.com/images/yvzhuwbpy/mint.png"/></a><p align="center"></p></td>
		<td><a href="https://distrowatch.com/table.php?distribution=elementary"><img src="https://distrowatch.com/images/yvzhuwbpy/elementary.png"/></a><p align="center"></p></td>
		<td><a href="https://distrowatch.com/table.php?distribution=gentoo"><img src="https://distrowatch.com/images/yvzhuwbpy/gentoo.png"/></a><p align="center"></p></td>
	</tr>
	<tr>
		<td><a href="https://distrowatch.com/table.php?distribution=fedora"><img src="https://distrowatch.com/images/yvzhuwbpy/fedora.png"/></a><p align="center"></p></td>
		<td><a href="https://distrowatch.com/table.php?distribution=centos"><img src="https://distrowatch.com/images/yvzhuwbpy/centos.png"/></a><p align="center"></p></td>
		<td><a href="https://distrowatch.com/table.php?distribution=opensuse"><img src="https://distrowatch.com/images/yvzhuwbpy/opensuse.png"/></a><p align="center"></p></td>
		<td><a href="https://distrowatch.com/table.php?distribution=nixos"><img src="https://distrowatch.com/images/yvzhuwbpy/nixos.png"/></a><p align="center"></p></td>
		<td><a href="https://distrowatch.com/table.php?distribution=netbsd"><img src="https://distrowatch.com/images/yvzhuwbpy/netbsd.png"/></a><p align="center"></p></td>
		<td><a href="https://distrowatch.com/table.php?distribution=slackware"><img src="https://distrowatch.com/images/yvzhuwbpy/slackware.png"/></a><p align="center"></p></td>
		<td><a href="https://distrowatch.com/table.php?distribution=redhat"><img src="https://distrowatch.com/images/yvzhuwbpy/redhat.png"/></a><p align="center"></p></td>
		<td><a href="https://distrowatch.com/table.php?distribution=void"><img src="https://distrowatch.com/images/yvzhuwbpy/void.png"/></a><p align="center"></p></td>
		<td><a href="https://distrowatch.com/table.php?distribution=mageia"><img src="https://distrowatch.com/images/yvzhuwbpy/mageia.png"/></a><p align="center"></p></td>
	</tr>
</table>


## Uninstalling

**WARNING**: All options uninstall Vim but also delete your vimrc and runtime.vim files, permanently erasing all your settings and configurations. Don't run an uninstallation unless you're willing to live with permanently erasing everything!

To uninstall VimDistro, follow the following instructions:

**For _Linux/MacOS_ Users**: Just run the following script, following the prompts.

```Bash
./uninstall.sh
```

**For _Windows_ Users**: To uninstall, right-click on the `windows_uninstall.cmd` file and choose 'Run as administrator', then approve the User Account Control prompt, following the script's prompts.

- If fonts do not uninstall, these have to be uninstalled by hand: use the fonts directory at \.vim\fonts as a reference for what to uninstall.
- The uninstallation script has an option to let you uninstall Chocolatey (for a full system uninstallation) -- only do this if you don't already regularly use Chocolatey or if you don't plan to continue to use Chocolatey. This will uninstall Chocolatey but leave packages/software that the installation script did not install in place, which can be catastrophic and lead to broken software if you don't know what you're doing. (This software is provided as is without warranty, as stated in the license.)


## Updating the Installation

**For GNU/_Linux or MacOS_ Users**: To update the installation, just run the following in a terminal:

````Bash
./update.sh
````

**For _Windows_ Users**: To update, right-click on the `windows_update.cmd` file and choose 'Run as administrator', approving the User Account Control prompt, following the script's prompts.


## Editing Settings and Plugins in VimDistro

The file that contains your specific settings for Vim (plugins, colorschemes, etc.) is called the **.vimrc** file (or **\_vimrc** on Windows). This VimSetup uses vimrc but also has additional files called **runtime.vim** under .vim_runtime/runtime.vim (or on Windows **.vim_runtime\runtime.vim**) to specify configuration details to declutter the vimrc file. These files are all installed to the user HOME directory (Linux/MacOS: `~/` also known as `/home/YourUsername/`, or on Windows: `$HOME` also known as `C:\Users\YourUsername`). This is summarized in the following table:

|              OS             | Home Shortcut |             vimrc            |                  vim_runtime                   |
|:---------------------------:|:-------------:|:----------------------------:|:----------------------------------------------:|
| GNU/Linux/MacOS (in a Terminal) | ~/            | /home/YourUsername/.vimrc    | /home/YourUsername/.vim_runtime/runtime.*.vim    |
| Windows  (in PowerShell)    | $HOME/        | C:\Users\YourUsername\_vimrc | C:\Users\YourUsername\.vim_runtime\runtime.*.vim |

runtime.\*.vim in this context stands for both runtime.basic.vim and runtime.extended.vim.

Normally, one would dump everything into the .vimrc file, creating a messy file that becomes a bit unmanageable when trying to debug something. For purposes of organization, this setup divides the plugins to install from general Vim settings and plugin configurations.

**vimrc**: Use this file to specify your **plugins**. The .vimrc divides the plugins by headers alphabetically and into the following categories:

- Package Management
- Main Plugins
- Programming Language Plugins
- Protocol Plugins
- Status Line & Tab Line Plugins
- Color Schemes (Light and Dark)
- Icons

The vimrc file also points to runtime.vim and adds it to Vim's runtime path.

**runtime.vim**: Use this one to specify your **settings**. This file divides the settings by headers alphabetically and into the following categories:
- Basic Settings
- Extended Settings
- Filetype Settings
- Plugin Configurations (ordered alphabetically)
- Schemes (Themes) Configurations

This strategy works because if you decide to uninstall a plugin, the variable settings that are left over in runtime.vim usually in most cases won't break Vim or other plugins. So if you decide to go back to that plugin, you can return to it without too much difficulty remembering the settings (or uncomment them if you comment them out).


# Performance

A goal of this distribution is to optimize startup time and cursor speed in Insert mode. Some simple benchmarking has been performed on a fresh installation with the default settings.

## Startup Times: Full Mode

| OS                            | Terminal Vim    | gVim                           | Neovim                                           | Nvim-QT |
| :---------------------------: | :-------------: | :----------------------------: | :----------------------------------------------: | :-----: |
| GNU/Linux                     | <3.999 secs     | TBA                            | TBA                                              | TBA     |
| Windows  (in PowerShell)      | TBA             | TBA                            | TBA                                              | TBA     |

## Startup Times: Basic Mode

| OS                            | Terminal Vim    | gVim                           | Neovim                                           | Nvim-QT |
| :---------------------------: | :-------------: | :----------------------------: | :----------------------------------------------: | :-----: |
| GNU/Linux                     | TBA             | TBA                            | TBA                                              | TBA     |
| Windows  (in PowerShell)      | TBA             | TBA                            | TBA                                              | TBA     |


# Goals

- **Stability** - Write key mappings congruent with native vim and popular plugins. Create robust vimscript code written to standards that are easy to understand and maintain.
- **Longevity** - Involve a community of maintainers to make sure that updates are regular and pull requests are given strong consideration.
- **Performance** - Have a low startup time and fast insert-mode typing speed.
- **Latest** - Check out and review the latest plugins and keep this distribution up to date with the latest available best methods in Vim.


# Disclaimer

## How to Use VimDistro:

VimDistro serves as a good starting point for making your own customized version of Vim. Over time, as you use Vim your taste in plugins and colorschemes will change. Any vim distribution will always be considered 'bloated' by nature: this is purposeful to the design because you can always scale down what you don't need (i.e., if you don't program in Lua or Haskell, remove the settings and plugins for those languages, etc.). However, as you use Vim, you will do 2 things: (1) you will master its native language features and rely less on plugins, and (2) learn every line of your setup and thus remove or change what is there. This is a part of maturing when using Vim, to 'grok Vi', the original Vim language set from the 1970's. Good advice is to **understand everything that is in your Vim setup**, including everything in the vimrc and runtime files. You will then remove everything you don't use and have a lean setup customized to your needs. Everyone has different experience levels, preferences, and needs and therefore a one-size-fits-most is less useful if it isn't in turn mastered and scaled down by its user.

You are therefore encouraged not just to edit the .vimrc file and runtime.vim on your device but to edit the files and scripts that install VimDistro so that you can always reinstall your entire Vim configuration from this script on a new local machine or remote terminal and have all the configurations and plugins you use ready, on any platform. The best way to do this is to use Git to commit your changes. Also, you can build everything into a 'dotfile' repository that can be simply placed on any system (which is the industry standard). This distribution is therefore just a starting point to have **your own customized Vim editor setup with installation files** where you **understand every line**. If you don't do this, when encountering a problem with the setup you won't have the foundation to solve the problem.

## About VimDistro:

When I was new to vim, I started with '[The Ultimate Vim Configuration](https://github.com/amix/vimrc)' by [Amir Salihefendic](https://www.linkedin.com/in/amix3k) (also known as 'amix') who started the popular app 'ToDoist'. Having an advanced vimrc configuration up and running allowed me to skip many awkward, frustrating beginners stages of getting Vim to do what I wanted it to do initially, which also made learning Vim's editor 'language' a lot easier. It was also better than having to start with Vim's plain UI. Amix's setup has fallen thoroughly out of date, and many modern plugins are missing from it. I also wished that Amix would have included a more thorough summary on how his setup worked (such as which keys he chose to remap and why). So, this VimDistro started as a fork of the original Amix configuration, but subsequently included massive improvements and updates that make it very distinct from the original. I also added a tutorial with a summary of the main key mappings for the plugins for those new to this setup and new to Vim in general.


# Tutorial:

## Using VimDistro & Getting Started with Vim

For a full tour and tutorial of VimDistro and the basis of Vim, click here: [TUTORIAL.md](/TUTORIAL.md)

## Commands

**Click the arrows to expand.**

<details>

<summary> **Basic Commands** </summary>

These are basic commands for this distribution (including some that anyone new to Vim should learn, included for absolute beginners).

Command | Description
--- | ---
`:cd <path>` | Open path */path*
<kbd>,st</kbd> | Open the start screen (via the Startify plugin)
<kbd>Ctrl</kbd> <kbd>w</kbd><kbd>s</kbd>| [S]plit the Window horizontally
<kbd>Ctrl</kbd> <kbd>w</kbd><kbd>v</kbd>| [S]plit the Window [v]ertically
<kbd>Ctrl</kbd><kbd>w</kbd>+<kbd>h</kbd><kbd>j</kbd><kbd>k</kbd><kbd>l</kbd> | Navigate via split panels
<kbd>Ctrl</kbd><kbd>w</kbd><kbd>w</kbd> | Alternative navigate vim split panels
<kbd>,</kbd><kbd>.</kbd> | Set path working directory
<kbd>,</kbd><kbd>w</kbd> or <kbd>,</kbd><kbd>x</kbd> | Next buffer navigate
<kbd>,</kbd><kbd>q</kbd> or <kbd>,</kbd><kbd>z</kbd> | previous buffer navigate
<kbd>shift</kbd><kbd>t</kbd> | Create a tab
<kbd>tab</kbd> | next tab navigate
<kbd>shift</kbd><kbd>tab</kbd> | previous tab navigate
<kbd>,</kbd><kbd>e</kbd> | Find and open files
<kbd>,</kbd><kbd>b</kbd> | Find file on buffer (open file)
<kbd>,</kbd><kbd>c</kbd> | Close active buffer (clone file)
<kbd>F2</kbd>  | Open tree navigate in actual opened file
<kbd>F3</kbd>  | Open/Close tree navigate files
<kbd>F4</kbd> | List all class and method, support for python, go, lua, ruby and php
<kbd>,</kbd><kbd>v</kbd> | Split vertical
<kbd>,</kbd><kbd>h</kbd> | Split horizontal
<kbd>,</kbd><kbd>f</kbd> | Search in the project
<kbd>,</kbd><kbd>o</kbd> | Open github file/line (website), if used git in **github**
<kbd>,</kbd><kbd>s</kbd><kbd>h</kbd> | Open shell.vim terminal inside Vim or NeoVim built-in terminal
<kbd>,</kbd><kbd>g</kbd><kbd>a</kbd> | Execute *git add* on current file
<kbd>,</kbd><kbd>g</kbd><kbd>c</kbd> | git commit (splits window to write commit message)
<kbd>,</kbd><kbd>g</kbd><kbd>s</kbd><kbd>h</kbd> | git push
<kbd>,</kbd><kbd>g</kbd><kbd>l</kbd><kbd>l</kbd> | git pull
<kbd>,</kbd><kbd>g</kbd><kbd>s</kbd> | git status
<kbd>,</kbd><kbd>g</kbd><kbd>b</kbd> | git blame
<kbd>,</kbd><kbd>g</kbd><kbd>d</kbd> | git diff
<kbd>,</kbd><kbd>g</kbd><kbd>r</kbd> | git remove
<kbd>,</kbd><kbd>s</kbd><kbd>o</kbd> | Open Session
<kbd>,</kbd><kbd>s</kbd><kbd>s</kbd> | Save Session
<kbd>,</kbd><kbd>s</kbd><kbd>d</kbd> | Delete Session
<kbd>,</kbd><kbd>s</kbd><kbd>c</kbd> | Close Session
<kbd>></kbd> | indent to right
<kbd><</kbd> | indent to left
<kbd>g</kbd><kbd>c</kbd> | Comment or uncomment lines that {motion} moves over
<kbd>Y</kbd><kbd>Y</kbd> | Copy to clipboard
<kbd>,</kbd><kbd>p</kbd> | Paste
<kbd>Ctrl</kbd><kbd>y</kbd> + <kbd>,</kbd> | Activate Emmet plugin
<kbd>Ctrl</kbd><kbd>h</kbd> | Does a fuzzy search in your command mode history
</details>

<details>
<summary>:black_small_square: Python hotkeys</summary>

Commands | Descriptions
--- | ---
`SHIFT+k` | Open documentation
`Control+Space` | Autocomplete
`,d` | Go to the Class/Method definition
`,r` | Rename object definition
`,n` | Show where command is usage
</details>

<details>
<summary>:black_small_square: Ruby hotkeys</summary>

Commands | Descriptions
------- | -------
`,a`        | Run all specs
`,l`        | Run last spec
`,t`        | Run current spec
`,rap`        | Add Parameter
`,rcpc`     | Inline Temp
`,rel`        | Convert Post Conditional
`,rec`        | Extract Constant          (visual selection)
`,rec`       | Extract to Let (Rspec)
`,relv`     | Extract Local Variable    (visual selection)
`,rrlv`     | Rename Local Variable     (visual selection/variable under the cursor)
`,rriv`     | Rename Instance Variable  (visual selection)
`,rem`      | Extract Method            (visual selection)

</details>
