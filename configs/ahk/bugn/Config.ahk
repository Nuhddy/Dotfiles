/*
  bug.n -- tiling window management
  Copyright (c) 2010-2019 Joshua Fuhs, joten

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  GNU General Public License for more details.

  @license GNU General Public License version 3
           ../LICENSE.md or <http://www.gnu.org/licenses/>

  @version 9.0.2
*/

; KEYBINDS
#j::View_activateWindow(0, +1)
#k::View_activateWindow(0, -1)

#+j::View_shuffleWindow(0, +1)
#+k::View_shuffleWindow(0, -1)
#+q::Manager_closeWindow()
#+d::Window_toggleDecor()
#s::View_toggleFloatingWindow()
#m::Manager_minimizeWindow()
#f::Manager_maximizeWindow()

#Tab::View_setLayout(0, +1)
#h::View_setLayoutProperty("MFactor", 0, -0.025)
#l::View_setLayoutProperty("MFactor", 0, +0.025)

#1::Monitor_activateView(1)
#2::Monitor_activateView(2)
#3::Monitor_activateView(3)
#4::Monitor_activateView(4)
#5::Monitor_activateView(5)

#+1::Monitor_setWindowTag(1)
#+2::Monitor_setWindowTag(2)
#+3::Monitor_setWindowTag(3)
#+4::Monitor_setWindowTag(4)
#+5::Monitor_setWindowTag(5)

#^1::Monitor_toggleWindowTag(1)
#^2::Monitor_toggleWindowTag(2)
#^3::Monitor_toggleWindowTag(3)
#^4::Monitor_toggleWindowTag(4)
#^5::Monitor_toggleWindowTag(5)

#!Space::Monitor_toggleBar()
#+Space::Monitor_toggleTaskBar()

#^+r::Reload
#^+e::ExitApp
#^+l::Manager_lockWorkStation()

#Del::Send {Media_Prev}
#End::Send {Media_Play_Pause}
#PgDn::Send {Media_Next}

#Enter::Run, shell:appsFolder\Microsoft.WindowsTerminal_8wekyb3d8bbwe!App
#Space::Send, !{Space} ; Flow Launcher
#i::Manager_getWindowInfo()
#+i::Manager_getWindowList()
; ~LWin::Send {Blind}{vkE8}  ; prevent winkey opening start menu (causes sticky winkey bug)

; CONDITIONAL KEYBINDS
#IfWinActive ahk_exe ACU.exe
LAlt::e     ; extra descend
c::LControl ; extra crouch

#IfWinActive ahk_exe ACS.exe
LAlt::e ; extra descend

#IfWinActive

; CONFIG
Config_init() {
  Local i, key, layout0, layout1, layout2, vNames0, vNames1, vNames2, vNames3, vNames4, vNames5, vNames6, vNames7, vNames8, vNames9

  ;; Status bar
  Config_showBar           := True
  Config_horizontalBarPos  := 40
  Config_verticalBarPos    := "tray"
  Config_barWidth          := 300
  Config_singleRowBar      := True
  Config_spaciousBar       := True
  Config_fontName          := "Lato Semibold"
  Config_fontSize          := 10
  Config_largeFontSize     := 24
  Loop, 3 {
    Config_backColor_#%A_Index% := "Black;Black;Black;Black;Black;Black;Black;Black;Black"
    Config_foreColor_#%A_Index% := "Black;Black;Black;Black;Black;Black;Black;Black;Black"
  }
  Config_fontColor_#1      := "6c7086;cdd6f4;;;;;;;"
  Config_fontColor_#2      := "cdd6f4;;;;;;;;"
  Config_fontColor_#3      := ";;;;;;;;"
  Config_barTransparency   := "off"
  Config_barCommands       := "Run, C:\Users\nuhddy\AppData\Local\Programs\VSCodium\VSCodium.exe " A_ScriptDir "\Config.ahk;Run, explore " A_ScriptDir ";Reload;ExitApp"
  Config_readinBat         := False
  Config_readinCpu         := False
  Config_readinDate        := False
  Config_readinDateFormat  := "ddd, dd. MMM. yyyy"
  Config_readinDiskLoad    := False
  Config_readinMemoryUsage := False
  Config_readinNetworkLoad := False
  Config_readinTime        := False
  Config_readinTimeFormat  := "HH:mm"
  Config_readinVolume      := False
  Config_readinInterval    := 30000

  ;; Windows ui elements
  Config_bbCompatibility := False
  Config_borderWidth     := 0
  Config_borderPadding   := -1
  Config_showTaskBar     := True
  Config_showBorder      := False
  Config_selBorderColor  := ""
  Config_scalingFactor   := 1   ;; Undocumented. The value is retrieved by `Config_getSystemSettings()` from the registry.
                                ;; It should not be set manually by the user,
                                ;; but is dependant on the setting in the `Display control panel` of Windows under `Appearance and Personalization`.

  ;; Window arrangement
  Config_viewNames          := "1;2;3;4;5"
  Config_layout_#1          := "[M];monocle"
  Config_layout_#2          := "[]=;tile"
  Config_layoutCount        := 2
  Config_layoutAxis_#1      := 1
  Config_layoutAxis_#2      := 2
  Config_layoutAxis_#3      := 2
  Config_layoutGapWidth     := 12
  Config_layoutMFactor      := 0.5
  Config_areaTraceTimeout   := 1000
  Config_continuouslyTraceAreas := False
  Config_dynamicTiling      := True
  Config_ghostWndSubString  := " (Not Responding)"
  Config_mFactCallInterval  := 700
  Config_mouseFollowsFocus  := False
  Config_newWndPosition     := "bottom"
  Config_onActiveHiddenWnds := "view"
  Config_shellMsgDelay      := 0
  Config_syncMonitorViews   := 0
  Config_viewFollowsTagged  := False
  Config_viewMargins        := "0;0;0;0"

  ;; <class>;<title>;<func>;<manage>;<mon>;<tags>;<float>;<decorate>;<hide title>;<action>"

  Config_ruleCount := 0  ;; This variable has to be set to the total number of active rules above.

  ; Default rules
  Config_ruleDefault := [".*;.*;;1;0;0;0;0;0;"
  , ".*;.*;Window_isChild;0;0;0;1;1;1;"
  , ".*;.*;Window_isPopup;0;0;0;1;1;1;"]
  ; , "QWidget;.*;;1;0;0;0;0;0;"
  ; , "SWT_Window0;.*;;1;0;0;0;0;0;"
  ; , "Xming;.*;;1;0;0;0;0;0;"
  ; , "MsiDialog(No)?CloseClass;.*;;1;0;0;1;1;0;"
  ; , "AdobeFlashPlayerInstaller;.*;;1;0;0;1;0;0;"
  ; , "CalcFrame;.*;;1;0;0;1;1;0;"
  ; , "OperationStatusWindow;.*;;0;0;0;1;1;0;"
  ; , "Chrome_WidgetWin_1;.*;;1;0;0;0;1;0;"
  ; , "Chrome_WidgetWin_1;.*;Window_isPopup;0;0;0;1;1;0;"
  ; , "Chrome_RenderWidgetHostHWND;.*;;0;0;0;1;1;0;"
  ; , "IEFrame;.*Internet Explorer;;1;0;0;0;1;0;"
  ; , "MozillaWindowClass;.*Mozilla Firefox;;1;0;0;0;1;0;"
  ; , "MozillaDialogClass;.*;;1;0;0;1;1;0;"
  ; , "ApplicationFrameWindow;.*Edge;;1;0;0;0;1;0;"]

  ; Manage windows
  Config_ruleManage := [";;1;0;0;0;0;0;"
  , ["ApplicationFrameWindow;Settings"
  , "ApplicationFrameWindow;Calculator"
  , "ApplicationFrameWindow;Windows Security"
  , "ApplicationFrameWindow;Microsoft Store"
  , "ApplicationFrameWindow;.*Notepads"
  , "ApplicationFrameWindow;.*Photos"
  , "UnrealWindow;Epic Games Launcher"
  , "Qt5152QWindowIcon;.*Mod Organizer.*"
  , "vcxsrv.*;.*"
  , "Qt5152QWindowIcon;The Witcher 3 Mod Manager"
  , "WindowsForms10\.Window\.8\.app\.0.*;Script Merger.*"
  , "WindowsForms10\.Window\.8\.app\.0.*;Wolven kit.*"
  , "Qt651QWindowIcon;Prism Launcher .*"
  , "Chrome_WidgetWin_1;.*Obsidian.*Obsidian v.*"
  , "Qt642QWindowIcon;calibre.*"
  , "Qt5QWindowIcon;.*KDiff3"]]

  ; Don't manage windows
  Config_ruleUnmanage := [";;0;0;0;0;0;0;"
  , ["NarratorHelperWindow;.*"
  , "MsiDialog.*;"
  , "Creation Kit SE;.*"
  , "#32770;Object Window"
  , "#32770;Cell View"
  , "MonitorClass;Render Window"
  , "RTEDITLOG;Log"
  , "LaunchUnrealUWindowsClient;Rocket League.*"
  , "AppWindowClass;Control .* (FINAL|release)"
  , "PIGS_MainWnd;.*"
  , "TankWindowClass;Overwatch"
  , "LaunchUnrealUWindowsClient;Dishonored"
  , "HwndWrapper\[LightBulb.*\];"
  , "HwndWrapper\[AnvilToolkit.*\];.*"
  , "wxWindowNR;uMod.*"
  , "tmlwndcls;TexMod.*"
  , "Ubisoft Connect 2\.0;Social"
  , "Ubisoft Connect 2\.0;Chat"
  , "uplay_download;.*"
  , "uplay_start;Ubisoft Connect"
  , "wxWindowNR;Cemu.*"
  , "Mad Max;.*"
  , "W2ViewportClass;The Witcher 3"
  , "HwndWrapper\[w3InputSettingsPatcher.exe.*\];.*"
  , "ScimitarEngineWindowClass;.*" ; Assassin's Creed games
  , "UnrealWindow;Fortnite*"
  , "DefensivePig.*;THE FINALS*"
  , "HwndWrapper\[Flow.Launcher.*\];.*"
  , "SDL_app;.*" ; Steam
  , "STAR WARS Squadrons;.*"
  , "The Forge;Hades"
  , "techland_game_class;Dying Light"]]

  ; Unique rules
  Config_ruleCustom := ["AbletonVstPlugClass;.*;;1;0;1;1;1;0;"
  , "CabinetWClass;.*;;1;0;0;0;1;0;"
  , "CASCADIA_HOSTING_WINDOW_CLASS;.*;;1;0;0;0;1;0;"
  , "RAIL_WINDOW;Xephyr*;;1;1;0;1;0;0;"
  , "TMainForm;TreeSize Free;;1;0;0;0;1;0;"
  , "Chrome_WidgetWin_1;.* - Brave;;1;1;1;0;1;0;"]

  Loop % Config_ruleDefault.Length() {
    Config_ruleCount++
    Config_rule_#%Config_ruleCount% := Config_ruleDefault[A_Index]
  }
  Loop % Config_ruleManage[2].Length() {
    Config_ruleCount++
    Config_rule_#%Config_ruleCount% := Config_ruleManage[2][A_Index] . Config_ruleManage[1]
  }
  Loop % Config_ruleUnmanage[2].Length() {
    Config_ruleCount++
    Config_rule_#%Config_ruleCount% := Config_ruleUnmanage[2][A_Index] . Config_ruleUnmanage[1]
  }
  Loop % Config_ruleCustom.Length() {
    Config_ruleCount++
    Config_rule_#%Config_ruleCount% := Config_ruleCustom[A_Index]
  }

  ;; Configuration management
  Config_autoSaveSession := "auto"                ;; "off" | "auto" | "ask"
  Config_maintenanceInterval := 5000
  Config_monitorDisplayChangeMessages := "off"    ;; "off" | "on" | "ask"

  Config_hotkeyCount := 0
  Config_restoreConfig(Config_filePath)
  If (SubStr(A_OSVersion, 1, 3) = "10.") {
    Config_borderWidth    := 0
    Config_borderPadding  := -1
    Config_showBorder     := True
    Config_selBorderColor := ""
  }
  
  Config_getSystemSettings()
  Config_initColors()
  Loop, % Config_layoutCount {
    StringSplit, layout, Config_layout_#%A_Index%, `;
    Config_layoutFunction_#%A_Index% := layout2
    Config_layoutSymbol_#%A_Index%   := layout1
  }
  StringSplit, vNames, Config_viewNames, `;
  If vNames0 > 9
    Config_viewCount := 9
  Else
    Config_viewCount := vNames0
  Loop, % Config_viewCount
    Config_viewNames_#%A_Index% := vNames%A_Index%
}

Config_initColors() {
  Global

  Loop, 3 {
    StringReplace, Config_backColor_#%A_Index%, Config_backColor_#%A_Index%, `;0`;, `;000000`;, All
    Config_backColor_#%A_Index% := RegExReplace(Config_backColor_#%A_Index%, "^0;", "000000;")
    Config_backColor_#%A_Index% := RegExReplace(Config_backColor_#%A_Index%, ";0$", ";000000")
    StringSplit, Config_backColor_#%A_Index%_#, Config_backColor_#%A_Index%, `;

    StringReplace, Config_foreColor_#%A_Index%, Config_foreColor_#%A_Index%, `;0`;, `;000000`;, All
    Config_foreColor_#%A_Index% := RegExReplace(Config_foreColor_#%A_Index%, "^0;", "000000;")
    Config_foreColor_#%A_Index% := RegExReplace(Config_foreColor_#%A_Index%, ";0$", ";000000")
    StringSplit, Config_foreColor_#%A_Index%_#, Config_foreColor_#%A_Index%, `;

    StringReplace, Config_fontColor_#%A_Index%, Config_fontColor_#%A_Index%, `;0`;, `;000000`;, All
    Config_fontColor_#%A_Index% := RegExReplace(Config_fontColor_#%A_Index%, "^0;", "000000;")
    Config_fontColor_#%A_Index% := RegExReplace(Config_fontColor_#%A_Index%, ";0$", ";000000")
    StringSplit, Config_fontColor_#%A_Index%_#, Config_fontColor_#%A_Index%, `;
  }
}

Config_convertSystemColor(systemColor)
{ ;; systemColor format: 0xBBGGRR
  rr := SubStr(systemColor, 7, 2)
  gg := SubStr(systemColor, 5, 2)
  bb := SubStr(systemColor, 3, 2)

  Return, rr gg bb
}

Config_edit() {
  Global Config_filePath
  
  If Not FileExist(Config_filePath)
    Config_UI_saveSession()
  Run, edit %Config_filePath%
}

Config_getSystemSettings() {
  Global Config_backColor_#1, Config_foreColor_#1, Config_fontColor_#1
  Global Config_backColor_#2, Config_foreColor_#2, Config_fontColor_#2
  Global Config_backColor_#3, Config_foreColor_#3, Config_fontColor_#3
  Global Config_fontName, Config_fontSize, Config_scalingFactor

  If Not Config_fontName {
    ncmSize := VarSetCapacity(ncm, 4 * (A_OSVersion = "WIN_VISTA" ? 11 : 10) + 5 * (28 + 32 * (A_IsUnicode ? 2 : 1)), 0)
    NumPut(ncmSize, ncm, 0, "UInt")
    DllCall("SystemParametersInfo", "UInt", 0x0029, "UInt", ncmSize, "UInt", &ncm, "UInt", 0)

    VarSetCapacity(lf, 28 + 32 * (A_IsUnicode ? 2 : 1), 0)
    DllCall("RtlMoveMemory", "Str", lf, "UInt", &ncm + 24, "UInt", 28 + 32 * (A_IsUnicode ? 2 : 1))
    VarSetCapacity(Config_fontName, 32 * (A_IsUnicode ? 2 : 1), 0)
    DllCall("RtlMoveMemory", "Str", Config_fontName, "UInt", &lf + 28, "UInt", 32 * (A_IsUnicode ? 2 : 1))
    ;; maestrith: Script Writer (http://www.autohotkey.net/~maestrith/Script Writer/)
  }
  If Not Config_fontSize {
    ncmSize := VarSetCapacity(ncm, 4 * (A_OSVersion = "WIN_VISTA" ? 11 : 10) + 5 * (28 + 32 * (A_IsUnicode ? 2 : 1)), 0)
    NumPut(ncmSize, ncm, 0, "UInt")
    DllCall("SystemParametersInfo", "UInt", 0x0029, "UInt", ncmSize, "UInt", &ncm, "UInt", 0)

    lfSize := VarSetCapacity(lf, 28 + 32 * (A_IsUnicode ? 2 : 1), 0)
    NumPut(lfSize, lf, 0, "UInt")
    DllCall("RtlMoveMemory", "Str", lf, "UInt", &ncm + 24, "UInt", 28 + 32 * (A_IsUnicode ? 2 : 1))

    lfHeightSize := VarSetCapacity(lfHeight, 4, 0)
    NumPut(lfHeightSize, lfHeight, 0, "Int")
    lfHeight := NumGet(lf, 0, "Int")

    lfPixelsY := DllCall("GetDeviceCaps", "UInt", DllCall("GetDC", "UInt", 0), "UInt", 90)  ;; LOGPIXELSY
    Config_fontSize := -DllCall("MulDiv", "Int", lfHeight, "Int", 72, "Int", lfPixelsY)
    ;; maestrith: Script Writer (http://www.autohotkey.net/~maestrith/Script Writer/)
  }
  SetFormat, Integer, hex
  If Not (Config_backColor_#1 And Config_foreColor_#1 And Config_fontColor_#1
      And Config_backColor_#2 And Config_foreColor_#2 And Config_fontColor_#2
      And Config_backColor_#3 And Config_foreColor_#3 And Config_fontColor_#3) {
    COLOR_ACTIVECAPTION           := Config_convertSystemColor(DllCall("GetSysColor", "Int",  2))
    COLOR_CAPTIONTEXT             := Config_convertSystemColor(DllCall("GetSysColor", "Int",  9))
    COLOR_GRADIENTACTIVECAPTION   := Config_convertSystemColor(DllCall("GetSysColor", "Int", 27))
    COLOR_GRADIENTINACTIVECAPTION := Config_convertSystemColor(DllCall("GetSysColor", "Int", 28))
    COLOR_HIGHLIGHT               := Config_convertSystemColor(DllCall("GetSysColor", "Int", 13))
    COLOR_INACTIVECAPTION         := Config_convertSystemColor(DllCall("GetSysColor", "Int",  3))
    COLOR_INACTIVECAPTIONTEXT     := Config_convertSystemColor(DllCall("GetSysColor", "Int", 19))
    COLOR_MENU                    := Config_convertSystemColor(DllCall("GetSysColor", "Int",  4))
    COLOR_MENUTEXT                := Config_convertSystemColor(DllCall("GetSysColor", "Int",  7))
    ;; <view>;<layout>;<title>;<shebang>;<time>;<date>;<anyText>;<batteryStatus>;<volumeLevel>
    If Not Config_backColor_#1 {
      Config_backColor_#1 := COLOR_GRADIENTINACTIVECAPTION ";" COLOR_ACTIVECAPTION ";" COLOR_MENU ";" COLOR_ACTIVECAPTION ";" COLOR_MENU ";" COLOR_ACTIVECAPTION ";"
      Config_backColor_#1 .= COLOR_GRADIENTINACTIVECAPTION ";" COLOR_GRADIENTACTIVECAPTION ";" COLOR_GRADIENTACTIVECAPTION
    }
    If Not Config_backColor_#2
      Config_backColor_#2 := COLOR_GRADIENTACTIVECAPTION ";;;;;;;" COLOR_MENU ";" COLOR_MENU
    If Not Config_backColor_#3
      Config_backColor_#3 := ";;;;;;;ff8040;"

    If Not Config_foreColor_#1 {
      Config_foreColor_#1 := COLOR_INACTIVECAPTION ";" COLOR_ACTIVECAPTION ";" COLOR_MENU ";" COLOR_ACTIVECAPTION ";" COLOR_MENU ";" COLOR_ACTIVECAPTION ";"
      Config_foreColor_#1 .= COLOR_INACTIVECAPTION ";" COLOR_ACTIVECAPTION ";" COLOR_GRADIENTINACTIVECAPTION
    }
    If Not Config_foreColor_#2
      Config_foreColor_#2 := COLOR_ACTIVECAPTION ";;;;;;;" COLOR_HIGHLIGHT ";" COLOR_HIGHLIGHT
    If Not Config_foreColor_#3
      Config_foreColor_#3 := ";;;;;;;" COLOR_INACTIVECAPTION ";"

    If Not Config_fontColor_#1 {
      Config_fontColor_#1 := COLOR_INACTIVECAPTIONTEXT ";" COLOR_CAPTIONTEXT ";" COLOR_MENUTEXT ";" COLOR_CAPTIONTEXT ";" COLOR_MENUTEXT ";" COLOR_CAPTIONTEXT ";"
      Config_fontColor_#1 .= COLOR_INACTIVECAPTIONTEXT ";" COLOR_CAPTIONTEXT ";" COLOR_INACTIVECAPTIONTEXT
    }
    If Not Config_fontColor_#2
      Config_fontColor_#2 := COLOR_CAPTIONTEXT ";;;;;;;" COLOR_MENUTEXT ";" COLOR_MENUTEXT
    If Not Config_fontColor_#3
      Config_fontColor_#3 := ";;;;;;;" COLOR_INACTIVECAPTIONTEXT ";"
  }
  SetFormat, Integer, d

  RegRead, appliedDPI, HKEY_CURRENT_USER, Control Panel\Desktop\WindowMetrics, AppliedDPI
  If (ErrorLevel = 0)
    Config_scalingFactor := 96 / appliedDPI
}

Config_hotkeyLabel:
  Config_redirectHotkey(A_ThisHotkey)
Return

Config_readinAny() {
  ;; Add information to the variable 'text' in this function to display it in the status bar.
  Global Config_readinCpu, Config_readinDiskLoad, Config_readinMemoryUsage, Config_readinNetworkLoad

  text := ""
  If (Config_readinCpu Or Config_readinDiskLoad Or Config_readinMemoryUsage Or Config_readinNetworkLoad)
    text .= ResourceMonitor_getText()

  Return, text
}

Config_redirectHotkey(key)
{
  Global

  Loop, % Config_hotkeyCount
  {
    If (key = Config_hotkey_#%A_index%_key)
    {
      Debug_logMessage("DEBUG[1] Config_redirectHotkey: Found " Config_hotkey_#%A_index%_key " -> " Config_hotkey_#%A_index%_command, 1)
      Main_evalCommand(Config_hotkey_#%A_index%_command)
      Break
    }
  }
}

Config_restoreConfig(filename)
{
  Local cmd, i, key, type, val, var

  If Not FileExist(filename)
    Return

  Loop, READ, %filename%
    If (SubStr(A_LoopReadLine, 1, 7) = "Config_")
    {
      ;Log_msg("Processing line: " . A_LoopReadLine)
      i := InStr(A_LoopReadLine, "=")
      var := SubStr(A_LoopReadLine, 1, i - 1)
      val := SubStr(A_LoopReadLine, i + 1)
      type := SubStr(var, 1, 13)
      If (type = "Config_hotkey")
      {
        Debug_logMessage("Processing configured hotkey: " . A_LoopReadLine, 0)
        i := InStr(val, "::")
        key := SubStr(val, 1, i - 1)
        cmd := SubStr(val, i + 2)
        If Not cmd
          Hotkey, %key%, Off
        Else
        {
          Debug_logMessage("  Hotkey: " . key . " -> " . cmd, 0)
          Config_hotkeyCount += 1
          Config_hotkey_#%Config_hotkeyCount%_key := key
          Config_hotkey_#%Config_hotkeyCount%_command := cmd
          Hotkey, %key%, Config_hotkeyLabel
        }
      }
      Else If (type = "Config_rule")
      {
        i := 0
        If InStr(var, "Config_rule_#")
          i := SubStr(var, 14)
        If (i = 0 Or i > Config_ruleCount)
        {
          Config_ruleCount += 1
          i := Config_ruleCount
        }
        var := "Config_rule_#" i
      }
      %var% := val
    }
}

Config_restoreLayout(filename, m) {
  Local i, var, val

  If Not FileExist(filename)
    Return

  Loop, READ, %filename%
    If (SubStr(A_LoopReadLine, 1, 10 + StrLen(m)) = "Monitor_#" m "_" Or SubStr(A_LoopReadLine, 1, 8 + StrLen(m)) = "View_#" m "_#") {
      i := InStr(A_LoopReadLine, "=")
      var := SubStr(A_LoopReadLine, 1, i - 1)
      val := SubStr(A_LoopReadLine, i + 1)
      %var% := val
    }
}

Config_saveSession(original, target)
{
  Local m, text, tmpfilename

  tmpfilename := target . ".tmp"
  FileDelete, %tmpfilename%

  text := "; bug.n - tiling window management`n; @version " VERSION "`n`n"
  If FileExist(original)
  {
    Loop, READ, %original%
    {
      If (SubStr(A_LoopReadLine, 1, 7) = "Config_")
        text .= A_LoopReadLine "`n"
    }
    text .= "`n"
  }

  Loop, % Manager_monitorCount
  {
    m := A_Index
    If Not (Monitor_#%m%_aView_#1 = 1)
      text .= "Monitor_#" m "_aView_#1=" Monitor_#%m%_aView_#1 "`n"
    If Not (Monitor_#%m%_aView_#2 = 1)
      text .= "Monitor_#" m "_aView_#2=" Monitor_#%m%_aView_#2 "`n"
    If Not (Monitor_#%m%_showBar = Config_showBar)
      text .= "Monitor_#" m "_showBar=" Monitor_#%m%_showBar "`n"
    Loop, % Config_viewCount
    {
      If Not (View_#%m%_#%A_Index%_layout_#1 = 1)
        text .= "View_#" m "_#" A_Index "_layout_#1=" View_#%m%_#%A_Index%_layout_#1 "`n"
      If Not (View_#%m%_#%A_Index%_layout_#2 = 1)
        text .= "View_#" m "_#" A_Index "_layout_#2=" View_#%m%_#%A_Index%_layout_#2 "`n"
      If Not (View_#%m%_#%A_Index%_layoutAxis_#1 = Config_layoutAxis_#1)
        text .= "View_#" m "_#" A_Index "_layoutAxis_#1=" View_#%m%_#%A_Index%_layoutAxis_#1 "`n"
      If Not (View_#%m%_#%A_Index%_layoutAxis_#2 = Config_layoutAxis_#2)
        text .= "View_#" m "_#" A_Index "_layoutAxis_#2=" View_#%m%_#%A_Index%_layoutAxis_#2 "`n"
      If Not (View_#%m%_#%A_Index%_layoutAxis_#3 = Config_layoutAxis_#3)
        text .= "View_#" m "_#" A_Index "_layoutAxis_#3=" View_#%m%_#%A_Index%_layoutAxis_#3 "`n"
      If Not (View_#%m%_#%A_Index%_layoutGapWidth = Config_layoutGapWidth)
        text .= "View_#" m "_#" A_Index "_layoutGapWidth=" View_#%m%_#%A_Index%_layoutGapWidth "`n"
      If Not (View_#%m%_#%A_Index%_layoutMFact = Config_layoutMFactor)
        text .= "View_#" m "_#" A_Index "_layoutMFact=" View_#%m%_#%A_Index%_layoutMFact "`n"
      If Not (View_#%m%_#%A_Index%_layoutMX = 1)
        text .= "View_#" m "_#" A_Index "_layoutMX=" View_#%m%_#%A_Index%_layoutMX "`n"
      If Not (View_#%m%_#%A_Index%_layoutMY = 1)
        text .= "View_#" m "_#" A_Index "_layoutMY=" View_#%m%_#%A_Index%_layoutMY "`n"
    }
  }

  ;; The FileMove below is an all-or-nothing replacement of the file.
  ;; We don't want to leave this half-finished.
  FileAppend, %text%, %tmpfilename%
  If ErrorLevel And Not (original = Config_filePath And target = Config_filePath And Not FileExist(original)) {
    If FileExist(tmpfilename)
      FileDelete, %tmpfilename%
  } Else
    FileMove, %tmpfilename%, %target%, 1
}

Config_UI_saveSession() {
  Global Config_filePath

  Config_saveSession(Config_filePath, Config_filePath)
}