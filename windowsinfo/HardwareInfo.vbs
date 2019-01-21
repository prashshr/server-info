strComputer = "."

Function GetServername()
	strComputer=document.getElementById("servername").value
	'document.all.divOutput.innerHTML = document.getElementById("servername").value
	ShowSystemInformation()
	
	If document.getElementById("servername").value = "" Then
		strComputer = "."
    End If	
End Function

Function GetWMIServices()
	Set GetWMIServices = GetObject("winmgmts:" _
	    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
End Function

Function WMIDateStringToDate(dtmWMIDate)
    If Not IsNull(dtmWMIDate) Then
    WMIDateStringToDate = CDate(Mid(dtmWMIDate, 5, 2) & "/" & _
         Mid(dtmWMIDate, 7, 2) & "/" & Left(dtmWMIDate, 4) & _
         " " & Mid (dtmWMIDate, 9, 2) & ":" & _
         Mid(dtmWMIDate, 11, 2) & ":" & Mid(dtmWMIDate, _
         13, 2))
    End If
End Function

Function DisplayOutputHeader(strHeader)
	document.all.headOutput.innerText = strHeader
End Function

Function DisplayOutput(strOutput)
	document.all.divOutput.innerHTML = strOutput
End Function

Function GetTableHeader()
	str = "<TABLE class='tblOutput'>"
	str = str & "<THEAD><TR><TH width=30%>Property</TH><TH>Value</TH></TR></THEAD>"
	str = str & "<TBODY>" & vbCRLF
	GetTableHeader = str
End Function

Function GetTableFooter()
	str = "</TBODY>" & vbCRLF & "</TABLE>" & vbCRLF
	GetTableFooter = str
End Function

Function GetRow(PropName, PropValue)
	str = "<TR>"
	str = str & "<TD class='PropName'>" & PropName & "</TD>"
	str = str & "<TD>" & PropValue & "</TD>"
	str = str & "</TR>" & vbCRLF
	GetRow = str
End Function

Function ShowTimeZoneInfo()
	On Error Resume Next
	DisplayOutputHeader("Time zone - Win32_TimeZone")
	str = ""
	Set objWMIService = GetWMIServices()
	Set colItems = objWMIService.ExecQuery("Select * from Win32_TimeZone")
	For Each objItem in colItems
	    str = str & GetTableHeader()
	    str = str & GetRow("Bias", objItem.Bias)
	    str = str & GetRow("Caption", objItem.Caption)
	    str = str & GetRow("Daylight Bias", objItem.DaylightBias)
	    str = str & GetRow("Daylight Day", objItem.DaylightDay)
	    str = str & GetRow("Daylight Day Of Week", objItem.DaylightDayOfWeek)
	    str = str & GetRow("Daylight Hour", objItem.DaylightHour)
	    str = str & GetRow("Daylight Millisecond", objItem.DaylightMillisecond)
	    str = str & GetRow("Daylight Minute", objItem.DaylightMinute)
	    str = str & GetRow("Daylight Month", objItem.DaylightMonth)
	    str = str & GetRow("Daylight Name", objItem.DaylightName)
	    str = str & GetRow("Daylight Second", objItem.DaylightSecond)
	    str = str & GetRow("Daylight Year", objItem.DaylightYear)
	    str = str & GetRow("Description", objItem.Description)
	    str = str & GetRow("Setting ID", objItem.SettingID)
	    str = str & GetRow("Standard Bias", objItem.StandardBias)
	    str = str & GetRow("Standard Day", objItem.StandardDay)
	    str = str & GetRow("Standard Day Of Week", objItem.StandardDayOfWeek)
	    str = str & GetRow("Standard Hour", objItem.StandardHour)
	    str = str & GetRow("Standard Millisecond", objItem.StandardMillisecond)
	    str = str & GetRow("Standard Minute", objItem.StandardMinute)
	    str = str & GetRow("Standard Month", objItem.StandardMonth)
	    str = str & GetRow("Standard Name", objItem.StandardName)
	    str = str & GetRow("Standard Second", objItem.StandardSecond)
	    str = str & GetRow("Standard Year", objItem.StandardYear)
		str = str & GetTableFooter()
	Next
	DisplayOutput(str)
End Function

Function ShowBaseboardInfo()
	On Error Resume Next
	DisplayOutputHeader("Baseboard")
	str = ""
	Set objWMIService = GetWMIServices()
	Set colItems = objWMIService.ExecQuery("Select * from Win32_BaseBoard")
	For Each objItem in colItems
	    str = str & GetTableHeader()
	    'For Each strOption in objItem.ConfigOptions
	    '    str = str & GetRow("Configuration Option", strOption)
	    'Next
	    'str = str & GetRow("Depth", objItem.Depth)
	    str = str & GetRow("Description", objItem.Description)
	    'str = str & GetRow("Height", objItem.Height)
	    str = str & GetRow("Hosting Board", objItem.HostingBoard)
	    'str = str & GetRow("Hot Swappable", objItem.HotSwappable)
	    str = str & GetRow("Manufacturer", objItem.Manufacturer)
	    'str = str & GetRow("Model", objItem.Model)
	    str = str & GetRow("Name", objItem.Name)
	    'str = str & GetRow("Other Identifying Information", objItem.OtherIdentifyingInfo)
	    'str = str & GetRow("Part Number", objItem.PartNumber)
	    str = str & GetRow("Powered On", objItem.PoweredOn)
	    str = str & GetRow("Product", objItem.Product)
	    'str = str & GetRow("Removable", objItem.Removable)
	    'str = str & GetRow("Replaceable", objItem.Replaceable)
	    'str = str & GetRow("Requirements Description", objItem.RequirementsDescription)
	    'str = str & GetRow("Requires DaughterBoard", objItem.RequiresDaughterBoard)
	    str = str & GetRow("Serial Number", objItem.SerialNumber)
	    'str = str & GetRow("SKU", objItem.SKU)
	    str = str & GetRow("Slot Layout", objItem.SlotLayout)
	    'str = str & GetRow("Special Requirements", objItem.SpecialRequirements)
	    str = str & GetRow("Tag", objItem.Tag)
	    str = str & GetRow("Version", objItem.Version)
	    'str = str & GetRow("Weight", objItem.Weight)
	    'str = str & GetRow("Width", objItem.Width)
	    str = str & GetTableFooter()
	Next
	DisplayOutput(str)
End Function

Function ShowComputerBusInfo()
	On Error Resume Next
	DisplayOutputHeader("Computer Bus")
	str = ""
	Set objWMIService = GetWMIServices()
	Set colItems = objWMIService.ExecQuery("Select * from Win32_Bus")
	For Each objItem in colItems
	    str = str & GetTableHeader()
	    str = str & GetRow("Bus Number", objItem.BusNum)
			Select Case objItem.BusType
				Case -1: strBusTypeType =   "Undefined"
				Case 0: strBusTypeType =   "Internal"
				Case 1: strBusTypeType =   "ISA"
				Case 2: strBusTypeType =   "EISA"
				Case 3: strBusTypeType =   "MicroChannel"
				Case 4: strBusTypeType =   "TurboChannel"
				Case 5: strBusTypeType =   "PCI Bus"
				Case 6: strBusTypeType =   "VME Bus"
				Case 7: strBusTypeType =   "NuBus"
				Case 8: strBusTypeType =   "PCMCIA Bus"
				Case 9: strBusTypeType =   "C Bus"
				Case 10: strBusTypeType =   "MPI Bus"
				Case 11: strBusTypeType =   "MPSA Bus"
				Case 12: strBusTypeType =   "Internal Processor"
				Case 13: strBusTypeType =   "Internal Power Bus"
				Case 14: strBusTypeType =   "PNP ISA Bus"
				Case 15: strBusTypeType =   "PNP Bus"		
				Case 16: strBusTypeType =   "Maximum Interface Type"
			End Select		
	    str = str & GetRow("Bus Type", strBusType)
	    str = str & GetRow("Description", objItem.Description)
	    str = str & GetRow("Device ID", objItem.DeviceID)
	    str = str & GetRow("Name", objItem.Name)
	    str = str & GetRow("PNP Device ID", objItem.PNPDeviceID)
	    str = str & GetTableFooter()
	Next
	DisplayOutput(str)
End Function

Function ShowDesktopMonitorInfo()
	On Error Resume Next
	DisplayOutputHeader("Desktop monitor - Win32_DesktopMonitor")
	str = ""
	Set objWMIService = GetWMIServices()
	Set colItems = objWMIService.ExecQuery("Select * from Win32_DesktopMonitor")
	For Each objItem in colItems
	    str = str & GetTableHeader()
	    str = str & GetRow("Availability", objItem.Availability)
	    str = str & GetRow("Bandwidth", objItem.Bandwidth)
	    str = str & GetRow("Description", objItem.Description)
	    str = str & GetRow("Device ID", objItem.DeviceID)
	    str = str & GetRow("Display Type", objItem.DisplayType)
	    str = str & GetRow("Is Locked", objItem.IsLocked)
	    str = str & GetRow("Monitor Manufacturer", objItem.MonitorManufacturer)
	    str = str & GetRow("Monitor Type", objItem.MonitorType)
	    str = str & GetRow("Name", objItem.Name)
	    str = str & GetRow("Pixels Per X Logical Inch", objItem.PixelsPerXLogicalInch)
	    str = str & GetRow("Pixels Per Y Logical Inch", objItem.PixelsPerYLogicalInch)
	    str = str & GetRow("PNP Device ID", objItem.PNPDeviceID)
	    str = str & GetRow("Screen Height", objItem.ScreenHeight)
	    str = str & GetRow("Screen Width", objItem.ScreenWidth)
	    str = str & GetTableFooter()
	Next
	DisplayOutput(str)
End Function

Function ShowDeviceMemoryAddressInfo()
	On Error Resume Next
	DisplayOutputHeader("Device memory address - Win32_DeviceMemoryAddress")
	str = ""
	Set objWMIService = GetWMIServices()
	Set colItems = objWMIService.ExecQuery("Select * from Win32_DeviceMemoryAddress")
	For Each objItem in colItems
	    str = str & GetTableHeader()
	    str = str & GetRow("Name", objItem.Name)
	    str = str & GetRow("Starting Address", objItem.StartingAddress)
	    str = str & GetRow("Ending Address", objItem.EndingAddress)
	    str = str & GetTableFooter()
	Next
	DisplayOutput(str)
End Function

Function ShowDMAChannelInfo()
	On Error Resume Next
	DisplayOutputHeader("DMA channel - Win32_DMAChannel")
	str = ""
	Set objWMIService = GetWMIServices()
	Set colItems = objWMIService.ExecQuery("Select * from Win32_DMAChannel")
	For Each objItem in colItems
	    str = str & GetTableHeader()
	    str = str & GetRow("Address Size", objItem.AddressSize)
	    str = str & GetRow("Availability", objItem.Availability)
	    str = str & GetRow("Byte Mode", objItem.ByteMode)
	    str = str & GetRow("Channel Timing", objItem.ChannelTiming)
	    str = str & GetRow("DMA Channel", objItem.DMAChannel)
	    str = str & GetRow("Maximum Transfer Size", objItem.MaxTransferSize)
	    str = str & GetRow("Name", objItem.Name)
	    str = str & GetRow("Type C Timing", objItem.TypeCTiming)
	    str = str & GetRow("Word Mode", objItem.WordMode)
	    str = str & GetTableFooter()
	Next
	DisplayOutput(str)
End Function

Function ShowIRQSettingsInfo()
	On Error Resume Next
	DisplayOutputHeader("IRQ Settings")
	str = ""
	Set objWMIService = GetWMIServices()
	Set colItems = objWMIService.ExecQuery("Select * from Win32_IRQResource")
	For Each objItem in colItems
	    str = str & GetTableHeader()
		str = str & GetRow("Name", objItem.Name)
		str = str & GetRow("IRQ Number", objItem.IRQNumber)
		str = str & GetRow("Availability", objItem.Availability)
		str = str & GetRow("Hardware", objItem.Hardware)
	    str = str & GetRow("Status", objItem.Status)
	    str = str & GetTableFooter()
	Next
	DisplayOutput(str)
End Function

Function ShowKeyboardInfo()
	On Error Resume Next
	DisplayOutputHeader("Keyboard - Win32_Keyboard")
	str = ""
	Set objWMIService = GetWMIServices()
	Set colItems = objWMIService.ExecQuery("Select * from Win32_Keyboard")
	For Each objItem in colItems
	    str = str & GetTableHeader()
	    str = str & GetRow("Caption", objItem.Caption)
	    str = str & GetRow("Description", objItem.Description)
	    str = str & GetRow("Device ID", objItem.DeviceID)
	    str = str & GetRow("Layout", objItem.Layout)
	    str = str & GetRow("Name", objItem.Name)
	    str = str & GetRow("Number of Function Keys", objItem.NumberOfFunctionKeys)
	    str = str & GetRow("PNP Device ID", objItem.PNPDeviceID)
	    str = str & GetTableFooter()
	Next
	DisplayOutput(str)
End Function

Function ShowMemoryDevicesInfo()
	On Error Resume Next
	DisplayOutputHeader("Memory Devices")
	str = ""
	Set objWMIService = GetWMIServices()
	Set colItems = objWMIService.ExecQuery("Select * from Win32_MemoryDevice")
	For Each objItem in colItems
	    str = str & GetTableHeader()
	    str = str & GetRow("Device ID", objItem.DeviceID)
		str = str & GetRow("Status Info", objItem.BlockSize)
	    str = str & GetRow("Starting Address", objItem.StartingAddress)
	    str = str & GetRow("Ending Address", objItem.EndingAddress)
	    str = str & GetTableFooter()
	Next
	DisplayOutput(str)
End Function

Function ShowOnboardDevicesInfo()
	On Error Resume Next
	DisplayOutputHeader("Onboard devices - Win32_OnBoardDevice")
	str = ""
	Set objWMIService = GetWMIServices()
	Set colItems = objWMIService.ExecQuery("Select * from Win32_OnBoardDevice")
	For Each objItem in colItems
	    str = str & GetTableHeader()
	    str = str & GetRow("Description", objItem.Description)
	    str = str & GetRow("Device Type", objItem.DeviceType)
	    str = str & GetRow("Model", objItem.Model)
	    str = str & GetRow("Name", objItem.Name)
	    str = str & GetRow("Tag", objItem.Tag)
	    str = str & GetRow("Version", objItem.Version)
	    str = str & GetTableFooter()
	Next
	DisplayOutput(str)
End Function

Function ShowParallelPortInfo()
	On Error Resume Next
	DisplayOutputHeader("Parallel Ports")
	str = ""
	Set objWMIService = GetWMIServices()
	Set colItems = objWMIService.ExecQuery("Select * from Win32_ParallelPort", , 48)
	For Each objItem in colItems
	    str = str & GetTableHeader()
	    str = str & GetRow("Availability", objItem.Availability)
	    For Each strCapability in objItem.Capabilities
	        str = str & GetRow("Capability", strCapability)
	    Next
	    str = str & GetRow("Description", objItem.Description)
	    str = str & GetRow("Device ID", objItem.DeviceID)
	    str = str & GetRow("Name", objItem.Name)
	    str = str & GetRow("OS Auto Discovered", objItem.OSAutoDiscovered)
	    str = str & GetRow("PNP Device ID", objItem.PNPDeviceID)
	    str = str & GetRow("Protocol Supported", objItem.ProtocolSupported)
	    str = str & GetTableFooter()
	Next
	DisplayOutput(str)
End Function

Function ShowPnPDevicesInfo()
	On Error Resume Next
	DisplayOutputHeader("Plug and Play Devices")
	str = ""
	Set objWMIService = GetWMIServices()
	Set colItems = objWMIService.ExecQuery("Select * from Win32_PnPEntity")
	For Each objItem in colItems
	    str = str & GetTableHeader()
		str = str & GetRow("Class GUID", objItem.ClassGuid)
	    str = str & GetRow("Description", objItem.Description)
	    str = str & GetRow("Device ID", objItem.DeviceID)
	    str = str & GetRow("Manufacturer", objItem.Manufacturer)
	    str = str & GetRow("Name", objItem.Name)
	    str = str & GetRow("PNP Device ID", objItem.PNPDeviceID)
	    str = str & GetRow("Service", objItem.Service)
	    str = str & GetTableFooter()
	Next
	DisplayOutput(str)
End Function

Function ShowPnpSignedDriversInfo()
	On Error Resume Next
	DisplayOutputHeader("Plug and play signed drivers - Win32_PnPSignedDriver")
	str = ""
	Set objWMIService = GetWMIServices()
	Set colItems = objWMIService.ExecQuery("Select * from Win32_PnPSignedDriver")
	For Each objItem in colItems
	    str = str & GetTableHeader()
	    str = str & GetRow("Class Guid", objItem.ClassGuid)
	    str = str & GetRow("Compatibility ID", objItem.CompatID)
	    str = str & GetRow("Description", objItem.Description)
	    str = str & GetRow("Device Class", objItem.DeviceClass)
	    str = str & GetRow("Device ID", objItem.DeviceID)
	    str = str & GetRow("Device Name", objItem.DeviceName)
	    dtmWMIDate = objItem.DriverDate
	    strReturn = WMIDateStringToDate(dtmWMIDate)
	    str = str & GetRow("Driver Date", strReturn)
	    str = str & GetRow("Driver Provider Name", objItem.DriverProviderName)
	    str = str & GetRow("Driver Version", objItem.DriverVersion)
	    str = str & GetRow("HardWare ID", objItem.HardWareID)
	    str = str & GetRow("Inf Name", objItem.InfName)
	    str = str & GetRow("Is Signed", objItem.IsSigned)
	    str = str & GetRow("Manufacturer", objItem.Manufacturer)
	    str = str & GetRow("PDO", objItem.PDO)
	    str = str & GetRow("Signer", objItem.Signer)
	    str = str & GetTableFooter()
	Next
	DisplayOutput(str)
End Function

Function ShowPointingDevicesInfo()
	On Error Resume Next
	DisplayOutputHeader("Pointing devices - Win32_PointingDevice")
	str = ""
	Set objWMIService = GetWMIServices()
	Set colItems = objWMIService.ExecQuery("Select * from Win32_PointingDevice")
	For Each objItem in colItems
	    str = str & GetTableHeader()
	    str = str & GetRow("Description", objItem.Description)
	    str = str & GetRow("Device ID", objItem.DeviceID)
	    str = str & GetRow("Device Interface", objItem.DeviceInterface)
	    str = str & GetRow("Double Speed Threshold", objItem.DoubleSpeedThreshold)
	    str = str & GetRow("Handedness", objItem.Handedness)
	    str = str & GetRow("Hardware Type", objItem.HardwareType)
	    str = str & GetRow("INF File Name", objItem.InfFileName)
	    str = str & GetRow("INF Section", objItem.InfSection)
	    str = str & GetRow("Manufacturer", objItem.Manufacturer)
	    str = str & GetRow("Name", objItem.Name)
	    str = str & GetRow("Number Of Buttons", objItem.NumberOfButtons)
	    str = str & GetRow("PNP Device ID", objItem.PNPDeviceID)
	    str = str & GetRow("Pointing Type", objItem.PointingType)
	    str = str & GetRow("Quad Speed Threshold", objItem.QuadSpeedThreshold)
	    str = str & GetRow("Resolution", objItem.Resolution)
	    str = str & GetRow("Sample Rate", objItem.SampleRate)
	    str = str & GetRow("Synch", objItem.Synch)
	    str = str & GetTableFooter()
	Next
	DisplayOutput(str)
End Function

Function ShowPortConnectorInfo()
	On Error Resume Next
	DisplayOutputHeader("Port Connector")
	str = ""
	Set objWMIService = GetWMIServices()
	Set colItems = objWMIService.ExecQuery("Select * from Win32_PortConnector")
	For Each objItem in colItems
	    str = str & GetTableHeader()
	    For Each strConnectorType in objItem.ConnectorType
			Select Case strConnectorType
				 Case 0: strConnectorTypeType =	"Unknown"
				 Case 1: strConnectorTypeType =	"Other"
				 Case 2: strConnectorTypeType =	"Male"
				 Case 3: strConnectorTypeType =	"Female"
				 Case 4: strConnectorTypeType =	"Shielded"
				 Case 5: strConnectorTypeType =	"Unshielded"
				 Case 6: strConnectorTypeType =	"SCSI (A) High-Density (50 pins)"
				 Case 7: strConnectorTypeType =	"SCSI (A) Low-Density (50 pins)"
				 Case 8: strConnectorTypeType =	"SCSI (P) High-Density (68 pins)"
				 Case 9: strConnectorTypeType =	"SCSI SCA-I (80 pins)"
				 Case 10: strConnectorTypeType =	"SCSI SCA-II (80 pins)"
				 Case 11: strConnectorTypeType =	"SCSI Fibre Channel (DB-9, Copper)"
				 Case 12: strConnectorTypeType =	"SCSI Fibre Channel (Fibre)"
				 Case 13: strConnectorTypeType =	"SCSI Fibre Channel SCA-II (40 pins)"
				 Case 14: strConnectorTypeType =	"SCSI Fibre Channel SCA-II (20 pins)"
				 Case 15: strConnectorTypeType =	"SCSI Fibre Channel BNC"
				 Case 16: strConnectorTypeType =	"ATA 3-1/2 Inch (40 pins)"
				 Case 17: strConnectorTypeType =	"ATA 2-1/2 Inch (44 pins)"
				 Case 18: strConnectorTypeType =	"ATA-2"
				 Case 19: strConnectorTypeType =	"ATA-3"
				 Case 20: strConnectorTypeType =	"ATA/66"
				 Case 21: strConnectorTypeType =	"DB-9"
				 Case 22: strConnectorTypeType =	"DB-15"
				 Case 23: strConnectorTypeType =	"DB-25"
				 Case 24: strConnectorTypeType =	"DB-36"
				 Case 25: strConnectorTypeType =	"RS-232C"
				 Case 26: strConnectorTypeType =	"RS-422"
				 Case 27: strConnectorTypeType =	"RS-423"
				 Case 28: strConnectorTypeType =	"RS-485"
				 Case 29: strConnectorTypeType =	"RS-449"
				 Case 30: strConnectorTypeType =	"V.35"
				 Case 31: strConnectorTypeType =	"X.21"
				 Case 32: strConnectorTypeType =	"IEEE-488"
				 Case 33: strConnectorTypeType =	"AUI"
				 Case 34: strConnectorTypeType =	"UTP Category 3"
				 Case 35: strConnectorTypeType =	"UTP Category 4"
				 Case 36: strConnectorTypeType =	"UTP Category 5"
				 Case 37: strConnectorTypeType =	"BNC"
				 Case 38: strConnectorTypeType =	"RJ11"
				 Case 39: strConnectorTypeType =	"RJ45"
				 Case 40: strConnectorTypeType =	"Fiber MIC"
				 Case 41: strConnectorTypeType =	"Apple AUI"
				 Case 42: strConnectorTypeType =	"Apple GeoPort"
				 Case 43: strConnectorTypeType =	"PCI"
				 Case 44: strConnectorTypeType =	"ISA"
				 Case 45: strConnectorTypeType =	"EISA"
				 Case 46: strConnectorTypeType =	"VESA"
				 Case 47: strConnectorTypeType =	"PCMCIA"
				 Case 48: strConnectorTypeType =	"PCMCIA Type I"
				 Case 49: strConnectorTypeType =	"PCMCIA Type II"
				 Case 50: strConnectorTypeType =	"PCMCIA Type III"
				 Case 51: strConnectorTypeType =	"ZV Port"
				 Case 52: strConnectorTypeType =	"CardBus"
				 Case 53: strConnectorTypeType =	"USB"
				 Case 54: strConnectorTypeType =	"IEEE 1394"
				 Case 55: strConnectorTypeType =	"HIPPI"
				 Case 56: strConnectorTypeType =	"HSSDC (6 pins)"
				 Case 57: strConnectorTypeType =	"GBIC"
				 Case 58: strConnectorTypeType =	"DIN"
				 Case 59: strConnectorTypeType =	"Mini-DIN"
				 Case 60: strConnectorTypeType =	"Micro-DIN"
				 Case 61: strConnectorTypeType =	"PS/2"
				 Case 62: strConnectorTypeType =	"Infrared"
				 Case 63: strConnectorTypeType =	"HP-HIL"
				 Case 64: strConnectorTypeType =	"Access.bus"
				 Case 65: strConnectorTypeType =	"NuBus"
				 Case 66: strConnectorTypeType =	"Centronics"
				 Case 67: strConnectorTypeType =	"Mini-Centronics"
				 Case 68: strConnectorTypeType =	"Mini-Centronics Type-14"
				 Case 69: strConnectorTypeType =	"Mini-Centronics Type-20"
				 Case 70: strConnectorTypeType =	"Mini-Centronics Type-26"
				 Case 71: strConnectorTypeType =	"Bus Mouse"
				 Case 72: strConnectorTypeType =	"ADB"
				 Case 73: strConnectorTypeType =	"AGP"
				 Case 74: strConnectorTypeType =	"VME Bus"
				 Case 75: strConnectorTypeType =	"VME64"
				 Case 76: strConnectorTypeType =	"Proprietary"
				 Case 77: strConnectorTypeType =	"Proprietary Processor Card Slot"
				 Case 78: strConnectorTypeType =	"Proprietary Memory Card Slot"
				 Case 79: strConnectorTypeType =	"Proprietary I/O Riser Slot"
				 Case 80: strConnectorTypeType =	"PCI-66MHZ"
				 Case 81: strConnectorTypeType =	"AGP2X"
				 Case 82: strConnectorTypeType =	"AGP4X"
				 Case 83: strConnectorTypeType =	"PC-98"
				 Case 84: strConnectorTypeType =	"PC-98-Hireso"
				 Case 85: strConnectorTypeType =	"PC-H98"
				 Case 86: strConnectorTypeType =	"PC-98Note"
				 Case 87: strConnectorTypeType =	"PC-98Full"
				 Case 88: strConnectorTypeType =	"SSA SCSI"
				 Case 89: strConnectorTypeType =	"Circular"
				 Case 90: strConnectorTypeType =	"On Board IDE Connector"
				 Case 91: strConnectorTypeType =	"On Board Floppy Connector"
				 Case 92: strConnectorTypeType =	"9 Pin Dual Inline"
				 Case 93: strConnectorTypeType =	"25 Pin Dual Inline"
				 Case 94: strConnectorTypeType =	"50 Pin Dual Inline"
				 Case 95: strConnectorTypeType =	"68 Pin Dual Inline"
				 Case 96: strConnectorTypeType =	"On Board Sound Connector"
				 Case 97: strConnectorTypeType =	"Mini-Jack"
				 Case 98: strConnectorTypeType =	"PCI-X"
				 Case 99: strConnectorTypeType =	"Sbus IEEE 1396-1993 32 Bit"
				 Case 100: strConnectorTypeType =	"Sbus IEEE 1396-1993 64 Bit"
				 Case 101: strConnectorTypeType =	"MCA"
				 Case 102: strConnectorTypeType =	"GIO"
				 Case 103: strConnectorTypeType =	"XIO"
				 Case 104: strConnectorTypeType =	"HIO"
				 Case 105: strConnectorTypeType =	"NGIO"
				 Case 106: strConnectorTypeType =	"PMC"
				 Case 107: strConnectorTypeType =	"MTRJ"
				 Case 108: strConnectorTypeType =	"VF-45"
				 Case 109: strConnectorTypeType =	"Future I/O"
				 Case 110: strConnectorTypeType =	"SC"
				 Case 111: strConnectorTypeType =	"SG"
				 Case 112: strConnectorTypeType =	"Electrical"
				 Case 113: strConnectorTypeType =	"Optical"
				 Case 114: strConnectorTypeType =	"Ribbon"
				 Case 115: strConnectorTypeType =	"GLM"
				 Case 116: strConnectorTypeType =	"1x9"
				 Case 117: strConnectorTypeType =	"Mini SG"
				 Case 118: strConnectorTypeType =	"LC"
				 Case 119: strConnectorTypeType =	"HSSC"
				 Case 120: strConnectorTypeType =	"VHDCI Shielded (68 pins)"
				 Case 121: strConnectorTypeType =	"InfiniBand"				
			End Select
	        str = str & GetRow("Connector Type", strConnectorTypeType)
		Next	
	    str = str & GetRow("Description", objItem.Description)
		str = str & GetRow("Tag", objItem.Tag)
	    str = str & GetRow("External Reference Designator", objItem.ExternalReferenceDesignator)
	    str = str & GetRow("Internal Reference Designator", objItem.InternalReferenceDesignator)
	    str = str & GetRow("Name", objItem.Name)
			Select Case objItem.PortType
				Case 0: strPortTypeType = "None "
				Case 1: strPortTypeType = "Parallel Port XT/AT Compatible "
				Case 2: strPortTypeType = "Parallel Port PS/2 "
				Case 3: strPortTypeType = "Parallel Port ECP "
				Case 4: strPortTypeType = "Parallel Port EPP "
				Case 5: strPortTypeType = "Parallel Port ECP/EPP "
				Case 6: strPortTypeType = "Serial Port XT/AT Compatible "
				Case 7: strPortTypeType = "Serial Port 16450 Compatible "
				Case 8: strPortTypeType = "Serial Port 16550 Compatible "
				Case 9: strPortTypeType = "Serial Port 16550A Compatible "
				Case 10: strPortTypeType = "SCSI Port "
				Case 11: strPortTypeType = "MIDI Port "
				Case 12: strPortTypeType = "Joy Stick Port "
				Case 13: strPortTypeType = "Keyboard Port "
				Case 14: strPortTypeType = "Mouse Port "
				Case 15: strPortTypeType = "SSA SCSI "
				Case 16: strPortTypeType = "USB "
				Case 17: strPortTypeType = "FireWire (IEEE P1394) "
				Case 18: strPortTypeType = "PCMCIA Type II "
				Case 19: strPortTypeType = "PCMCIA Type II "
				Case 20: strPortTypeType = "PCMCIA Type III "
				Case 21: strPortTypeType = "CardBus "
				Case 22: strPortTypeType = "Access Bus Port "
				Case 23: strPortTypeType = "SCSI II "
				Case 24: strPortTypeType = "SCSI Wide "
				Case 25: strPortTypeType = "PC-98 "
				Case 26: strPortTypeType = "PC-98-Hireso "
				Case 27: strPortTypeType = "PC-H98 "
				Case 28: strPortTypeType = "Video Port "
				Case 29: strPortTypeType = "Audio Port "
				Case 30: strPortTypeType = "Modem Port "
				Case 31: strPortTypeType = "Network Port "
				Case 32: strPortTypeType = "8251 Compatible "
				Case 33: strPortTypeType = "8251 FIFO Compatible "
			End Select	
	    str = str & GetRow("Port Type", strPortTypeType)
	    str = str & GetRow("Serial Number", objItem.Model)
	    str = str & GetTableFooter()
	Next
	DisplayOutput(str)
End Function

Function ShowVideoResolutionsInfo()
	On Error Resume Next
	DisplayOutputHeader("Possible video resolutions - CIM_VideoControllerResolution")
	str = ""
	Set objWMIService = GetWMIServices()
	Set colItems = objWMIService.ExecQuery("Select * from CIM_VideoControllerResolution")
	For Each objItem in colItems
	    str = str & GetTableHeader()
	    str = str & GetRow("Setting ID", objItem.SettingID)
	    str = str & GetRow("Horizontal Resolution", objItem.HorizontalResolution)
	    str = str & GetRow("Vertical Resolution", objItem.VerticalResolution)
	    str = str & GetRow("Number Of Colors", objItem.NumberOfColors)
	    str = str & GetRow("Refresh Rate", objItem.RefreshRate)
	    str = str & GetRow("Scan Mode", objItem.ScanMode)
	    str = str & GetTableFooter()
	Next
	DisplayOutput(str)
End Function

Function ShowProcessorInfo()
	On Error Resume Next
	DisplayOutputHeader("Processor Information")
	str = ""
	Set objWMIService = GetWMIServices()
	Set colItems = objWMIService.ExecQuery("Select * from Win32_Processor")
	For Each objItem in colItems
	    str = str & GetTableHeader()
	    str = str & GetRow("Device ID", objItem.DeviceID)
			Select Case objItem.Architecture
				Case 0: strArchitectureType =   "x86"
				Case 1: strArchitectureType =   "MIPS"
				Case 2: strArchitectureType =   "Alpha"
				Case 3: strArchitectureType =   "PowerPC"
				Case 6: strArchitectureType =   "Intel Itanium Processor Family (IPF)"
				Case 9: strArchitectureType =   "x64"		
			End Select
	    str = str & GetRow("Architecture", strArchitectureType)
			Select Case objItem.Availability
				Case 1: strCpuAvailabilityType =   "Other"
				Case 2: strCpuAvailabilityType =   "Unknown"
				Case 3: strCpuAvailabilityType =   "Running or Full Power"
				Case 4: strCpuAvailabilityType =   "Warning"
				Case 5: strCpuAvailabilityType =   "In Test"
				Case 6: strCpuAvailabilityType =   "Not Applicable"	
				Case 7: strCpuAvailabilityType =   "Power Off"
				Case 8: strCpuAvailabilityType =   "Off Line"
				Case 9: strCpuAvailabilityType =   "Off Duty"
				Case 10: strCpuAvailabilityType =   "Degraded"
				Case 11: strCpuAvailabilityType =   "Not Installed"
				Case 12: strCpuAvailabilityType =   "Install Error"
				Case 13: strCpuAvailabilityType =   "Power Save - Unknown"
				Case 14: strCpuAvailabilityType =   "Power Save - Low Power Mode"	
				Case 15: strCpuAvailabilityType =   "Power Save - Standby"
				Case 16: strCpuAvailabilityType =   "Power Cycle"
				Case 17: strCpuAvailabilityType =   "Power Save - Warning"				
			End Select
	    str = str & GetRow("Availability", strCpuAvailabilityType)
			Select Case objItem.CpuStatus
				Case 0: strCpuStatusType =   "Unknown"
				Case 1: strCpuStatusType =   "CPU Enabled"
				Case 2: strCpuStatusType =   "CPU Disabled by User via BIOS Setup"
				Case 3: strCpuStatusType =   "CPU Disabled by BIOS (POST Error)"
				Case 4: strCpuStatusType =   "CPU Is Idle"
				Case 5: strCpuStatusType =   "Reserved"
				Case 6: strCpuStatusType =   "Reserved"	
				Case 7: strCpuStatusType =   "Other"					
			End Select		
	    str = str & GetRow("CPU Status", strCpuStatusType)	    
	    str = str & GetRow("Description", objItem.Description)
		str = str & GetRow("Version", objItem.Version)
	    str = str & GetRow("Manufacturer", objItem.Manufacturer)	    
	    str = str & GetRow("Name", objItem.Name)
		str = str & GetRow("Maximum Clock Speed (MHz)", objItem.MaxClockSpeed)
		str = str & GetRow("Current Clock Speed (MHz)", objItem.CurrentClockSpeed)		
	    str = str & GetRow("External Clock (MHz)", objItem.ExtClock)
	    str = str & GetRow("Family", objItem.Family)
	    str = str & GetRow("L2 Cache Size", objItem.L2CacheSize)
	    str = str & GetRow("Processor Id", objItem.ProcessorId)
			Select Case objItem.ProcessorType
				Case 1: strProcessorTypeType =   "Other"
				Case 2: strProcessorTypeType =   "Unknown"
				Case 3: strProcessorTypeType =   "Central Processor"
				Case 4: strProcessorTypeType =   "Math Processor"
				Case 5: strProcessorTypeType =   "DSP Processor"
				Case 6: strProcessorTypeType =   "Video Processor"
			End Select
	    str = str & GetRow("Processor Type", strProcessorTypeType)
	    str = str & GetRow("Revision", objItem.Revision)
		str = str & GetRow("Number Of Cores", objItem.NumberOfCores)
		str = str & GetRow("Number Of Logical Processors", objItem.NumberOfLogicalProcessors)
	    str = str & GetRow("Role", objItem.Role)
	    str = str & GetRow("Socket Designation", objItem.SocketDesignation)		
			Select Case objItem.StatusInfo
				Case 1: strCpuStatusInfoType =   "Other"	
				Case 2: strCpuStatusInfoType =   "Unknown"
				Case 3: strCpuStatusInfoType =   "Enabled	"
				Case 4: strCpuStatusInfoType =   "Disabled"	
				Case 5: strCpuStatusInfoType =   "Not Applicable"		
			End Select		
	    str = str & GetRow("Status Information", strCpuStatusInfoType)
		str = str & GetRow("Data Width", objItem.DataWidth)
		str = str & GetRow("Address Width", objItem.AddressWidth)
	    str = str & GetRow("Load Percentage", objItem.LoadPercentage)
	    str = str & GetTableFooter()
	Next
	DisplayOutput(str)
End Function

Function ShowPhysicalMemoryConfigurations()
	On Error Resume Next
	DisplayOutputHeader("Physical Memory Configurations")
	str = ""
	Set objWMIService = GetWMIServices()
	Set colItems = objWMIService.ExecQuery("Select * from Win32_PhysicalMemory", , 48)
	For Each objItem in colItems
	    str = str & GetTableHeader()
		str = str & GetRow("Tag", objItem.Tag)
	    str = str & GetRow("Capacity", Int(objItem.Capacity  / 1048576 ) & "MB")
	    str = str & GetRow("Description", objItem.Description)
	    str = str & GetRow("Device Locator", objItem.DeviceLocator)
			Select Case objItem.FormFactor
				Case 0: strFormFactorType =   "Unknown"
				Case 1: strFormFactorType =   "Other"
				Case 2: strFormFactorType =   "SIP"
				Case 3: strFormFactorType =   "DIP"
				Case 4: strFormFactorType =   "ZIP"
				Case 5: strFormFactorType =   "SOJ"
				Case 6: strFormFactorType =   "Proprietary"
				Case 7: strFormFactorType =   "SIMM"
				Case 8: strFormFactorType =   "DIMM"
				Case 9: strFormFactorType =   "TSOP"
				Case 10: strFormFactorType =   "PGA"
				Case 11: strFormFactorType =   "RIMM"
				Case 12: strFormFactorType =   "SODIMM"
				Case 13: strFormFactorType =   "SRIMM"
				Case 14: strFormFactorType =   "SMD"
				Case 15: strFormFactorType =   "SSMP"
				Case 16: strFormFactorType =   "QFP"
				Case 17: strFormFactorType =   "TQFP"				
				Case 18: strFormFactorType =   "SOIC"
				Case 19: strFormFactorType =   "LCC"
				Case 20: strFormFactorType =   "PLCC"
				Case 21: strFormFactorType =   "BGA"
				Case 22: strFormFactorType =   "FPBGA"
				Case 23: strFormFactorType =   "LGA"	
			End Select
	    str = str & GetRow("Form Factor", strFormFactorType)
			Select Case objItem.MemoryType
				Case 0: strMemoryTypeType =   "Unknown"
				Case 1: strMemoryTypeType =   "Other"
				Case 2: strMemoryTypeType =   "DRAM"
				Case 3: strMemoryTypeType =   "Synchronous DRAM"
				Case 4: strMemoryTypeType =   "Cache DRAM"
				Case 5: strMemoryTypeType =   "EDO"
				Case 6: strMemoryTypeType =   "EDRAM"
				Case 7: strMemoryTypeType =   "VRAM"
				Case 8: strMemoryTypeType =   "SRAM"
				Case 9: strMemoryTypeType =   "RAM"
				Case 10: strMemoryTypeType =   "ROM"
				Case 11: strMemoryTypeType =   "Flash"
				Case 12: strMemoryTypeType =   "EEPROM"
				Case 13: strMemoryTypeType =   "FEPROM"
				Case 14: strMemoryTypeType =   "EPROM"
				Case 15: strAvailabilityType =   "CDRAM"
				Case 16: strAvailabilityType =   "3DRAM"
				Case 17: strAvailabilityType =   "SDRAM"				
				Case 18: strMemoryTypeType =   "SGRAM"
				Case 19: strAvailabilityType =   "RDRAM"
				Case 20: strAvailabilityType =   "DDR"
				Case 21: strAvailabilityType =   "DDR-2"		
			End Select		
	    str = str & GetRow("Memory Type", strMemoryTypeType)
	    str = str & GetRow("Name", objItem.Name)
	    str = str & GetRow("Position In Row", objItem.PositionInRow)
	    str = str & GetRow("Speed (Nsec )", objItem.Speed)	    
		Select Case objItem.MemoryType
				Case 1: strTypeDetailType =   "Reserved"
				Case 2: strTypeDetailType =   "Other"
				Case 4: strTypeDetailType =   "Unknown"
				Case 8: strTypeDetailType =   "Fast-paged"
				Case 16: strTypeDetailType =   "Static column"
				Case 32: strTypeDetailType =   "Pseudo-static"
				Case 64: strTypeDetailType =   "RAMBUS"
				Case 128: strTypeDetailType =   "Synchronous"
				Case 256: strTypeDetailType =   "CMOS"
				Case 512: strTypeDetailType =   "EDO"
				Case 1024: strTypeDetailType =   "Window DRAM"
				Case 2048: strTypeDetailType =   "Cache DRAM"
				Case 4096: strTypeDetailType =   "Nonvolatile"	
			End Select		
	    str = str & GetRow("Type Detail", strTypeDetailType)
		str = str & GetRow("Data Width", objItem.DataWidth)
	    str = str & GetTableFooter()
	Next
	
	Set colItems = objWMIService.ExecQuery("Select * from Win32_PhysicalMemoryArray")
	str = str & "<H2>Physical Memory Array Configuration</H2>" & vbCRLF
	For Each objItem in colItems
	    str = str & GetTableHeader()
		str = str & GetRow("Description", objItem.Description)
	    str = str & GetRow("Maximum Capacity", Int(objItem.MaxCapacity / 1024 ) & " MB")
	    str = str & GetRow("Memory Devices", objItem.MemoryDevices)
	    str = str & GetRow("Memory Error Correction", objItem.MemoryErrorCorrection)
	    str = str & GetTableFooter()
	Next
		
	DisplayOutput(str)
End Function

Function ShowSerialPortConfigurations()
	On Error Resume Next
	DisplayOutputHeader("Serial port configuration - Win32_SerialPortConfiguration")
	str = ""
	Set objWMIService = GetWMIServices()
	Set colItems = objWMIService.ExecQuery("Select * from Win32_SerialPortConfiguration")
	For Each objItem in colItems
	    str = str & GetTableHeader()
	    str = str & GetRow("Abort Read Write On Error", objItem.AbortReadWriteOnError)
	    str = str & GetRow("Baud Rate", objItem.BaudRate)
	    str = str & GetRow("Binary Mode Enabled", objItem.BinaryModeEnabled)
	    str = str & GetRow("Bits Per Byte", objItem.BitsPerByte)
	    str = str & GetRow("Continue XMit On XOff", objItem.ContinueXMitOnXOff)
	    str = str & GetRow("CTS Outflow Control", objItem.CTSOutflowControl)
	    str = str & GetRow("Discard NULL Bytes", objItem.DiscardNULLBytes)
	    str = str & GetRow("DSR Outflow Control", objItem.DSROutflowControl)
	    str = str & GetRow("DSR Sensitivity", objItem.DSRSensitivity)
	    str = str & GetRow("DTR Flow Control Type", objItem.DTRFlowControlType)
	    str = str & GetRow("EOF Character", objItem.EOFCharacter)
	    str = str & GetRow("Error Replace Character", objItem.ErrorReplaceCharacter)
	    str = str & GetRow("Error Replacement Enabled", objItem.ErrorReplacementEnabled)
	    str = str & GetRow("Event Character", objItem.EventCharacter)
	    str = str & GetRow("Is Busy", objItem.IsBusy)
	    str = str & GetRow("Name", objItem.Name)
	    str = str & GetRow("Parity", objItem.Parity)
	    str = str & GetRow("Parity Check Enabled", objItem.ParityCheckEnabled)
	    str = str & GetRow("RTS Flow Control Type", objItem.RTSFlowControlType)
	    str = str & GetRow("Setting ID", objItem.SettingID)
	    str = str & GetRow("Stop Bits", objItem.StopBits)
	    str = str & GetRow("XOff Character", objItem.XOffCharacter)
	    str = str & GetRow("XOff XMit Threshold", objItem.XOffXMitThreshold)
	    str = str & GetRow("XOn Character", objItem.XOnCharacter)
	    str = str & GetRow("XOn XMit Threshold", objItem.XOnXMitThreshold)
	    str = str & GetRow("XOn XOff InFlow Control", objItem.XOnXOffInFlowControl)
	    str = str & GetRow("XOn XOff OutFlow Control", objItem.XOnXOffOutFlowControl)
	    str = str & GetTableFooter()
	Next
	DisplayOutput(str)
End Function

Function ShowSerialPortInfo()
	On Error Resume Next
	DisplayOutputHeader("Serial\Parallel Ports")
	str = ""
	Set objWMIService = GetWMIServices()
	Set colItems = objWMIService.ExecQuery("Select * from Win32_SerialPort", , 48)
	str = str & "<H2>Serial Ports Information</H2>" & vbCRLF
	For Each objItem in colItems
	    str = str & GetTableHeader()
	    str = str & GetRow("Binary", objItem.Binary)
	    str = str & GetRow("Description", objItem.Description)
	    str = str & GetRow("Device ID", objItem.DeviceID)
	    str = str & GetRow("Maximum Baud Rate", objItem.MaxBaudRate)
	    str = str & GetRow("Maximum Input Buffer Size", objItem.MaximumInputBufferSize)
	    str = str & GetRow("Maximum Output Buffer Size", objItem.MaximumOutputBufferSize)
	    str = str & GetRow("Name", objItem.Name)
	    str = str & GetRow("OS Auto Discovered", objItem.OSAutoDiscovered)
	    str = str & GetRow("PNP Device ID", objItem.PNPDeviceID)
	    str = str & GetRow("Provider Type", objItem.ProviderType)
	    str = str & GetRow("Settable Flow Control", objItem.SettableFlowControl)
	    str = str & GetRow("Settable Parity", objItem.SettableParity)
	    str = str & GetTableFooter()
	Next
	
	Set colItems = objWMIService.ExecQuery("Select * from Win32_ParallelPort", , 48)
	str = str & "<H2>Parallel Ports Information</H2>" & vbCRLF
	For Each objItem in colItems
	    str = str & GetTableHeader()
	    str = str & GetRow("Availability", objItem.Availability)
	    For Each strCapability in objItem.Capabilities
	        str = str & GetRow("Capability", strCapability)
	    Next
	    str = str & GetRow("Description", objItem.Description)
	    str = str & GetRow("Device ID", objItem.DeviceID)
	    str = str & GetRow("Name", objItem.Name)
	    str = str & GetRow("OS Auto Discovered", objItem.OSAutoDiscovered)
	    str = str & GetRow("PNP Device ID", objItem.PNPDeviceID)
	    str = str & GetRow("Protocol Supported", objItem.ProtocolSupported)
	    str = str & GetTableFooter()
	Next
	
	DisplayOutput(str)
End Function

Function ShowSoundCardInfo()
	On Error Resume Next
	DisplayOutputHeader("Sound card - Win32_SoundDevice")
	str = ""
	Set objWMIService = GetWMIServices()
	Set colItems = objWMIService.ExecQuery("Select * from Win32_SoundDevice")
	For Each objItem in colItems
	    str = str & GetTableHeader()
	    str = str & GetRow("Description", objItem.Description)
	    str = str & GetRow("Device ID", objItem.DeviceID)
	    str = str & GetRow("DMA Buffer Size", objItem.DMABufferSize)
	    str = str & GetRow("Manufacturer", objItem.Manufacturer)
	    str = str & GetRow("MPU 401 Address", objItem.MPU401Address)
	    str = str & GetRow("Name", objItem.Name)
	    str = str & GetRow("PNP Device ID", objItem.PNPDeviceID)
	    str = str & GetRow("Product Name", objItem.ProductName)
	    str = str & GetRow("Status Information", objItem.StatusInfo)
	    str = str & GetTableFooter()
	Next
	DisplayOutput(str)
End Function

Function ShowSystemSlotInfo()
	On Error Resume Next
	DisplayOutputHeader("Baseboard\System Slot Information")
	str = ""
	Set objWMIService = GetWMIServices()
	Set colItems = objWMIService.ExecQuery("Select * from Win32_BaseBoard")
	str = str & "<H2>Baseboard Information</H2>" & vbCRLF
	For Each objItem in colItems
	    str = str & GetTableHeader()
	    'For Each strOption in objItem.ConfigOptions
	    '    str = str & GetRow("Configuration Option", strOption)
	    'Next
	    'str = str & GetRow("Depth", objItem.Depth)
	    str = str & GetRow("Description", objItem.Description)
	    'str = str & GetRow("Height", objItem.Height)
	    str = str & GetRow("Hosting Board", objItem.HostingBoard)
	    'str = str & GetRow("Hot Swappable", objItem.HotSwappable)
	    str = str & GetRow("Manufacturer", objItem.Manufacturer)
	    'str = str & GetRow("Model", objItem.Model)
	    str = str & GetRow("Name", objItem.Name)
	    'str = str & GetRow("Other Identifying Information", objItem.OtherIdentifyingInfo)
	    'str = str & GetRow("Part Number", objItem.PartNumber)
	    str = str & GetRow("Powered On", objItem.PoweredOn)
	    str = str & GetRow("Product", objItem.Product)
	    'str = str & GetRow("Removable", objItem.Removable)
	    'str = str & GetRow("Replaceable", objItem.Replaceable)
	    'str = str & GetRow("Requirements Description", objItem.RequirementsDescription)
	    'str = str & GetRow("Requires DaughterBoard", objItem.RequiresDaughterBoard)
	    str = str & GetRow("Serial Number", objItem.SerialNumber)
	    'str = str & GetRow("SKU", objItem.SKU)
	    str = str & GetRow("Slot Layout", objItem.SlotLayout)
	    'str = str & GetRow("Special Requirements", objItem.SpecialRequirements)
	    str = str & GetRow("Tag", objItem.Tag)
	    str = str & GetRow("Version", objItem.Version)
	    'str = str & GetRow("Weight", objItem.Weight)
	    'str = str & GetRow("Width", objItem.Width)
	    str = str & GetTableFooter()
	Next
	
	Set colItems = objWMIService.ExecQuery("Select * from Win32_SystemSlot",,48)
	str = str & "<H2>System Slot Information</H2>" & vbCRLF
	For Each objItem in colItems
	    str = str & GetTableHeader()
	    'For Each strConnectorPinout in objItem.ConnectorPinout
	    '    str = str & GetRow("Connector Pinout", strConnectorPinout)
	    'Next
		str = str & GetRow("Tag", objItem.Tag)
		Select Case objItem.CurrentUsage
			Case 0 strCurrentUsageType = "Reserved"
			Case 1 strCurrentUsageType = "Other"
			Case 2 strCurrentUsageType = "Unknown"
			Case 3 strCurrentUsageType = "Local hard disk."
			Case 4 strCurrentUsageType = "Available"
			Case 5 strCurrentUsageType = "In Use"
		End Select
	    str = str & GetRow("Current Usage", strCurrentUsageType)
		str = str & GetRow("Slot Designation", objItem.SlotDesignation)
	    str = str & GetRow("Description", objItem.Description)
	    'str = str & GetRow("Manufacturer", objItem.Manufacturer)    
	    str = str & GetRow("Number", objItem.Number)
	    str = str & GetRow("PME Signal", objItem.PMESignal)
	    str = str & GetRow("Shared", objItem.Shared)
	    Select Case objItem.MaxDataWidth
			Case 0 strMaxDataWidthType = "8"
			Case 1 strMaxDataWidthType = "16"
			Case 2 strMaxDataWidthType = "32"
			Case 3 strMaxDataWidthType = "64"
			Case 4 strMaxDataWidthType = "128"
		End Select
	    str = str & GetRow("Maximum Data Width", objItem.MaxDataWidth & " Bits")
	    str = str & GetRow("Supports Hot Plug", objItem.SupportsHotPlug)    
		str = str & GetRow("Status", objItem.Status)
	    'str = str & GetRow("Thermal Rating", objItem.ThermalRating)
	    'For Each strVccVoltageSupport in objItem.VccMixedVoltageSupport
	    '    str = str & GetRow("VCC Mixed Voltage Support", strVccVoltageSupport)
	    'Next
	    'str = str & GetRow("Version", objItem.Version)
	    'For Each strVppVoltageSupport in objItem.VppMixedVoltageSupport
	    '    str = str & GetRow("VPP Mixed Voltage Support", strVppVoltageSupport)
	    'Next
	    str = str & GetTableFooter()
	Next
	
	DisplayOutput(str)
End Function

Function ShowVideoControllerInfo()
	On Error Resume Next
	DisplayOutputHeader("Video controller - Win32_VideoController")
	str = ""
	Set objWMIService = GetWMIServices()
	Set colItems = objWMIService.ExecQuery("Select * from Win32_VideoController")
	For Each objItem in colItems
	    str = str & GetTableHeader()
	    For Each strCapability in objItem.AcceleratorCapabilities
	        str = str & GetRow("Accelerator Capability", strCapability)
	    Next
	    str = str & GetRow("Adapter Compatibility", objItem.AdapterCompatibility)
	    str = str & GetRow("Adapter DAC Type", objItem.AdapterDACType)
	    str = str & GetRow("Adapter RAM", objItem.AdapterRAM)
	    str = str & GetRow("Availability", objItem.Availability)
	    str = str & GetRow("Color Table Entries", objItem.ColorTableEntries)
	    str = str & GetRow("Current Bits Per Pixel", objItem.CurrentBitsPerPixel)
	    str = str & GetRow("Current Horizontal Resolution", objItem.CurrentHorizontalResolution)
	    str = str & GetRow("Current Number Of Colors", objItem.CurrentNumberOfColors)
	    str = str & GetRow("Current Number Of Columns", objItem.CurrentNumberOfColumns)
	    str = str & GetRow("Current Number Of Rows", objItem.CurrentNumberOfRows)
	    str = str & GetRow("Current Refresh Rate", objItem.CurrentRefreshRate)
	    str = str & GetRow("Current Scan Mode", objItem.CurrentScanMode)
	    str = str & GetRow("Current Vertical Resolution", objItem.CurrentVerticalResolution)
	    str = str & GetRow("Description", objItem.Description)
	    str = str & GetRow("Device ID", objItem.DeviceID)
	    str = str & GetRow("Device Specific Pens", objItem.DeviceSpecificPens)
	    str = str & GetRow("Dither Type", objItem.DitherType)
	    str = str & GetRow("Driver Date", WMIDateStringToDate(objItem.DriverDate))
	    str = str & GetRow("Driver Version", objItem.DriverVersion)
	    str = str & GetRow("ICM Intent", objItem.ICMIntent)
	    str = str & GetRow("ICM Method", objItem.ICMMethod)
	    str = str & GetRow("INF Filename", objItem.InfFilename)
	    str = str & GetRow("INF Section", objItem.InfSection)
	    str = str & GetRow("Installed Display Drivers", objItem.InstalledDisplayDrivers)
	    str = str & GetRow("Maximum Memory Supported", objItem.MaxMemorySupported)
	    str = str & GetRow("Maximum Number Controlled", objItem.MaxNumberControlled)
	    str = str & GetRow("Maximum Refresh Rate", objItem.MaxRefreshRate)
	    str = str & GetRow("Minimum Refresh Rate", objItem.MinRefreshRate)
	    str = str & GetRow("Monochrome", objItem.Monochrome)
	    str = str & GetRow("Name", objItem.Name)
	    str = str & GetRow("Number of Color Planes", objItem.NumberOfColorPlanes)
	    str = str & GetRow("Number of Video Pages", objItem.NumberOfVideoPages)
	    str = str & GetRow("PNP Device ID", objItem.PNPDeviceID)
	    str = str & GetRow("Reserved System Palette Entries", objItem.ReservedSystemPaletteEntries)
	    str = str & GetRow("Specification Version", objItem.SpecificationVersion)
	    str = str & GetRow("System Palette Entries", objItem.SystemPaletteEntries)
	    str = str & GetRow("Video Architecture", objItem.VideoArchitecture)
	    str = str & GetRow("Video Memory Type", objItem.VideoMemoryType)
	    str = str & GetRow("Video Mode", objItem.VideoMode)
	    str = str & GetRow("Video Mode Description", objItem.VideoModeDescription)
	    str = str & GetRow("Video Processor", objItem.VideoProcessor)
	    str = str & GetTableFooter()
	Next
	DisplayOutput(str)
End Function

Function ShowBatteryInfo()
	On Error Resume Next
	DisplayOutputHeader("Battery - Win32_Battery")
	str = ""
	Set objWMIService = GetWMIServices()
	Set colItems = objWMIService.ExecQuery("Select * from Win32_Battery")
	For Each objItem in colItems
	    str = str & GetTableHeader()
	    str = str & GetRow("Availability", objItem.Availability)
	    str = str & GetRow("Battery Status", objItem.BatteryStatus)
	    str = str & GetRow("Chemistry", objItem.Chemistry)
	    str = str & GetRow("Description", objItem.Description)
	    str = str & GetRow("Design Voltage", objItem.DesignVoltage)
	    str = str & GetRow("Device ID", objItem.DeviceID)
	    str = str & GetRow("Estimated Run Time", objItem.EstimatedRunTime)
	    str = str & GetRow("Name", objItem.Name)
	    For Each objElement In objItem.PowerManagementCapabilities
	        str = str & GetRow("Power Management Capabilities", objElement)
	    Next
	    str = str & GetRow("Power Management Supported", objItem.PowerManagementSupported)
	    str = str & GetTableFooter()
	Next
	DisplayOutput(str)
End Function

Function ShowBIOSInfo()
	On Error Resume Next
	DisplayOutputHeader("BIOS")
	str = ""
	Set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
	Set colBIOS = objWMIService.ExecQuery("Select * from Win32_BIOS")
	For each objBIOS in colBIOS
	    str = str & GetTableHeader()
	    str = str & GetRow("Current Language", objBIOS.CurrentLanguage)
	    str = str & GetRow("Installable Languages", objBIOS.InstallableLanguages)
	    str = str & GetRow("Manufacturer", objBIOS.Manufacturer)
	    str = str & GetRow("Name", objBIOS.Name)
		str = str & GetRow("Version", objBIOS.Version)
	    str = str & GetRow("Primary BIOS", objBIOS.PrimaryBIOS)
	    str = str & GetRow("Release Date", objBIOS.ReleaseDate)
	    str = str & GetRow("Serial Number", objBIOS.SerialNumber)
		str = str & GetRow("SMBIOS Present", objBIOS.SMBIOSPresent)
	    str = str & GetRow("SMBIOS Version", objBIOS.SMBIOSBIOSVersion)
	    str = str & GetRow("SMBIOS Major Version", objBIOS.SMBIOSMajorVersion)
	    str = str & GetRow("SMBIOS Minor Version", objBIOS.SMBIOSMinorVersion)
	    str = str & GetRow("Status", objBIOS.Status)	    
	    'For i = 0 to Ubound(objBIOS.BiosCharacteristics)
	    '    str = str & GetRow("BIOS Characteristics", objBIOS.BiosCharacteristics(i))
	    'Next
	    str = str & GetTableFooter()
	Next
	DisplayOutput(str)
End Function

Function ShowCacheMemoryInfo()
	On Error Resume Next
	DisplayOutputHeader("Cache Memory Information")
	str = ""
	Set objWMIService = GetWMIServices()
	Set colItems = objWMIService.ExecQuery("Select * from Win32_CacheMemory")
	For Each objItem in colItems
	    str = str & GetTableHeader()
	    'str = str & GetRow("Access", objItem.Access)
	    'For Each objElement In objItem.AdditionalErrorData
	    '   str = str & GetRow("Additional Error Data", objElement)
	    'Next
			Select Case objItem.Associativity
				Case 1: strAssociativityType =   "Other"
				Case 2: strAssociativityType =   "Unknown"
				Case 3: strAssociativityType =   "Direct Mapped"
				Case 4: strAssociativityType =   "2-way Set-Associative"
				Case 5: strAssociativityType =   "4-way Set-Associative"
				Case 6: strAssociativityType =   "Fully Associative"
				Case 7: strAssociativityType =   "Windows Server 2003 and Windows XP:  8-way Set-Associative"
				Case 8: strAssociativityType =   "Windows Server 2003 and Windows XP:  16-way Set-Associative"
			End Select
	    str = str & GetRow("Associativity", strAssociativityType)
			 Select Case objItem.Availability
				Case 1: strAvailabilityType =   "Other"
				Case 2: strAvailabilityType =   "Unknown"
				Case 3: strAvailabilityType =   "Running or Full Power"
				Case 4: strAvailabilityType =   "Warning"
				Case 5: strAvailabilityType =   "In Test"
				Case 6: strAvailabilityType =   "Not Applicable"
				Case 7: strAvailabilityType =   "Power Off"
				Case 8: strAvailabilityType =   "Off Line"
				Case 9: strAvailabilityType =   "Off Duty"
				Case 10: strAvailabilityType =   "Degraded"
				Case 11: strAvailabilityType =   "Not Installed"
				Case 12: strAvailabilityType =   "Install Error"
				Case 13: strAvailabilityType =   "Power Save - Unknown"
				Case 14: strAvailabilityType =   "Power Save - Low Power Mode"
				Case 15: strAvailabilityType =   "Power Save - Standby"
				Case 16: strAvailabilityType =   "Power Cycle"
				Case 17: strAvailabilityType =   "Power Save - Warning"				
			End Select		
	    str = str & GetRow("Availability", strAvailabilityType)
	    str = str & GetRow("Block Size", objItem.BlockSize & " Bytes")
			Select Case objItem.CacheType
				Case 1: strCacheTypeType =   "Other"
				Case 2: strCacheTypeType =   "Unknown"
				Case 3: strCacheTypeType =   "Instruction"
				Case 4: strCacheTypeType =   "Data"
				Case 5: strCacheTypeType =   "Unified"
			End Select	
	    str = str & GetRow("Cache Type", strCacheTypeType)
	    For Each objElement In objItem.CurrentSRAM
				Select Case objElement
					Case 0: strCurrentSRAMType =   "Other"
					Case 1: strCurrentSRAMType =   "Unknown"
					Case 2: strCurrentSRAMType =   "Non-Burst"
					Case 3: strCurrentSRAMType =   "Burst"
					Case 4: strCurrentSRAMType =   "Pipeline Burst"
					Case 5: strCurrentSRAMType =   "Synchronous"
					Case 6: strCurrentSRAMType =   "Asynchronous"
				End Select
	        str = str & GetRow("Current SRAM", strCurrentSRAMType)
	    Next
	    str = str & GetRow("Description", objItem.Description)
	    str = str & GetRow("Device ID", objItem.DeviceID)
			Select Case objItem.ConfigManagerErrorCode
				Case 0: strConfigManagerErrorCodeType =   "Device is working properly"
				Case 1: strConfigManagerErrorCodeType =   "Device is not configured correctly"
				Case 2: strConfigManagerErrorCodeType =   "Windows cannot load the driver for this device"
				Case 3: strConfigManagerErrorCodeType =   "Driver for this device might be corrupted, or the system may be low on memory or other resources"
				Case 4: strConfigManagerErrorCodeType =   "Device is not working properly. One of its drivers or the registry might be corrupted"
				Case 5: strConfigManagerErrorCodeType =   "Driver for the device requires a resource that Windows cannot manage"
				Case 6: strConfigManagerErrorCodeType =   "Boot configuration for the device conflicts with other devices"
				Case 7: strConfigManagerErrorCodeType =   "Cannot filter"
				Case 8: strConfigManagerErrorCodeType =   "Driver loader for the device is missing"
				Case 9: strConfigManagerErrorCodeType =   "Device is not working properly. The controlling firmware is incorrectly reporting the resources for the device."
				Case 10: strConfigManagerErrorCodeType =  "Device cannot start"
				Case 11: strConfigManagerErrorCodeType =  "Device failed"
				Case 12: strConfigManagerErrorCodeType =  "Device cannot find enough free resources to use"
				Case 13: strConfigManagerErrorCodeType =  "Windows cannot verify the device's resources"
				Case 14: strConfigManagerErrorCodeType =  "Device cannot work properly until the computer is restarted"
				Case 15: strConfigManagerErrorCodeType =  "Device is not working properly due to a possible re-enumeration problem"
				Case 16: strConfigManagerErrorCodeType =  "Windows cannot identify all of the resources that the device uses"
				Case 17: strConfigManagerErrorCodeType =  "Device is requesting an unknown resource type"
				Case 18: strConfigManagerErrorCodeType =  "Device drivers must be reinstalled"
				Case 19: strConfigManagerErrorCodeType =  "Failure using the VxD loader"
				Case 20: strConfigManagerErrorCodeType =  "Registry might be corrupted"
				Case 21: strConfigManagerErrorCodeType =  "System failure. If changing the device driver is ineffective, see the hardware documentation. Windows is removing the device"
				Case 22: strConfigManagerErrorCodeType =  "Device is disabled"
				Case 23: strConfigManagerErrorCodeType =  "System failure. If changing the device driver is ineffective, see the hardware documentation"
				Case 24: strConfigManagerErrorCodeType =  "Device is not present, not working properly, or does not have all of its drivers installed."
				Case 25: strConfigManagerErrorCodeType =  "Windows is still setting up the device"
				Case 26: strConfigManagerErrorCodeType =  "Windows is still setting up the device"
				Case 27: strConfigManagerErrorCodeType =  "Device does not have valid log configuration"
				Case 28: strConfigManagerErrorCodeType =  "Device drivers are not installeded"
				Case 29: strConfigManagerErrorCodeType =  "Device is disabled. The device firmware did not provide the required resources"
				Case 30: strConfigManagerErrorCodeType =  "Device is using an IRQ resource that another device is using"
				Case 31: strConfigManagerErrorCodeType =  "Device is not working properly. Windows cannot load the required device drivers"
			End Select		
			
	    str = str & GetRow("Config Manager Error Code", strConfigManagerErrorCodeType)
	    str = str & GetRow("Installed Size", objItem.InstalledSize & " Kilobytes")
			Select Case objItem.Level
					Case 1: strLevelType =   "Other"
					Case 2: strLevelType =   "Unknown"
					Case 3: strLevelType =   "Primary"
					Case 4: strLevelType =   "Secondary"
					Case 5: strLevelType =   "Tertiary"
					Case 6: strLevelType =   "Windows Server 2003 and Windows XP:  Not Applicable"
				End Select
	    str = str & GetRow("Level", strLevelType)
				Select Case objItem.Location
					Case 0: strLocationType =   "Internal"
					Case 1: strLocationType =   "External"
					Case 2: strLocationType =   "Reserved"
					Case 3: strLocationType =   "Unknown"
				End Select
	    str = str & GetRow("Location", strLocationType)
	    str = str & GetRow("Maximum Cache Size", objItem.MaxCacheSize & " Kilobytes")
	    str = str & GetRow("Name", objItem.Name)
				Select Case objItem.Location
					Case 0: strLocationType =   "Internal"
					Case 1: strLocationType =   "External"
					Case 2: strLocationType =   "Reserved"
					Case 3: strLocationType =   "Unknown"
					Case 3: strLocationType =   "Unknown"
				End Select
		str = str & GetRow("Location", strLocationType)
	    str = str & GetRow("Number Of Blocks", objItem.NumberOfBlocks)
				Select Case objItem.StatusInfo
					Case 1: strStatusInfoType =   "Other"
					Case 2: strStatusInfoType =   "Unknown"
					Case 3: strStatusInfoType =   "Enabled"
					Case 4: strStatusInfoType =   "Disabled"
					Case 5: strStatusInfoType =   "Not Applicable"
				End Select
	    str = str & GetRow("Status Information", strStatusInfoType)
	    For Each objElement In objItem.SupportedSRAM
	        str = str & GetRow("Supported SRAM", objElement)
	    Next
	    str = str & GetRow("WritePolicy", objItem.WritePolicy)
	    str = str & GetTableFooter()
	Next
	DisplayOutput(str)
End Function

Function ShowFanInfo()
	On Error Resume Next
	DisplayOutputHeader("Fan - Win32_Fan")
	str = ""
	Set objWMIService = GetWMIServices()
	Set colItems = objWMIService.ExecQuery("Select * from Win32_Fan")
	For Each objItem in colItems
	    str = str & GetTableHeader()
	    str = str & GetRow("Active Cooling", objItem.ActiveCooling)
	    str = str & GetRow("Availability", objItem.Availability)
	    str = str & GetRow("Device ID", objItem.DeviceID)
	    str = str & GetRow("Name", objItem.Name)
	    str = str & GetRow("Status Information", objItem.StatusInfo)
	    str = str & GetTableFooter()
	Next
	DisplayOutput(str)
End Function

Function ShowModemInfo()
	On Error Resume Next
	DisplayOutputHeader("Modem - Win32_POTSModem")
	str = ""
	Set objWMIService = GetWMIServices()
	Set colItems = objWMIService.ExecQuery("Select * from Win32_POTSModem")
	For Each objItem in colItems
	    str = str & GetTableHeader()
	    str = str & GetRow("Attached To", objItem.AttachedTo)
	    str = str & GetRow("Blind Off", objItem.BlindOff)
	    str = str & GetRow("Blind On", objItem.BlindOn)
	    str = str & GetRow("Compression Off", objItem.CompressionOff)
	    str = str & GetRow("Compression On", objItem.CompressionOn)
	    str = str & GetRow("Configuration Manager Error Code", objItem.ConfigManagerErrorCode)
	    str = str & GetRow("Configuration Manager User Configuration", objItem.ConfigManagerUserConfig)
	    str = str & GetRow("Configuration Dialog", objItem.ConfigurationDialog)
	    str = str & GetRow("Country Selected", objItem.CountrySelected)
	    For Each objElement In objItem.DCB
	        str = str & GetRow("DCB", objElement)
	    Next
	    For Each objElement In objItem.Default
	        str = str & GetRow("Default", objElement)
	    Next
	    str = str & GetRow("Device ID", objItem.DeviceID)
	    str = str & GetRow("Device Type", objItem.DeviceType)
	    str = str & GetRow("Driver Date", objItem.DriverDate)
	    str = str & GetRow("Error Control Forced", objItem.ErrorControlForced)
	    str = str & GetRow("Error Control Off", objItem.ErrorControlOff)
	    str = str & GetRow("Error Control On", objItem.ErrorControlOn)
	    str = str & GetRow("Flow Control Hard", objItem.FlowControlHard)
	    str = str & GetRow("Flow Control Off", objItem.FlowControlOff)
	    str = str & GetRow("Flow Control Soft", objItem.FlowControlSoft)
	    str = str & GetRow("Inactivity Scale", objItem.InactivityScale)
	    str = str & GetRow("Inactivity Timeout", objItem.InactivityTimeout)
	    str = str & GetRow("Index", objItem.Index)
	    str = str & GetRow("Maximum Baud Rate To SerialPort", objItem.MaxBaudRateToSerialPort)
	    str = str & GetRow("Model", objItem.Model)
	    str = str & GetRow("Modem Inf Path", objItem.ModemInfPath)
	    str = str & GetRow("Modem Inf Section", objItem.ModemInfSection)
	    str = str & GetRow("Modulation Bell", objItem.ModulationBell)
	    str = str & GetRow("Modulation CCITT", objItem.ModulationCCITT)
	    str = str & GetRow("Name", objItem.Name)
	    str = str & GetRow("PNP Device ID", objItem.PNPDeviceID)
	    str = str & GetRow("Port SubClass", objItem.PortSubClass)
	    str = str & GetRow("Prefix", objItem.Prefix)
	    For Each objElement In objItem.Properties
	        str = str & GetRow("Properties", objElement)
	    Next
	    str = str & GetRow("Provider Name", objItem.ProviderName)
	    str = str & GetRow("Pulse", objItem.Pulse)
	    str = str & GetRow("Reset", objItem.Reset)
	    str = str & GetRow("Responses Key Name", objItem.ResponsesKeyName)
	    str = str & GetRow("Speaker Mode Dial", objItem.SpeakerModeDial)
	    str = str & GetRow("Speaker Mode Off", objItem.SpeakerModeOff)
	    str = str & GetRow("Speaker Mode On", objItem.SpeakerModeOn)
	    str = str & GetRow("Speaker Mode Setup", objItem.SpeakerModeSetup)
	    str = str & GetRow("Speaker Volume High", objItem.SpeakerVolumeHigh)
	    str = str & GetRow("Speaker Volume Info", objItem.SpeakerVolumeInfo)
	    str = str & GetRow("Speaker Volume Low", objItem.SpeakerVolumeLow)
	    str = str & GetRow("Speaker Volume Med", objItem.SpeakerVolumeMed)
	    str = str & GetRow("Status Info", objItem.StatusInfo)
	    str = str & GetRow("Terminator", objItem.Terminator)
	    str = str & GetRow("Tone", objItem.Tone)
	    str = str & GetTableFooter()
	Next
	DisplayOutput(str)
End Function

Function ShowPCMCIAInfo()
	On Error Resume Next
	DisplayOutputHeader("PCMCIA controller - Win32_PCMCIAController")
	str = ""
	Set objWMIService = GetWMIServices()
	Set colItems = objWMIService.ExecQuery("Select * from Win32_PCMCIAController")
	For Each objItem in colItems
	    str = str & GetTableHeader()
	    str = str & GetRow("Configuration Manager Error Code", _
	        objItem.ConfigManagerErrorCode)
	    str = str & GetRow("Configuration Manager User Configuration", _
	        objItem.ConfigManagerUserConfig)
	    str = str & GetRow("Device ID", objItem.DeviceID)
	    str = str & GetRow("Manufacturer", objItem.Manufacturer)
	    str = str & GetRow("Name", objItem.Name)
	    str = str & GetRow("PNP Device ID", objItem.PNPDeviceID)
	    str = str & GetRow("Protocol Supported", objItem.ProtocolSupported)
	    str = str & GetTableFooter()
	Next
	DisplayOutput(str)
End Function

Function ShowNetworkInfo()
	On Error Resume Next
	DisplayOutputHeader("Network Information")
	str = ""
	Set objWMIService = GetWMIServices()
    Set IPConfigSet = objWMIService.ExecQuery _
    ("Select * from Win32_NetworkAdapterConfiguration Where IPEnabled=TRUE")

	str = str & "<H2>Network Details</H2>" & vbCRLF
	For Each IPConfig in IPConfigSet
		If Not IsNull(IPConfig.IPAddress) Then 
			For i=LBound(IPConfig.IPAddress) to UBound(IPConfig.IPAddress)
				str = str & GetTableHeader()
				str = str & GetRow("Networ kAdapter Type", IPConfigSetAdapter.NetworkAdapter)
				str = str & GetRow("Description", IPConfig.Description(i))
				str = str & GetRow("IP Adrress", IPConfig.IPAddress(i))
				str = str & GetRow("IP Subnet", IPConfig.IPSubnet(i))
				str = str & GetRow("MAC Address", IPConfig.MACAddress(i))
				str = str & GetRow("Default IP Gateway", IPConfig.DefaultIPGateway(i))
				str = str & GetRow("DNS Domain", IPConfig.DNSDomain(i))
				str = str & GetRow("DNS Hostname", IPConfig.DNSHostName(i))
				str = str & GetTableFooter()
			Next
		End If
	Next
	DisplayOutput(str)
End Function

Function ShowDiskUsage()
	On Error Resume Next
	DisplayOutputHeader("Disk Usage Information")
	str = ""
	Set objWMIService = GetWMIServices()
	Set colItems = objWMIService.ExecQuery _
		("Select * from Win32_LogicalDisk")

	str = str & "<H2>Logical Disk Usage</H2>" & vbCRLF
			For Each objItem in colItems
			Select Case objItem.DriveType
			Case 1 strDriveType = "Drive could not be determined."
			Case 2 strDriveType = "Removable Drive"
			Case 3 strDriveType = "Local hard disk."
			Case 4 strDriveType = "Network disk."
			Case 5 strDriveType = "Compact disk (CD)"
			Case 6 strDriveType = "RAM disk."
			Case Else strDriveType = "Drive type Problem."
			End Select

		If objItem.DriveType =2 Then
		strDiskSize = Int(objItem.Size /1048576) & " Mega Bytes"
		Else
		strDiskSize = Int(objItem.Size /1073741824) & " GB"
		End If
			str = str & GetTableHeader()
			str = str & GetRow("Drive Letter:", objItem.Name)
			str = str & GetRow("Volume Name:", objItem.VolumeName)
			str = str & GetRow("Drive Type :", strDriveType)
			str = str & GetRow("Disk Size :", strDiskSize)
			str = str & GetRow("Free Space :", Int(objItem.FreeSpace /1073741824) & " GB")
			str = str & GetTableFooter()
	Next
	DisplayOutput(str)	
End Function

Function WMIDateStringToDate(dtmBootup)
	WMIDateStringToDate = CDate(Mid(dtmBootup, 5, 2) & "/" & _
		Mid(dtmBootup, 7, 2) & "/" & Left(dtmBootup, 4) _
			& " " & Mid (dtmBootup, 9, 2) & ":" & _
				Mid(dtmBootup, 11, 2) & ":" & Mid(dtmBootup,13, 2))
End Function

Function ShowSystemInformation()
	On Error Resume Next
	DisplayOutputHeader("System Information")
	str = ""
	
	Set objWMIService = GetWMIServices()
	Set colSettings = objWMIService.ExecQuery("Select * from Win32_OperatingSystem")
	str = str & "<H2>Operating systems</H2>" & vbCRLF
	For Each objOperatingSystem in colSettings
	    dtmBootup = objOperatingSystem.LastBootUpTime
		dtmLastBootupTime = WMIDateStringToDate(dtmBootup)
		dtmSystemUptime = DateDiff("n", dtmLastBootUpTime, Now)				
	    str = str & GetTableHeader()
	    str = str & GetRow("OS Name", objOperatingSystem.Name)
	    str = str & GetRow("Version", objOperatingSystem.Version)
	    str = str & GetRow("Service Pack", _
	        objOperatingSystem.ServicePackMajorVersion & "." & objOperatingSystem.ServicePackMinorVersion)
	    str = str & GetRow("OS Manufacturer", objOperatingSystem.Manufacturer)
	    str = str & GetRow("Windows Directory", objOperatingSystem.WindowsDirectory)
	    str = str & GetRow("Locale", objOperatingSystem.Locale)
		str = str & GetRow("System Drive", objOperatingSystem.SystemDrive)
		str = str & GetRow("Total Physical Memory", Int(objOperatingSystem.TotalVisibleMemorySize /1024) & " MB")
		str = str & GetRow("Available Physical Memory", Int(objOperatingSystem.FreePhysicalMemory /1024) & " MB")
	    str = str & GetRow("Total Virtual Memory", Int(objOperatingSystem.TotalVirtualMemorySize /1024) & " MB")
	    str = str & GetRow("Available Virtual Memory", Int(objOperatingSystem.FreeVirtualMemory /1024) & " MB")
	    str = str & GetRow("OS Name", objOperatingSystem.Caption)
		str = str & GetRow("Last Boot Time", dtmLastBootupTime)
		str = str & GetRow("Time Since last boot", dtmSystemUptime & " Minutes")
	    str = str & GetTableFooter()
	Next
	
	Set colSettings = objWMIService.ExecQuery("Select * from Win32_ComputerSystem")
	str = str & "<H2>Computer systems</H2>" & vbCRLF
	For Each objComputer in colSettings
	    str = str & GetTableHeader()
	    str = str & GetRow("System Name", objComputer.Name)
			Select Case objComputer.DomainRole
				Case 0: strDomainRoleType =   "Standalone Workstation"
				Case 1: strDomainRoleType =   "Member Workstation"
				Case 2: strDomainRoleType =   "Standalone Server"
				Case 3: strDomainRoleType =   "Member Server"
				Case 4: strDomainRoleType =   "Backup Domain Controller"
				Case 5: strDomainRoleType =   "Primary Domain Controller"
			End Select
		str = str & GetRow("Domain Role", strDomainRoleType)
	    str = str & GetRow("System Manufacturer", objComputer.Manufacturer)
	    str = str & GetRow("System Model", objComputer.Model)
		str = str & GetRow("System Type", objComputer.SystemType)
	    str = str & GetRow("Current Time Zone  (Hours Offset From GMT)", Int(objComputer.CurrentTimeZone / 60 ) & " Hrs")
		str = str & GetRow("Domain", objComputer.Domain)
	    'str = str & GetRow("Total Physical Memory", Int(objComputer.TotalPhysicalMemory /1073741824) & " GB")
		str = str & GetRow("Number Of Processors", objComputer.NumberOfProcessors)
	    str = str & GetTableFooter()
	Next
	
	Set colSettings = objWMIService.ExecQuery("Select * from Win32_Processor")
	str = str & "<H2>Processors</H2>" & vbCRLF	
	For Each objProcessor in colSettings
	    str = str & GetTableHeader()	
			select Case objProcessor.Architecture
				Case 0: strArchType =   "x86"
				Case 1: strArchType =   "MIPS"
				Case 2: strArchType =   "Alpha"
				Case 3: strArchType =   "PowerPC"
				Case 4: strArchType =   "Intel Itanium Processor Family (IPF)"
				Case 5: strArchType =   "x64"
			End Select
	    str = str & GetRow("Architecture Type", strArchType)
		str = str & GetRow("Processor Name", objProcessor.Name) 
	    str = str & GetRow("Processor", objProcessor.Description)
	    str = str & GetTableFooter()
	Next
	
	Set colSettings = objWMIService.ExecQuery("Select * from Win32_BIOS")
	str = str & "<H2>BIOS</H2>" & vbCRLF
	For Each objBIOS in colSettings
	    str = str & GetTableHeader()
	    str = str & GetRow("BIOS Version", objBIOS.Version)
	    str = str & GetTableFooter()
	Next
	
	Set colItems = objWMIService.ExecQuery("Select * from Win32_DisplayConfiguration")
	str = str & "<H2>Display configuration</H2>" & vbCRLF
	For Each objItem in colItems
	    str = str & GetTableHeader()
	    str = str & GetRow("Bits Per Pel", objItem.BitsPerPel)
	    str = str & GetRow("Device Name", objItem.DeviceName)
	    str = str & GetRow("Display Frequency", objItem.DisplayFrequency)
	    str = str & GetRow("Driver Version", objItem.DriverVersion)
	    str = str & GetRow("Setting ID", objItem.SettingID)
	    str = str & GetRow("Specification Version", objItem.SpecificationVersion)
	    str = str & GetTableFooter()
	Next

	DisplayOutput(str)
End Function
