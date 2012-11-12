@REM Copyright 2012 - Bruce Jackson (bruce@onlinemomentum.ca)
@REM
@REM This file is part of PunchClock-SetTime.
@REM 
@REM PunchClock-SetTime is free software: you can redistribute it and/or modify
@REM it under the terms of the GNU General Public License as published by
@REM the Free Software Foundation, either version 3 of the License, or
@REM (at your option) any later version.
@REM 
@REM PunchClock-SetTime is distributed in the hope that it will be useful,
@REM but WITHOUT ANY WARRANTY; without even the implied warranty of
@REM MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
@REM GNU General Public License for more details.
@REM 
@REM You should have received a copy of the GNU General Public License
@REM along with PunchClock-SetTime.  If not, see <http://www.gnu.org/licenses/>.
@REM
@REM PURPOSE:  
@REM This batch file opens a session to the punch clock and starts the script
@REM to reset the time.

@ECHO 
@ECHO ---------------------------------------------------------
@ECHO PunchClock-SetTime  
@ECHO Copyright (C) 2012  Bruce Jackson (bruce@onlinemomentum.ca)
@ECHO This program comes with ABSOLUTELY NO WARRANTY;
@ECHO This is free software, and you are welcome to redistribute 
@ECHO it under certain conditions, see LICENSE file for details.
@ECHO ---------------------------------------------------------

start telnet.exe 192.168.0.50 1001
cscript PunchClock-SetTime.vbs

start telnet.exe 192.168.0.51 1001
cscript PunchClock-SetTime.vbs