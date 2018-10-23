ToggleInternetProxyAutoConfig() {
	omURL := "http://FWDProxy.za.omlac.net/accelerated_pac_base.pac"
	currURL := GetInternetProxyAutoConfig()
	currURLFmt := LabelBlank(currURL)
	SuggestedURL := (currURL != "") ? currURL : omURL
	Title := "Enter Proxy AutoConfig URL"
	Prompt = Current URL is `n%currURLFmt%`n`nPlease enter new URL.
	InputBox, newURL , %Title%, %Prompt%, , , , , , , , %SuggestedURL%
	If (ErrorLevel = 0) {
		SetInternetProxyAutoConfig(newURL)
		finalURL := GetInternetProxyAutoConfig()
		if (finalURL = newURL) {	
			finalURLFmt := LabelBlank(finalURL)
			MsgBox, , Proxy AutoConfig URL, The new URL is`n%finalURLFmt%, 5
		} else {
			MsgBox, , Error, Unable to change URL to `n%newURL%`n`nThe URL is still `n%finalURL%.
		}
	} else {
		; User pressed escape
	}
}

SetInternetProxyAutoConfig(URL) {
	RegWrite, REG_SZ, HKCU, Software\Microsoft\Windows\CurrentVersion\Internet Settings, AutoConfigURL, %URL%
	return GetInternetProxyAutoConfig()
}

GetInternetProxyAutoConfig() {
	RegRead, URL, HKCU, Software\Microsoft\Windows\CurrentVersion\Internet Settings, AutoConfigURL
	return % URL
}

LabelBlank(a) {
	return ((a = "") ? "[BLANK]" : a)
}