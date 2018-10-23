#Include InternetExplorer.ahk
; IE_GetUrl

OpenChrome() {
    IE_URL := IE_GetUrl() ; Gets Internet Explorer's current URL
    If (IE_URL != "") { ; If IE is open (if you got a url)
        Send, ^w ; send CTRL+W to close the explorer tab
    }
    ; Open chrome, and open it at the URL from IE, if there was one
    Run % "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" . " " . IE_URL
}
