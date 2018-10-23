TimedMsgBox(MsgBoxOptions := 1, Title := "", Msg :="", Timeout := 5, CallBack := "", CallBackArgs := "OK,timeout") {
	Secs := Timeout
	FmtMsg := StrReplace(Msg, "$s" , Secs)
	; SetTimer, TickSecs, 1000
	MsgBox, 4097, %Title%, %FmtMsg%, %Secs%
	; SetTimer, TickSecs, Off

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

	if(CallBack != "") ; If a Callback function was passed
	{
		if m in %CallBackArgs% ; if the response was in the set of valid responses
		{
			%CallBack%() ; Run the callback function
		}
	}

	return % m
	
	; TickSecs:
	; 	Secs -= 1
	;   	FmtMsg := StrReplace(Text, "$s" , Secs)
	; 	ControlSetText,Static1,FmtMsg,Title ahk_class #32770
	; Return
}