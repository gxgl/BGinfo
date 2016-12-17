strComputer = "."
On Error Resume Next
Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colSettings = objWMIService.ExecQuery ("SELECT DefaultIPGateway FROM Win32_NetworkAdapterConfiguration where IPEnabled = 'True'")
For Each objIP in colSettings
   For i=LBound(objIP.DefaultIPGateway) to UBound(objIP.DefaultIPGateway)
      If InStr(objIP.DefaultIPGateway(i),":") = 0 Then Echo objIP.DefaultIPGateway(i)
   Next
Next