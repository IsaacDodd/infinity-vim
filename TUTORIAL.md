
# Tutorial: Using VIMSetup

Here is a tutorial on getting started with this setup, which is also a tutorial on how to get started with Vim in general. Feel free to fork this VIMSetup and make it your own. If there's something that you don't like, consistent with why people choose to use Vim over other editors, you can go into the original code and change it. Don't like a mapped key? Find it in the code and fix it! 

## Starting & Working with Files

Start by opening gVim. When you first open gVim you'll be greeted with a start screen (by the [Startify plugin](https://github.com/mhinz/vim-startify)). Hit 'e' to open an empty buffer.

### Introduction to Buffers

A file in memory in Vim is called a '**buffer**'. A buffer always opens inside of a '**window**'. (Try dragging multiple files into Vim right now to open multiple buffers.)  If you have more than one buffer open in memory, you can cycle between those buffers by hitting the <ESC> key to enter Ex/command mode and entering `:bnext` to go to the next buffer and `:bprevious` to go to the previous buffer. In this Vim setup, you can also quickly cycle between buffers by  hitting the **Ctrl+PageDown** or **Ctrl+PageUp** keys.

### Introduction to Windows & Tabs

A container of multiple windows is called a '**tab**' or '**tabpage**'. You can split a tabpage into multiple **windows** by hitting **Ctrl + W + s** to do a horizontal split or **Ctrl + W + v** to do a vertical split. You can transition between windows in a tab page by hitting **Ctrl + W** twice.

You can open a new tabpage by hitting <ESC> to enter Ex/Command-mode and entering `:tabnew`. This is cumbersome to do quickly, so in this setup, this command and those like it have been mapped to convenient keys, so you can hit **Ctrl + T** or **Ctrl + T + n** to create a new tab/tabpage. You can cycle/switch between tabpages by hitting **Ctrl + Tab** to go to the next tab (`:tabnext`) or Ctrl+Tab+Shift to go to the previous tab (`:tabprevious`). This allows you to switch between tabs like any other editor, but in Vim, a tab can contain multiple windows, each with its own files (buffers), and a single window can even more conveniently switch between open buffers.

**Window Resizing**: With several split windows up, the keys have been remapped in this setup to make it so that **Ctrl+ArrowKeys** will resize the window relative to the one next to it. (For example, with two windows split vertically with **Ctrl + W + v**, hitting **Ctrl + RightArrow** or **Ctrl + LeftArrow** will resize the windows relative to one another.) In other editors, hitting **Ctrl + ArrowKeys** would make the cursor move several words at a time. In vim, these functions are instead relegated to hitting w or e in normal mode to move the cursor at the beginning or end of a word respectively. Hitting the letter b makes the cursor move backwards at the beginning of words. (Give it a try to see it in action if what I described sounds confusing.)

## Opening & Exploring Existing Files

One convenient way to open files is via [NERDTree](https://github.com/scrooloose/nerdtree), which you can toggle in this vim setup by hitting **Ctrl + N** or **<F10>**. Scrolling down and hitting enter on nodes expands the nodes and changes the present working directory (PWD) in Vim (also called the present working directory or CWD in some plugins). A command to see the PWD at any time in Ex/command mode is `:pwd`.

The best way to open files is to conveniently use Ctrl+O (implemented by the [ControlP plugin](https://github.com/ctrlpvim/ctrlp.vim)) to see files in the present working directory or enter the `:MRU` command into Ex/command mode (which stands for [Most Recently Used](https://github.com/yegappan/mru)) to see most recently opened files (which also show on the Startify start screen).


## Editing Markdown Files

When editing a file, to turn on a **distraction-free** mode, use: 

```
,df
```

This will turn on the plugin Goyo (`:GoYo`), which will make a lightbox out of the buffer and hide all the other windows and distracting elements in vim.


**Previewing**: The easiest way to 'preview' markdown code is using the [Vim-Pandoc plugin](https://github.com/vim-pandoc/vim-pandoc). The program [Pandoc](https://pandoc.org/) is a command that can be used to quickly convert files between formats via the command-line -- got to [Pandoc: Installing](https://pandoc.org/installing.html) to install Pandoc so that the plugin works (the install script also installs this by default). The plugin maps these command-line functions to Vim commands, and you can invoke pandoc.

To use Pandoc to preview Markdown files, you can turn the Markdown file into a PDF by using Pandoc to quickly create the PDF in the same directory using: `:Pandoc! pdf`. This has conveniently been mapped to the following command:

```
,pdf
```

Similarly, you can also convert the current buffer's markdown file into an HTML file that will open in your browser using: `:Pandoc! html`. This is made more convenient with the following command:

```
,htm
```

These are the simplest methods as of this writing. Other markdown plugins require you to have a verbose Ruby setup, or several properly-configured npm packages, or browser plugins for Markdown previewing to work. There are also not that many good open source markdown editors out there. Vim, using these keys, makes for a wonderful Markdown editor.


## Themes & Colorschemes

**Changing Colorschemes**: Several attractive and popular colorschemes are installed by default to give you options on colorschemes. To see which ones are available, hit <ESC> to enter EX mode and enter:

````
:colorscheme 
````

After this, hit the <spacebar> to insert 1 single space, then hit <tab>. A list of available colorschemes should then show up. You can arrow-over to an interesting colorscheme and hit enter to choose it.

There is a plugin that allows you to install many colorschemes at once and flip between them. To discover many new themes you'd like to use, install [vim-colorschemes](https://github.com/flazz/vim-colorschemes) and change the colorscheme as above to discover new colorschemes. It's best to then uninstall it because the number of colorschemes loaded by the plugin can slow vim and degrade its performance.

**Changing Fonts**: To change the default font, hit <ESC> to enter Ex mode. Then enter the following:

```
:set guifont=*
```

This won't work in vim within a terminal session for many terminal emulators and instead the terminal's font will be used. The fonts used by VimSetup are special fonts called 'patched fonts' provided by Nerd Font which works with a plugin called [vim-devicons](https://github.com/ryanoasis/vim-devicons).

**Changing Themes**: The [Thematic plugin](https://github.com/reedes/vim-thematic) allows you to change both the colorscheme and font at the same time, along with a host of other options. This is defined by an array variable called `g:thematic#themes` which loads all the particular settings for a colorscheme, font, and other UI-based settings into one 'theme'. Themes can be changed by the Ex command `:ThematicNext` and `:ThematicPrevious` to cycle through the themes. These have been conveniently mapped respectively to:

Next Theme (thn for [Th]ematic [N]ext):

```
,thn
```

Previous Theme (thp for [Th]ematic [P]revious):

```
,thp
```

To select a randomly-picked theme, hit (thr for [Th]ematic [R]andom):

```
,thr
```

The commands `,9` and `,0` narrow and widen the screen respectively (- = narrow and + = widen, and 9 and 0 are next to - and + on the qwerty keyboard).

When would you want to use themes practically? Well, some work that you're doing may require a light theme to make it easier to visualize the syntax highlighting. In those instances, you can quickly switch to a default light theme by entering (where l=light):

```
,thl
```

To switch to a default dark theme, you would just enter the command (where d=dark):

```
,thd
```

You can always switch to a specific theme that you've added to the runtime.vim file using the following command:

```
:Thematic <my-theme-name>
```


# How to Quit Vim

To quit vim, hit <ESC> to enter Ex mode, then enter:

```
:q
```

If you have unsaved changes in an open buffer, it will prompt you to save them. Therefore, if you know you've made changes, instead of using `:q`, use the following:

```
:wq
```

Intuitively, w stands for write (the equivalent of saving a file), as in 'write this file to the hard drive'. The q tells Vim to quit.
After doing this same operation many times, it can get quite fatiguing, so a convenient way to write-and-quit a file is by hitting `ZZ`, which accomplishes the same thing. (The Z and the shift keys are close together.)

# Settings Explained

## Extended.vim

### Backups, Swap Files, and Undo History File Management

These settings avoid losing your work before it can be committed to a version control system (e.g., git, mercurial, SVN, etc.). You can lose your files due to write failures at the time of saving via `:w`, lose chunks of files due to line operation accidents, or lose work without any recent backups made before a git (or mercurial, SVN) commit due to carelessness.

**Default Settings**: Files can be backed up solely locally by adding a /.backup directory to the directory you're working in with /.backup/undo and /.backup/swap subdirectories. If not present, files will backup to a centralized directory, ~/.vim/temp_dirs/backup/ with undo and swap subdirectories. If that's not present, it will put it all in the same directory as the file being edited. 

Secure Configuration: If you don't desire all your files to be backed up to the common/centralized directory, either delete the ~/.vim/temp_dirs/ directory or create a local ./backup directory. Alternatively, sometimes you may want to turn off these settings. For instance, a secure session may be needed where the files you're working on are sensitive and you need for there to not be any records or artifacts created in that session. Or, you may be working on vim via terminate on a remote system and want to not leave a trace on that system. If so, just set the following settings:

```
:set nobackup
:set nowritebackup
:set noswapfile
```

To toggle these settings for the current buffer, you can also hit:

```
,sec
```

This has an additional consequence of also resetting the `viminfo` file, which stores metadata to all files open in the previous session to `$HOME/.viminfo` (or in Windows `$HOME/_viminfo`) when Vim closes. This is usually okay and has no unintended consequences, but if you would rather save the metadata, consider opening buffers in a secure session in an instance separate from files where you want to save metadata to viminfo.

