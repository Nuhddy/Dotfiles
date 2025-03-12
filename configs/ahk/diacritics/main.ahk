#SingleInstance Force

#Include util.ahk


; Toggle hotkey suspension
+>!s::
Suspend, Permit
suspend_handler()
Return


; 2-STEP HOTKEYS
#UseHook On

; 1st hotkey
>!a::   ; acute
>!d::   ; diaeresis
Return

; Character handler
f(regular, acute, diaeresis) {
    phk := A_PriorHotKey

    if (phk = ">!a" && is_active()) {
        str := acute
    } else if (phk = ">!d" && is_active()) {
        str := diaeresis
    } else {
        str := regular
    }

    SendInput % str
}

; Hotkey timeout (ms)
is_active() {
    if (A_TimeSincePriorHotkey < 2000) {
        return True
    } else {
        return False
    }
}

; 2nd hotkey
Space::f(" ", "´", "¨")
a::f("a", "á", "ä")
e::f("e", "é", "ë")
i::f("i", "í", "ï")
o::f("o", "ó", "ö")
u::f("u", "ú", "ü")
y::f("y", "ý", "ÿ")
+A::f("A", "Á", "Ä")
+E::f("E", "É", "Ë")
+I::f("I", "Í", "Ï")
+O::f("O", "Ó", "Ö")
+U::f("U", "Ú", "Ü")
+Y::f("Y", "Ý", "Ÿ")

#UseHook Off


; ONE-SHOT HOTKEYS
>!VKBA::SendInput æ
>!VKDE::SendInput ø
>!VKDB::SendInput å
+>!VKBA::SendInput Æ
+>!VKDE::SendInput Ø
+>!VKDB::SendInput Å

>!n::SendInput ñ
+>!N::SendInput Ñ

>!m::SendInput μ
