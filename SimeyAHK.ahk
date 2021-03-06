;  #  Win  ||  !  Alt  ||  ^  Control  ||  +  Shift

#SingleInstance

; load many replace hotstrings
#Include replace.ahk
; experimental fun stuff.
#Include simeyplay.ahk

; change script folder to helpers subfolder
#Include %A_ScriptDir%\helpers

#Include datetime.ahk 
; replace ]dt with date and time, etc

; #Include InternetExplorer.ahk only ; referenced in OpenChrome
#Include OpenChrome.ahk
; OpenChrome

#Include LockSleepHibernateShutdown.ahk
; Lock
; Sleep
; Hibernate
; Shutdown

#Include TimedMsgBox.ahk
; TimedMsgBox

#Include ToggleInternetProxyAutoConfig.ahk
; ToggleInternetProxyAutoConfig

#Include WinExplorer.ahk
; ExplorerSelectedToClipBoard
; WinExplorerToggleFileExtensions
; WinExplorerToggleHiddenFiles
; WinExplorerUpALevel
; RunWithExplorerPath


; Notify when this script loads
TrayTip, Autohotkey, Successfully loaded`n%A_ScriptName%, 1


code := "C:\Users\om90898.OMCORE\AppData\Local\Programs\Microsoft VS Code\Code.exe"
hyper := "C:\Users\om90898.OMCORE\AppData\Local\hyper\Hyper.exe"
whatsapp := "C:\Users\om90898.OMCORE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Chrome Apps\WhatsApp.lnk"


^+#F2:: Run, C:\Program Files\Microsoft VS Code\Code.exe "%A_ScriptDir%"

^+#F5:: ; CTRL+SHIFT+WIN+F5 - Reload this script
	TrayTip, Autohotkey, Reloading`n%A_ScriptName%, 1
	reload
return


#l:: LockAndMonOff() ; Override Win+L to lock monitor and also turn off screen
#+h:: TimedMsgBox(, "Hibernate", "Hibernate in $s seconds?",3, "Hibernate") ; Hibernate after 3 seconds
#+s:: TimedMsgBox(, "Sleep", "Sleep in $s seconds", 3, "Sleep") ; Sleep after 3 seconds

#x:: Run, %windir%\system32\SnippingTool.exe

#w:: OpenChrome() ; Run % "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" . " " . IE_GetUrl() ; Open Chrome, and open at
#+w:: Run % "C:\Users\om90898.OMCORE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Chrome Apps\WhatsApp.lnk"

^#n:: Run, notepad.exe

#numlock:: Run, calc

#+c:: RunWithExplorerPath("C:\Users\om90898.OMCORE\AppData\Local\Programs\Microsoft VS Code\Code.exe")

#c::
#`:: RunWithExplorerPath(ComSpec)

^#+c:: ; same as below
#+`::RunWithExplorerPath("C:\Users\om90898.OMCORE\AppData\Local\hyper\Hyper.exe")

; #Include ToggleInternetProxyAutoConfig.ahk
#+p:: ToggleInternetProxyAutoConfig()

; ###############  Windows Explorer Only
#IFWINACTIVE ahk_exe Explorer.EXE

	^+c:: ExplorerSelectedToClipBoard()
	^+h:: WinExplorerToggleHiddenFiles()
	^+y:: WinExplorerToggleFileExtensions()	
	; backspace::WinExplorerUpALevel()

#IFWINACTIVE

; ###############  Command Prompt Only
#IFWINACTIVE ahk_class ConsoleWindowClass

	^v:: SendInput {Raw}%clipboard%

#IFWINACTIVE




