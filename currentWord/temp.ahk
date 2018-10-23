CurrentWord := ""
i := 0
i++

#y::incrementAndMsg()

incrementAndMsg() {
    i++
    CurrentWord .= "a"
    MsgBox, %i% %CurrentWord%
}