#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.uytu
#SingleInstance Force ; Allow only one running instance of script.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

TrayTip, Autohotkey, Successfully loaded`n%A_ScriptName%, 1

^+#F2::
	TrayTip, Autohotkey, Reloading`n%A_ScriptName%, 1	
	reload
return

DoLog = 1
ShowTip = 1

currWord := ""
CurrSentence := ""

;MsgBox, 4, MessageBox, Begin?
;IfMsgBox Yes
   GoSub, LogCode
;return

LogCode:
   
   Loop,
   {
		if (DoLog){
		  
		  Input, Var, L1 V
		  Transform, VarAscii, Asc, %Var%
		  FileAppend, %Var%, Log.txt
		  
		  varIsAlnum = 0
		  if Var is alnum
			varIsAlnum = 1
		  
		  if (VarAscii = 27) {
			currWord := SubStr(currWord,1,-1)
		  }
		  else {
			if (Var is alnum) {
				currWord .= Var
				Traytip Logger, Alnum CurrWord = [%Currword%]`nVar = %Var%
			}
			else {
				prevWord := currWord
				currWord := ""
				TrayTip Logger, !Alnum CurrWord = [%Currword%]`nVar = %Var%
			}
		  }
				  
		  
		  
		  
		  if (ShowTip)
		  
			
			TrayTip Logger, %Var% [%VarAscii%] [%varIsAlnum%]`nword: %CurrWord%, 1
		}
   }
return



^+#F6:: 
	msg = 
	;msg .= "A_ThisHotkey: " . A_ThisHotkey . "`n" 
	;msg .= "A_PriorHotkey: " . A_PriorHotkey . "`n"
	;msg .= "A_TimeSincePriorHotkey: " . A_TimeSincePriorHotkey . "`n" 
	;msg .= "(A_ThisHotkey = A_PriorHotkey): " . (A_ThisHotkey = A_PriorHotkey) . "`n" 
	;msg .= "(A_TimeSincePriorHotkey < 2000): " . (A_TimeSincePriorHotkey < 4000) . "`n" 
	;msg .= "((A_ThisHotkey = A_PriorHotkey)  &  (A_TimeSincePriorHotkey < 4000)): " . ((A_ThisHotkey = A_PriorHotkey)  &  (A_TimeSincePriorHotkey < 4000)) . "`n" 
	
	if ((A_ThisHotkey = A_PriorHotkey)  &  (A_TimeSincePriorHotkey < 4000)) {
		DoLog := !DoLog OR ShowTip
		ShowTip := !ShowTip AND DoLog
	}
	msg .= "DoLog: " . DoLog . "`n"
	msg .= "ShowTip: " . ShowTip . "`n"
	TrayTip Logger, %msg%, 1

Return
