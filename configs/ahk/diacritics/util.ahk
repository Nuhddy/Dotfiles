update_menus() {
    if (A_IsSuspended) {
        icon := "suspended_16.ico"
        tip := "Off"
    } else {
        icon := "default_16.ico"
        tip := "On"
    }

    Menu, Tray, Icon, %A_WorkingDir%\res\%icon%,,1
    Menu, Tray, Tip, Diacritics %tip%
}

suspend_handler() {
    Menu, Tray, ToggleCheck, &Suspend
    if (A_IsSuspended) {
        Suspend, Off
        update_menus()
    } else {
        Suspend, On
        update_menus()
    }
}

exit_handler() {
    ExitApp
}

Menu, Tray, NoStandard
Menu, Tray, Add, &Suspend, suspend_handler
Menu, Tray, Add, &Exit, exit_handler
Menu, Tray, Default, &Suspend
update_menus()
