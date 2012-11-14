' Copyright 2012 - Bruce Jackson
'
' This file is part of PunchClock-SetTime.
' 
' PunchClock-SetTime is free software: you can redistribute it and/or modify
' it under the terms of the GNU General Public License as published by
' the Free Software Foundation, either version 3 of the License, or
' (at your option) any later version.
' 
' PunchClock-SetTime is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
' GNU General Public License for more details.
' 
' You should have received a copy of the GNU General Public License
' along with PunchClock-SetTime.  If not, see <http://www.gnu.org/licenses/>.
'
' PURPOSE:  
' This VBScript interacts with ProxE Clock and sets the time



' setup some functions to format the time and date
' this gets around VBScript limit on date formating
Function punchClockFormatedTime(vCurrentDateTime) 
    punchClockFormatedTime = Right("00" & Hour(vCurrentDateTime), 2) _
    											 & Right("0" & Minute(vCurrentDateTime), 2) _
    											 & Right("0" & Second(vCurrentDateTime), 2)

End Function 

Function punchClockFormatedDate(vCurrentDateTime) 
   punchClockFormatedDate = Right(Year(vCurrentDateTime), 2) _
   												& Right("0" & Month(vCurrentDateTime), 2) _
   												& Right("0" & Day(vCurrentDateTime), 2)
End Function

' Convert day of week to the proper format for ProxE
' 0 = Sunday, 1 = Mon, 2 = Tue, 

Function punchClockDayOfWeek(vCurrentDateTime) 

	' datepart in VBScript 1=Sunday 7 = Sat, need to substract for timeclock
	' subtract 1 from VB day of week
	punchClockDayOfWeek = datepart("w", vCurrentDateTime, vbSunday) - 1
	
End Function


' shell script to set time on ProxE clock
set objTelnet = WScript.CreateObject("WScript.Shell")

' SET the current time and format for ProxE Clock (YYMMDD dayOfWeek HHMMSS)
' dayOfWeek approx sleep time adds the delays for telnet input to the time set to the 
' clock.  if timing is changed for local network conditions, this should be adjusted

currentDateTime = now()
approxSleepTime = 2
formattedDate = punchClockFormatedDate(currentDateTime)

' need to add padding again to the hour because of extra time added
formattedTime = Right("00" & (punchClockFormatedTime(currentDateTime) + approxSleepTime), 6)
dayOfWeek = punchClockDayOfWeek(currentDateTime)

' construct the string to pass in the settime command
' setup settime command
timeToPassToClock = formattedDate & " " & dayOfWeek & " " & formattedTime
settimeto = "SETTIME " &  timeToPassToClock
WScript.echo timeToPassToClock
			
' sent the commands, mirroring the commands captured 
' through packet sniffing
set objTelnet = WScript.CreateObject("WScript.Shell")
WScript.Sleep 1000
objTelnet.SendKeys "{ENTER}"
WScript.Sleep 100
objTelnet.SendKeys "{ENTER}"
WScript.Sleep 800
'objTelnet.SendKeys "IBOOT"
'WScript.Sleep 100
'objTelnet.SendKeys "{ENTER}"
'WScript.Sleep 100
objTelnet.SendKeys "CLOCK{ENTER}"
WScript.Sleep 100
objTelnet.SendKeys settimeto
WScript.Sleep 100
objTelnet.SendKeys "{ENTER}"
WScript.Sleep 100
objTelnet.SendKeys "BYE{ENTER}"
WScript.Sleep 100
objTelnet.SendKeys "QUIT{ENTER}"
WScript.Sleep 100

