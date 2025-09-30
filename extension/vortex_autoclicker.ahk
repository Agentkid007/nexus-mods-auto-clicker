#NoEnv
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%
#MaxHotkeysPerInterval 100
#InstallKeybdHook
#InstallMouseHook

; -------- Settings --------
clicksPerSecondFast := 10     ; F8 mode (Vortex active only)
clicksPerSecondSlow := 3      ; F9 mode (Vortex active only)
vortexExe := "Vortex.exe"     ; Process name may vary; adjust if needed
; --------------------------

global __autoClick := false
global __timerInterval := 1000 // clicksPerSecondFast
global __mode := "fast"

F8::
__mode := "fast"
__timerInterval := 1000 // clicksPerSecondFast
ToggleAutoClick()
return

F9::
__mode := "slow"
__timerInterval := 1000 // clicksPerSecondSlow
ToggleAutoClick()
return

F10::
StopAutoClick()
return

^`::
Pause
SoundBeep, 800, 100
return

ToggleAutoClick() {
    global __autoClick, __timerInterval, __mode
    if (__autoClick) {
        SetTimer, __DoClick, Off
        __autoClick := false
        TrayTip, Vortex AutoClicker, Stopped (%__mode%), 1000, 1
        SoundBeep, 600, 80
    } else {
        SetTimer, __DoClick, % -1 * __timerInterval
        __autoClick := true
        TrayTip, Vortex AutoClicker, Started (%__mode%) at cursor (Vortex only), 1200, 1
        SoundBeep, 1000, 80
    }
}

StopAutoClick() {
    global __autoClick
    SetTimer, __DoClick, Off
    __autoClick := false
    TrayTip, Vortex AutoClicker, Stopped, 1000, 1
    SoundBeep, 500, 80
}

__DoClick:
    ; Only click when Vortex window is active
    WinGet, pName, ProcessName, A
    if (pName != vortexExe) {
        return
    }
    MouseGetPos, mx, my
    Click, %mx%, %my%
return
