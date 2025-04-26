#Requires AutoHotkey v2.0.2
#SingleInstance Force

; Functions
Komorebic(cmd) {
    RunWait(format("komorebic.exe {}", cmd), , "Hide")
}

RunAndWait(app, id) {
  Run(app)
  WinWait(id)
  ; bring it to the front and in focus
  WinActivate(id)
}

LaunchOrFocus(path) {
  exe := SubStr(path, InStr(path, "\", false, -1) + 1)
  id := 'ahk_exe ' exe
  ; checks if an app is already running
  if !ProcessExist(exe)
    ; IF NOT open and focus it.
    Run(path)
    WinWait(id)
  ; bring it to the front and in focus
  WinActivate(id)
}

Launch(path) {
  exe := SubStr(path, InStr(path, "\", false, -1) + 1)
  id := 'ahk_exe ' exe
  RunAndWait(path, id)
}

LaunchWPA(path, arguments) {
  exe := SubStr(path, InStr(path, "\", false, -1) + 1)
  id := 'ahk_exe ' exe
  path_with_arguments:= path arguments
  RunAndWait(path_with_arguments, id)
}

LaunchLnk(lnk, exe){
  id := 'ahk_exe ' exe
  RunAndWait(lnk, id)
}

; Some common paths
UserProfile := EnvGet("userprofile")
AppData := EnvGet("APPDATA")
LocalAppData := EnvGet("LocalAppData")
ProgramFiles := EnvGet("programfiles")
ProgramFiles86 := EnvGet("programfiles(x86)")
WinDir := EnvGet("WINDIR")
Ucrt64 := "C:\tools\msys64\ucrt64\bin"

; Applications variables
terminal := LocalAppData "\Microsoft\WindowsApps\wt.exe"
browser := ProgramFiles "\Mozilla Firefox\firefox.exe"
editor := ProgramFiles "\Neovide\neovide.exe"
file_manager := WinDir "\explorer.exe"
email := ProgramFiles "\Mozilla Thunderbird\thunderbird.exe"
note := LocalAppData "\Programs\Joplin\Joplin.exe"
password := ProgramFiles "\Bitwarden\Bitwarden.exe"
task_manager := WinDir "\system32\taskmgr.exe"
gaming := LocalAppData "\Playnite\Playnite.DesktopApp.exe"
iracing := AppData "\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Iracing.lnk"
calc := ProgramFiles "\LibreOffice\program\scalc.exe"
music_studio := "C:\ProgramData\Ableton\Live 12 Standard\Program\Ableton Live 12 Standard.exe"
dj := ProgramFiles "\Pioneer\rekordbox 6.8.5\rekordbox.exe"
spotify := AppData "\Spotify\Spotify.exe"
feed := ProgramFiles86 "\RSS Guard\rssguard.exe"
wpa_exe := ProgramFiles86 "\Microsoft\Edge\Application\msedge_proxy.exe"
reddit := " --profile-directory=Default --app-id=lgnggepjiihbfdbedefdhcffnmhcahbm --app-url=https://www.reddit.com/ --app-launch-source="
soundcloud := " --profile-directory=Default --app-id=eikjhbkpemdappjfcmdeeeamdpkgabmk --app-url=https://soundcloud.com/discover --app-launch-source=4"

; FlowLauncher
<#r::Send ("!{Space}")

; Applications launchers
;; tools
<#f::Launch(file_manager)
<#t::LaunchOrFocus(task_manager)
<#e::LaunchOrFocus(editor)
<#h::
{
  Send ("!{Space}")
  Sleep 100
  Send "cb"
}
;; web
<#b::LaunchOrFocus(browser)
<#a::LaunchWPA(wpa_exe, soundcloud)
<#u::LaunchOrFocus(feed)
<#q::LaunchWPA(wpa_exe, reddit)
;; productivity
<#c::LaunchOrFocus(calc)
<#s::LaunchOrFocus(music_studio)
<#d::LaunchOrFocus(dj)
<#Enter::LaunchOrFocus(terminal)
;; gaming
<#g::LaunchOrFocus(gaming)
<#i::LaunchLnk(iracing, "IracingUI.exe")
;; pim
<#m::LaunchOrFocus(email)
<#n::LaunchOrFocus(note)
<#p::LaunchOrFocus(password)
;; media
<#y::LaunchOrFocus(spotify)

; Focus monitors
!s::Komorebic("cycle-monitor next")

; Focus workspaces
!h::Komorebic("cycle-workspace previous")
!l::Komorebic("cycle-workspace next")
;; [x]tools
!1::Komorebic("focus-workspace 0")
!x::Komorebic("focus-workspace 0")
;; [w]eb
!2::Komorebic("focus-workspace 1")
!w::Komorebic("focus-workspace 1")
;; [p]roductivity
!3::Komorebic("focus-workspace 2")
!p::Komorebic("focus-workspace 2")
;; [g]aming
!4::Komorebic("focus-workspace 3")
!g::Komorebic("focus-workspace 3")
;; p[i]m
!5::Komorebic("focus-workspace 4")
!i::Komorebic("focus-workspace 4")
;; medi[a]
!6::Komorebic("focus-workspace 5")
!a::Komorebic("focus-workspace 5")
!Esc::Komorebic("focus-last-workspace")

; Focus windows
!k::Komorebic("cycle-focus previous")
!j::Komorebic("cycle-focus next")

; Move to monitors
!o::Komorebic("cycle-move-to-monitor next")

; Move windows across workspaces
!+h::Komorebic("cycle-send-to-workspace previous")
!+l::Komorebic("cycle-send-to-workspace next")
;; [x]tools
!+1::Komorebic("move-to-workspace 0")
!+x::Komorebic("move-to-workspace 0")
;; [w]eb
!+2::Komorebic("move-to-workspace 0")
!+w::Komorebic("move-to-workspace 0")
;; [p]roductivity
!+3::Komorebic("move-to-workspace 2")
!+p::Komorebic("move-to-workspace 2")
;; [g]aming
!+4::Komorebic("move-to-workspace 1")
!+g::Komorebic("move-to-workspace 1")
;; p[i]m
!+5::Komorebic("move-to-workspace 3")
!+i::Komorebic("move-to-workspace 3")
;; medi[a]
!+6::Komorebic("move-to-workspace 4")
!+a::Komorebic("move-to-workspace 4")

; Move windows
!+k::Komorebic("cycle-move previous")
!+j::Komorebic("cycle-move next")
!Enter::Komorebic("promote")

; Manipulate windows
!+::Komorebic("resize-axis horizontal increase")
!-::Komorebic("resize-axis horizontal decrease")
!++::Komorebic("resize-axis vertical increase")
!+-::Komorebic("resize-axis vertical decrease")
!c::Komorebic("close")
!m::Komorebic("minimize")
!z::Komorebic("toggle-float")
!+f::Komorebic("toggle-monocle")
!<::Komorebic("cycle-layout next")

; Window manager options
!+r::Komorebic("reload-configuration")
!+t::Komorebic("retile")
