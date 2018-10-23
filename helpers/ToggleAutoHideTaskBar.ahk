ToggleAutoHideTaskBar() {

	VarSetCapacity( APPBARDATA, 36, 0 )
	NumPut(36, APPBARDATA, 0, "UInt") ; First field is the size of the struct
	bits := DllCall("Shell32.dll\SHAppBarMessage"
		,"UInt", 4 ; ABM_GETSTATE
		,"UInt", &APPBARDATA )
	NumPut( (bits ^ 0x1), APPBARDATA, 32, "UInt" ) ; Toggle Autohide
	DllCall("Shell32.dll\SHAppBarMessage"
		,"UInt", ( ABM_SETSTATE := 0xA )
		,"UInt", &APPBARDATA )

}