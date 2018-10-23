; Source: https://gist.github.com/davejamesmiller/1965854
LockAndMonOff() {
    Run rundll32.exe user32.dll`,LockWorkStation     ; Lock PC
    Sleep 100
    SendMessage 0x112, 0xF170, 2, , Program Manager  ; Monitor off
}

;  Source (for Hibernate, Suspend and Sleep): https://autohotkey.com/boards/viewtopic.php?t=1150
Hibernate() {
    DllCall("PowrProf\SetSuspendState", "int", 1, "int", 1, "int", 1)
}

Sleep() {
    DllCall("PowrProf\SetSuspendState", "int", 0, "int", 1, "int", 1)
}

Shutdown() {
    Shutdown, 5
}    
