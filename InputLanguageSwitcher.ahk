; ===== USER-DEFINED VALUES =====

global iconFileName := A_WorkingDir . "\icon.ico"

; TODO: Maybe fill this array automatically, so the users don't have to do it themselves.

; Filled by the user with the desired languages in the exact same order as they appear in Windows.
; Those IDs should be taken by the hotkey below!
global inputLanguageArray := []
inputLanguageArray.Push("67699721") ; English
inputLanguageArray.Push("4038001666") ; Bulgarian
inputLanguageArray.Push("68224017") ; Japanese
inputLanguageArray.Push("4039115783") ; German

; Uncomment the line below to enable a way to get all language IDs that you can use for the inputLanguageArray.
; Ctrl & 1:: ShowCurrentLayoutIndex()

; ===== SCRIPT-DEFINED VALUES =====

; Map containing all languages from the inputLanguageArray, but with their respective indexes as values.
global inputLanguageDictionary := {}
; The maximum number of keyboard layouts that you can switch to.
global maximumLayouts := inputLanguageArray.Length()

; ===== SETUP =====

; Setup the languages
Loop % inputLanguageArray.Length()
{
    inputLanguageDictionary[inputLanguageArray[A_Index]] := A_Index
}
; Free up some memory. This array is not used anymore.
inputLanguageArray := []

; Add an icon :)
IfExist, %iconFileName%
    Menu, Tray, Icon, %iconFileName%

; ===== HOTKEYS =====

; TODO: Figure out if it's worth to put this code into a loop and avoid hardcoding numbers like that... :D
; NOTE: SC15D is the keyboard button that simulates a right mouse click. Using Ctrl, Alt or Shift was creating problems, since immediately after using those hotkeys I wanted to use Alt + Shift to switch the langauge. This is why I chose a very neutral button like SC15D.

; The number inside the ChangeInputLayout method is the index of the language that this script will switch to.
SC15D & 1:: ChangeInputLayout(1)
SC15D & 2:: ChangeInputLayout(2)
SC15D & 3:: ChangeInputLayout(3)
SC15D & 4:: ChangeInputLayout(4)

; ===== METHODS =====

; Shows a message on the screen with the ID of the currently set keyboard layout in Windows. ID can be used for the inputLanguageArray.
ShowCurrentLayoutIndex()
{
    MsgBox, % GetCurrentLayoutId()
}

; Gets the currently set in Windows keyboard layout's ID
GetCurrentLayoutId()
{
    threadId := DllCall("GetWindowThreadProcessId", "Int", WinActive("A"), "Int", 0)
    return DllCall("GetKeyboardLayout", "UInt", threadId, "UInt")
}

; Find the index of the current keyboard layout based on the indexes in inputLanguageArray.
GetCurrentLayoutIndex()
{
    return inputLanguageDictionary[GetCurrentLayoutId()]
}

; This will change the language input. It changes it by simulating Alt + Shift key presses, which might not work for plenty of reasons. Holding/pressing ctrl/alt/shift might block the change.
ChangeInputLayout(nextLayoutIndex)
{
    ; Quick and dirty way to disable the script when Citrix (software) is open and active. We could also add a check for RDP here...
    WinGet, Active_ID, ID, A
    WinGet, Active_Process, ProcessName, ahk_id %Active_ID%
    if (Active_Process == "CDViewer.exe")
    {
        return
    }
    
    currentLayoutIndex := GetCurrentLayoutIndex()
    if (currentLayoutIndex == nextLayoutIndex)
    {
        return
    }
    
    if (nextLayoutIndex > currentLayoutIndex)
    {
        languageChanges := nextLayoutIndex - currentLayoutIndex
    }
    else
    {
        languageChanges := maximumLayouts - currentLayoutIndex + nextLayoutIndex
    }
    
    BlockInput, On
    
    ; TODO: Maybe find a way to make the switching less hardcoded and more user-friendly.
    
    SendInput, {LAlt down}
    Sleep, 10
    Loop, %languageChanges%
    {
        SendInput, {LShift}
        Sleep, 10
    }
    SendInput, {LAlt up}
    Sleep, 10
    
    BlockInput, Off
}