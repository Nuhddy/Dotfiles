#SingleInstance Force

cast(sign) {
    key := sign[1]
    delay := sign[2]

    Send, {%key% down}
    if (delay = -1) {
        KeyWait, LShift, U
    } else {
        Sleep, % delay
    }
    Send, {%key% up}
}

; {sign: [key, delay]}
signs := {yrden: [4, 1800], quen: [6, -1], igni: [5, -1], axii: [7, 3000], aard: [3, 350]}

+3::cast(signs["aard"])
+4::cast(signs["yrden"])
+5::cast(signs["igni"])
+6::cast(signs["quen"])
+7::cast(signs["axii"])