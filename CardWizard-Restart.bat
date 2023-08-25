::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: NOTE: This script must be executed using "Run as Admin."  
::
:: This script allows a technician to quickly check and restart the CardWizard service on multiple workstations without 
:: needing coordination with the end user.
::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

@echo off
color 70
SETLOCAL

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:Begin

echo.
SET /p ComputerName=Enter the name of the computer you'd like to restart the CardWizard service on:
goto :BeforeStatus
goto :Begin

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:BeforeStatus
cls

echo Current status of remote CardWizard service:
SC \\%ComputerName% query "DCG.LocalDeviceIntegrationService"
echo ======================================================================================
echo.

:RestartQuestion
Set /P q=Restart Service? (Y)es or (N)o?
	if /I "%q%" EQU "y" goto :RestartSequence
	if /I "%q%" EQU "n" goto :Begin
goto :RestartQuestion

:RestartSequence

:StopCW
:: Stop CardWizard Service
echo.
echo ======================================================================================
echo Stopping service...
SC \\%ComputerName% stop "DCG.LocalDeviceIntegrationService"
echo.
echo ======================================================================================
echo.
echo.

::Waiting between start and stop commands
ping -n 10 127.0.0.0 > nul


:StartCW
:: Start CardWizard Service
echo Restarting service...
SC \\%ComputerName% start "DCG.LocalDeviceIntegrationService"
echo.
echo ======================================================================================
echo.
echo.

echo Current status of remote CardWizard service:
SC \\%ComputerName% query "DCG.LocalDeviceIntegrationService"
echo.
echo ======================================================================================

echo.
Set /P q=Another Computer? (Y)es or (N)o?
	if /I "%q%" EQU "y" goto :Begin
	if /I "%q%" EQU "n" goto :END
goto :RestartQuestion

:END

echo.
echo Press any key to close this window.
PAUSE > NUL
