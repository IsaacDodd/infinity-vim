
* This program launches vim within Stata.
program vim 
	version 8 
	* discard 
	winexec xterm -e vim `*'
end
