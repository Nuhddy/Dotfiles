#Requires AutoHotkey v2.0

Komorebic(cmd) {
    RunWait(Format("komorebic.exe {}", cmd), , "Hide")
}

ExitKomorebi(*) {
    Komorebic("stop --bar")
    ExitApp()
}

ReloadKomorebi(*) {
    Reload()
}

CustomLockWorkstation() {
    if !A_IsAdmin
        return

    delay_ms := 100
    __DisableLockWorkstation(0)
    Sleep(delay_ms)
    DllCall("LockWorkStation")
    Sleep(delay_ms)
    __DisableLockWorkstation(1)
}

__DisableLockWorkstation(toggle) {
    RegWrite(toggle, "REG_DWORD", "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System", "DisableLockWorkstation")
}