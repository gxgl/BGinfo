strComputer = "."
On Error Resume Next
Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colSettings = objWMIService.ExecQuery ("SELECT IPSubnet FROM Win32_NetworkAdapterConfiguration where IPEnabled = 'True'")
For Each objIP in colSettings
   For i=LBound(objIP.IPSubnet) to UBound(objIP.IPSubnet)
      If InStr(objIP.IPSubnet(i),".") <> 0 Then Echo objIP.IPSubnet(i)
   Next
Next