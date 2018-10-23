GetSelectedText() {

	tmp = %ClipboardAll% ; save clipboard in temp variable
	Clipboard := "" ; clear clipboard
	Send, ^c ; simulate Ctrl+C (=selection in clipboard)
	ClipWait, 1 ; wait until clipboard contains data
	selection = %Clipboard% ; save the content of the clipboard
	Clipboard = %tmp% ; restore old content of the clipboard
	return (selection = "" ? Clipboard : selection)

}