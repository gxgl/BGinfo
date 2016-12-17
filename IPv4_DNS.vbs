strComputer = "."
On Error Resume Next
Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colSettings = objWMIService.ExecQuery ("SELECT DNSServerSearchOrder FROM Win32_NetworkAdapterConfiguration where IPEnabled = 'True'")
For Each objIP in colSettings
   For i=LBound(objIP.DNSServerSearchOrder) to UBound(objIP.DNSServerSearchOrder)
      If InStr(objIP.DNSServerSearchOrder(i),":") = 0 Then Echo objIP.DNSServerSearchOrder(i)
   Next
Next