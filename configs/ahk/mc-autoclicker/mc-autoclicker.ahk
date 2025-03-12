#Requires AutoHotkey v2.0

global ClickerMode := false
global IsClicking := false

menu_handler(ItemName, *) {
    switch(ItemName) {
        case "Exit": ExitApp

        case "Reload": Reload

        case "Help":
            MsgBox(
                "F6 to show menu`n" .
                "F7 to toggle clicker",
                "Help"
            )

        case "Edit":
            Run(
                "C:\Users\nuhddy\AppData\Local\Programs\VSCodium\VSCodium.exe " .
                A_ScriptFullPath
            )

        default:
            if ClickerMode {
                tray.Uncheck(ClickerMode[1])
            }
            switch ItemName {
                case "Bedrock Breaker":
                    global ClickerMode := [ItemName, "Right", 1]

                case "Raid Farm":
                    global ClickerMode := [ItemName, "Left", 1500]

                case "Sweeping Edge":
                    global ClickerMode := [ItemName, "Left", 600]
                    ; 510 ~ 84.8% (sweeping edge cooldown)
                    ; 600 = 100% (full damage recovery)

                default: return
            }
            tray.Check(ItemName)
    }
}

TraySetIcon(A_WorkingDir . "\icon.ico", 1, 1)
A_IconTip := "Minecraft Autoclicker"
tray := A_TrayMenu
tray.Delete
tray.Add("Help", menu_handler)
tray.Add
tray.Add("Bedrock Breaker", menu_handler, "Radio")
tray.Add("Raid Farm", menu_handler, "Radio")
tray.Add("Sweeping Edge", menu_handler, "Radio")
tray.Add
tray.Add("Edit", menu_handler)
tray.Add("Reload", menu_handler)
tray.Add("Exit", menu_handler)

clicker_loop() {
    Click(ClickerMode[2])
}

F6::tray.Show

F7:: {
    if not ClickerMode {
        return
    }

    if not IsClicking {
        SetTimer(clicker_loop, ClickerMode[3])
    } else {
        SetTimer(clicker_loop, 0)
    }
    global IsClicking := not IsClicking
}

; F7:: {
;     switch(ClickerMode) {
;         case "Bedrock Breaker":
;             Loop {
;                 Click "Right"
;                 Sleep 1
;             }
;         case "Raid Farm":
;             Loop {
;                 Click
;                 Sleep 1500
;             }
;         case "Sweeping Edge":
;             Loop {
;                 Click
;                 Sleep 600
;                 ; 510 ~ 84.8% (sweeping edge cooldown)
;                 ; 600 = 100% (full damage recovery)
;             }
;         default: return
;     }
; }

; F8::Pause -1

; F9::Reload