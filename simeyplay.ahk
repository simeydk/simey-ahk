^#space:: ;SendRaw % " "  
	ToolTip , CTRL WIN SPACE pressed.
	Sleep 1500
	ToolTip
return

#+e:: MsgBox % GetExplorerPath("No Path")

~Ctrl::
	;400 is the maximum allowed delay (in milliseconds) between presses.
	if (A_PriorHotKey = "~Ctrl" AND A_TimeSincePriorHotkey < 400 AND  A_TimeSincePriorHotkey > 60)
	{
	;Put code to be executed here.
		ToolTip , CTRL pressed twice.
		Sleep 400
		ToolTip
	;TrayTip AHK, Double press detected. %A_ThisHotkey% & %A_PriorHotKey% & %A_TimeSincePriorHotkey%
	}
	Sleep 0
	;KeyWait Ctrl
return

#F1:: 
	ans := TimedMsgBox()
	MsgBox % ans
return


boom() {
	MsgBox Boom
}
	
#F2::
	Secs := 3
	Title := System Shutdown
	MsgBoxOptions := 1 + 4096
	SetTimer, CountDown, 1000
	MsgBox, 4097, System Shutdown, Allow Auto Shutdown in %Secs%?, %Secs%
	SetTimer, CountDown, Off

	m := ""

	IfMsgBox, Yes
		m := m . "Yes"
	IfMsgBox, No
		m := m . "No"
	IfMsgBox, OK
		m := m . "OK"
	IfMsgBox, Cancel
		m := m . "Cancel"
	IfMsgBox, Abort
		m := m . "Abort"
	IfMsgBox, Ignore
		m := m . "Ignore"
	IfMsgBox, Retry
		m := m . "Retry"
	IfMsgBox, Timeout
		m := m . "Timeout"

	MsgBox % m
	
	CountDown:
		Secs -= 1
		ControlSetText,Static1,Allow Auto Shutdown in %Secs%?,System Shutdown ahk_class #32770
	Return

Return

#q:: 
	x := GetExplorerPath("default")
    y := "C:\Simey\Documents\SQL Server Management Studio"  
	MsgBox % code
	; Run  %ComSpec%, %y%
return

#IfWinActive, ahk_exe notepad.exe
	#a::
		SendInput, ^Left
		SendInput, ^+Right
	return
#IfWinActive



#Launch_App2:: MsgBox WinCalc

+Browser_Home:: run "https://ebs-prod.om.oldmutual.com/OA_HTML/AppsLogin"


; Media_Play_Pause	; Play
; Volume_Mute    	; Mute Button
; Volume_Down    	; Volume Down
; Volume_Up      	; Volume Up
; Browser_Home   	; Browser (home icon)
; Launch_Mail    	; Mail
; Launch_App2       ; Calc Button


; #F3:: FileMove, C:\windows\system32\oobe\info\backgrounds\*.png, C:\windows\system32\oobe\info\backgrounds\*_jpg.old, 1