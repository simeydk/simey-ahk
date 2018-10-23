#SingleInstance
#Include, %A_ScriptDir%\polyethene\hotstrings.ahk

Loop, Files, %A_ScriptDir%\replace\*.txt
{
	LoadReplacements(A_LoopFileFullPath)
}


::]reload::
reload
return

::]editlist::
run %A_ScriptDir%\replace
return
;msgbox %msg%

::]codefolder::
sendinput %A_ScriptDir%
return

::]ct:: SendInput C:\Temp\

::]temp::
::]tmp::
EnvGet, tmp, TMP
SendInput %tmp%
return



; HELPER FUNCTIONS

LoadReplacements(ReplaceListFile = "replace.txt", leadChar = "]") {
	
	msg := ""

	Loop, read, %ReplaceListFile%
	{		
		Loop, parse, A_LoopReadLine, CSV 
		{
			Field%A_Index% := A_LoopField
		}
		
		if (Field1 <> "" & Field2 <> "") 
		{
			hotstrings(leadChar . Field1 . " ", Field2 . " ")
		}
	}

}
