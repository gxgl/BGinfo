@echo off
REM ==================================================
REM ==================================================
REM ==                                              ==
REM ==                  @08.09.2016                 ==
REM ==                                              ==
REM ==      Created by GxGL (George Stamate)        ==
REM ==                                              ==
REM ==    The contents of this file is free to use  ==
REM == and distribute.                              ==
REM ==    This script was created to help the user  ==
REM == to run or do multiple tasks from one sigle   == 
REM == click.                                       ==
REM ==    With this idea in mind comes more good!   ==
REM ==                                              ==
REM ==    As a note: You need to run this file as   ==
REM == administrator if you want to get all done.   ==
REM ==                                              ==
REM ==================================================
REM ================================================== 

setlocal
cd /d %~dp0
cls
echo[
echo Detecting if you run this script as admin...
REM We use an alternative PAUSE since this is not recognized on some windows versions
ping 127.0.0.1 -n 5 -w 1000 >nul

NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    ECHO Administrator PRIVILEGES Detected!
	ping 127.0.0.1 -n 5 -w 1000 >nul goto Admins
) ELSE (
    ECHO NOT AN ADMIN!? Appling settings for normal users...
	ping 127.0.0.1 -n 5 -w 1000 >nul && GOTO Users
)

:Admins
cls
echo[

IF NOT EXIST "C:\BGinfo" (GOTO COPY) ELSE (GOTO RUN)

:COPY
cls
echo[
:: Step1 - Creating directories and copy needed files
mkdir C:\BGinfo
copy *.* C:\BGinfo
:: Step2 - Adding EULA acceptance to the registry and run the BGinfo for first time
REG ADD HKU\.DEFAULT\Software\Sysinternals\BGInfo /v EulaAccepted /t REG_DWORD /d 1 /f
C:\BGinfo\bginfo.exe C:\BGinfo\bginfo.bgi /nolicprompt /timer:0
:: Step3 - Check if there was an installation of this script
IF EXIST "C:\Windows\System32\Tasks\Utils" echo[
for /f %%x in ('schtasks /query ^| findstr BGinfo') do schtasks /Delete /TN \Utils\%%x /F
:: Step4 - Adding the schedule task for the current user
:: It is known bug of BGinfo tool that cannot run as a SYSTEM and apply to all users
:: We need separate task for users.
schtasks.exe /create /tn \Utils\BGinfo_%USERNAME% /tr "C:\BGinfo\bginfo.exe C:\BGinfo\bginfo.bgi /nolicprompt /timer:0" /SC MINUTE /MO 5 /F
:: Step5 - Adding registry startup command which apply system wide
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v BGinfo /t REG_SZ /d "C:\BGinfo\bginfo.bat" /f
ping 127.0.0.1 -n 5 -w 1000 >nul
GOTO END

:RUN
cls
:: This part consist in re-creating the scheduled task at user logon
:: I consider this as a workarround for runnig BGinfo as a task
::-==================================================================
:: Step1 - Check if there exist the task and delete it...
IF EXIST "C:\Windows\System32\Tasks\Utils" echo[
for /f %%x in ('schtasks /query ^| findstr BGinfo') do schtasks /Delete /TN \Utils\%%x /F
:: Step2 - Re-creating the task for the current user
schtasks.exe /create /tn \Utils\BGinfo_%USERNAME% /tr "C:\BGinfo\bginfo.exe C:\BGinfo\bginfo.bgi /nolicprompt /timer:0" /SC MINUTE /MO 5 /F
ping 127.0.0.1 -n 5 -w 1000 >nul
GOTO END

:Users
cls
echo[
:: If this script runs under a normal user, we suppose that all the files are in place
:: so only thing that we need to do is to create a task per username - this is very usefull in a domain.
IF EXIST "C:\Windows\System32\Tasks\Utils" echo[
for /f %%x in ('schtasks /query ^| findstr BGinfo') do schtasks /Delete /TN \Utils\%%x /F
schtasks.exe /create /tn \Utils\BGinfo_%USERNAME% /tr "C:\BGinfo\bginfo.exe C:\BGinfo\bginfo.bgi /nolicprompt /timer:0" /SC MINUTE /MO 5 /F
GOTO END

:END
exit