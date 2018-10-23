::]d::
::]dt::
::]dx::
::]dtx::
::]dl::
::]dtl::
::]dtlx::
::]dtxl::
	IncludeTime := instr(A_ThisHotkey, "t")
	NoSymbols := instr(A_ThisHotkey, "x")
	LongDate := instr(A_ThisHotkey, "l")

	format := DateTimeFormat(IncludeTime, LongDate, NoSymbols)	
	FmtTime := FormatTime(,format)

	SendInput %FmtTime%

return

DateTimeFormat(IncludeTime := true, LongDate := false, NoSymbols := false) {
	format := ""
	
	if (Longdate) 
		DateFormat := "d MMMM yyyy"
	else if (noSymbols) 
		DateFormat := "yyyyMMdd"
	else 
		DateFormat := "yyyy-MM-dd"
	
	if (includeTime){
		if(noSymbols)
			TimeFormat := " " . "HHmm"
		else if(Longdate)
			TimeFormat := " " . "HH:mm"
		else
			TimeFormat := " " . "HH'h'mm"
	}

	format := DateFormat . TimeFormat
	return format
}

FormatTime(time := "", Format := "yyyy-MM-dd HH:mm") {
	FormatTime, FmtTime, %time%, %format%
	return FmtTime
}

