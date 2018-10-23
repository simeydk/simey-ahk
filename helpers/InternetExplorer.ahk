/*
	INTERNET EXPLORER
*/

; Return the URL of the active tab of Internet Explorer, if open. Otherwise return AltText
IE_GetUrl(AltText := "") {
	x := AltText
	#IfWinActive, ahk_exe iexplore.exe
		ControlGetText, x, Edit1, A
	#IfWinActive
	return x
}