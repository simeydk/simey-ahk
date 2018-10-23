/*
	Library for getting info from a specific explorer window (if window handle not specified, the currently active
	window will be used).  Requires AHK_L or similar.  Works with the desktop.  Does not currently work with save
	dialogs and such.


	Explorer_GetSelected(hwnd="")   - paths of target window's selected items
	Explorer_GetAll(hwnd="")        - paths of all items in the target window's folder
	Explorer_GetPath(hwnd="")       - path of target window's folder

	example:
		F1::
			path := Explorer_GetPath()
			all := Explorer_GetAll()
			sel := Explorer_GetSelected()
			MsgBox % path
			MsgBox % all
			MsgBox % sel
		return

	Joshua A. Kinnison
	2011-04-27, 16:12
*/


Explorer_GetPath(hwnd="") {
	if !(window := Explorer_GetWindow(hwnd))
		return ErrorLevel := "ERROR"
	if (window="desktop")
		return A_Desktop
	path := window.LocationURL
	path := RegExReplace(path, "ftp://.*@","ftp://")
	StringReplace, path, path, file:///
	StringReplace, path, path, /, \, All

	; thanks to polyethene
	Loop
		If RegExMatch(path, "i)(?<=%)[\da-f]{1,2}", hex)
			StringReplace, path, path, `%%hex%, % Chr("0x" . hex), All
		Else Break
	return path
}

Explorer_GetAll(hwnd="") {
	return Explorer_Get(hwnd)
}

Explorer_GetSelected(hwnd="") {
	return Explorer_Get(hwnd,true)
}

Explorer_GetWindow(hwnd="") {
	; thanks to jethrow for some pointers here
    WinGet, process, processName, % "ahk_id" hwnd := hwnd? hwnd:WinExist("A")
    WinGetClass class, ahk_id %hwnd%

	if (process!="explorer.exe")
		return
	if (class ~= "(Cabinet|Explore)WClass")
	{
		for window in ComObjCreate("Shell.Application").Windows
			if (window.hwnd==hwnd)
				return window
	}
	else if (class ~= "Progman|WorkerW")
		return "desktop" ; desktop found
}

Explorer_Get(hwnd="",selection=false)
{
	if !(window := Explorer_GetWindow(hwnd))
		return ErrorLevel := "ERROR"
	if (window="desktop")
	{
		ControlGet, hwWindow, HWND,, SysListView321, ahk_class Progman
		if !hwWindow ; #D mode
			ControlGet, hwWindow, HWND,, SysListView321, A
		ControlGet, files, List, % ( selection ? "Selected":"") "Col1",,ahk_id %hwWindow%
		base := SubStr(A_Desktop,0,1)=="\" ? SubStr(A_Desktop,1,-1) : A_Desktop
		Loop, Parse, files, `n, `r
		{
			path := base "\" A_LoopField
			IfExist %path% ; ignore special icons like Computer (at least for now)
				ret .= path "`r`n"
		}
	}
	else
	{
		if selection
			collection := window.document.SelectedItems
		else
			collection := window.document.Folder.Items
		for item in collection
			ret .= item.path "`r`n"
	}
	return Trim(ret,"`r`n")
}





RunWithExplorerPath(ThingToRun, AltPath = "") {
	ThePath := GetExplorerPath(AltPath)
	; MsgBox Run with Explorer path `n %ThingToRun% `n %ThePath% 
	Run %ThingToRun%, %ThePath%
}

GetExplorerPath(AltPath = "") {
	WinGetTitle,activeWinTitle,A
	WinGetClass,activeWinClass,A
	WinExplorerIsActive := (activeWinClass = "CabinetWClass" or activeWinClass = "ExploreWClass") 
	return % (WinExplorerIsActive ? activeWinTitle : AltPath)
}



ExplorerSelectedToClipBoard() {
   		filelist = % Explorer_GetSelected()
		Clipboard = %filelist%
		ToolTip , Copied to Clipboard`n%filelist%
		Sleep 1500 
		ToolTip 
} 


WinExplorerToggleHiddenFiles() {
    RegRead, HiddenFiles_Status, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden 
    If HiddenFiles_Status = 2  
        RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 1 
    Else  
        RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 2 
    WinGetClass, eh_Class,A 
    If (eh_Class = "#32770" OR A_OSVersion = "WIN_VISTA" OR A_OSVersion = "WIN_7") 
        send, {F5} 
    Else 
        PostMessage, 0x111, 28931,,, A 
}


WinExplorerToggleFileExtensions() {
    RegRead, HiddenFiles_Status, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, HideFileExt
    If HiddenFiles_Status = 1 
        RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, HideFileExt, 0
    Else 
        RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, HideFileExt, 1
    WinGetClass, eh_Class,A
    If (eh_Class = "#32770" OR A_OSVersion = "WIN_VISTA" OR A_OSVersion = "WIN_7")
        send, {F5}
    Else 
        PostMessage, 0x111, 28931,,, A
}

; Source: https://www.howtogeek.com/howto/8955/make-backspace-in-windows-7-or-vista-explorer-go-up-like-xp-did/
WinExplorerUpALevel() {
    ControlGet renamestatus,Visible,,Edit1,A
    ControlGetFocus focussed, A
    if(renamestatus!=1&&(focussed=”DirectUIHWND3″||focussed=SysTreeView321))
        SendInput {Alt Down}{Up}{Alt Up}
    else
        Send Backspace
}