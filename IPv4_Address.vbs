strComputer = "."
On Error Resume Next
Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colSettings = objWMIService.ExecQuery ("SELECT IPAddress FROM Win32_NetworkAdapterConfiguration where IPEnabled = 'True'")
For Each objIP in colSettings
   For i=LBound(objIP.IPAddress) to UBound(objIP.IPAddress)
      If InStr(objIP.IPAddress(i),":") = 0 Then Echo objIP.IPAddress(i)
   Next
Next