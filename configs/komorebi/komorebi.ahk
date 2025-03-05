#Requires AutoHotkey v2.0
#SingleInstance Force
#Include Util.lib.ahk

; KEYBINDS
#h::Komorebic("focus left")
#j::Komorebic("cycle-focus next")
#k::Komorebic("cycle-focus previous")
#l::Komorebic("focus right")

#+h::Komorebic("move left")
#+j::Komorebic("move down")
#+k::Komorebic("move up")
#+l::Komorebic("move right")

#Tab::Komorebic("toggle-monocle")
#s::Komorebic("toggle-float")
#m::Komorebic("minimize")
#+q::Komorebic("close")
#Backspace::Komorebic("toggle-pause")

#Left::Komorebic("resize-axis horizontal decrease")
#Right::Komorebic("resize-axis horizontal increase")
#Up::Komorebic("resize-axis vertical increase")
#Down::Komorebic("resize-axis vertical decrease")

#1::Komorebic("focus-workspace 0")
#2::Komorebic("focus-workspace 1")
#3::Komorebic("focus-workspace 2")
#4::Komorebic("focus-workspace 3")
#5::Komorebic("focus-workspace 4")

#+1::Komorebic("move-to-workspace 0")
#+2::Komorebic("move-to-workspace 1")
#+3::Komorebic("move-to-workspace 2")
#+4::Komorebic("move-to-workspace 3")
#+5::Komorebic("move-to-workspace 4")

#^+l::CustomLockWorkstation()
#^+r::ReloadKomorebi()
#^+e::ExitKomorebi()

#Enter::Run("shell:appsFolder\Microsoft.WindowsTerminal_8wekyb3d8bbwe!App")
#Space::Send("!{Space}") ; Flow Launcher
#i::Run("C:\Program Files\AutoHotkey\UX\WindowSpy.ahk")
; EQ presets
#[::Send("^![")
#]::Send("^!]")
; Media controls
#Del::Send("{Media_Prev}")
#End::Send("{Media_Play_Pause}")
#PgDn::Send("{Media_Next}")

; CONDITIONAL KEYBINDS
#HotIf WinActive("ahk_exe ACU.exe")
LAlt::e     ; extra descend
c::LControl ; extra crouch

#HotIf WinActive("ahk_exe ACS.exe")
LAlt::e ; extra descend

#HotIf

; TRAY MENU
A_IconTip := "Komorebi"
A_TrayMenu.Delete()
A_TrayMenu.Add("Reload", ReloadKomorebi)
A_TrayMenu.Add("Exit", ExitKomorebi)