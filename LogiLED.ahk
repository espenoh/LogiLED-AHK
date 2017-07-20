; LogiLED.ahk
; Show Caps/Num/Scroll-lock status on the key using the Logitech LED SDK
;
; Written by: Espen Helgedagsrud
; Initial version: 1.0 - 20. Jul 2017
; Current version: 1.0 - 20. Jul 2017

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; --- USER SETTINGS, feel free to tweak ---
LIGHT_INITIAL  := 0   ; Initial intensity of all keys (0-100)
LIGHT_ENABLED  := 100 ; Intensity of enabled and..
LIGHT_DISABLED := 0   ; .. disabled key

; CONSTANTS
LOGI_KEY_CAPS   := 0x3A
LOGI_KEY_NUM    := 0x45
LOGI_KEY_SCROLL := 0x46
LOGI_KEY_G_LOGO := 0xFFFF1

hModule := DllCall("LoadLibrary", "Str", "LogitechLedEnginesWrapper.dll", "Ptr")  ; Load DLL into memory

if not DllCall("LogitechLedEnginesWrapper\LogiLedInit") {
	MsgBox, Could not initialize Logitech DLL, exiting!
	Exit
}
Sleep, 100 ; Logitech documentation claims it need some time to warm up, can probably be lowered

DllCall("LogitechLedEnginesWrapper\LogiLedSaveCurrentLighting") ; Save current settings
DllCall("LogitechLedEnginesWrapper\LogiLedSetLighting", "Int", LIGHT_INITIAL, "Int", 0, "Int", 0) ; Set base light to all keys

; If you want to set custom color values for other keys just copy the line under and change the params
DllCall("LogitechLedEnginesWrapper\LogiLedSetLightingForKeyWithKeyName", "Int", LOGI_KEY_G_LOGO, "Int", 100, "Int", 0, "Int", 0) ; This sets the G-logo (top left) to max intensity

val_caps   := 0
val_num    := 0
val_scroll := 0

Loop {
	val_caps_new := GetKeyState("CapsLock", "T") ? LIGHT_ENABLED : LIGHT_DISABLED
	if (val_caps_new != val_caps) {
		val_caps := val_caps_new
		DllCall("LogitechLedEnginesWrapper\LogiLedSetLightingForKeyWithKeyName", "Int", LOGI_KEY_CAPS, "Int", val_caps, "Int", 0, "Int", 0)	
	}
	
	val_num_new := GetKeyState("NumLock", "T") ? LIGHT_ENABLED : LIGHT_DISABLED
	if (val_num_new != val_num) {
		val_num := val_num_new
		DllCall("LogitechLedEnginesWrapper\LogiLedSetLightingForKeyWithKeyName", "Int", LOGI_KEY_NUM, "Int", val_num, "Int", 0, "Int", 0)	
	}
	
	val_scroll_new := GetKeyState("ScrollLock", "T") ? LIGHT_ENABLED : LIGHT_DISABLED
	if (val_scroll_new != val_scroll) {
		val_scroll := val_scroll_new
		DllCall("LogitechLedEnginesWrapper\LogiLedSetLightingForKeyWithKeyName", "Int", LOGI_KEY_SCROLL, "Int", val_scroll, "Int", 0, "Int", 0)	
	}
	
	Sleep, 100
}