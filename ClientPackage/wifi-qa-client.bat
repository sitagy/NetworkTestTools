@echo off

ECHO Running WiFi QA Tests ...
set /P ipser=Enter the IP of the server :
ECHO -----------------------------------------------------------------------------------------
ECHO Checking RTT ...




ping %ipser% -n 3 -l 1470 > wifi-qa.txt

for /f "tokens=1 delims=" %%c in (' type wifi-qa.txt^|find /i "Approximate"') do echo %%c
for /f "tokens=1 delims=" %%d in (' type wifi-qa.txt^|find /i "Average"') do echo %%d

	



PAUSE
ECHO -----------------------------------------------------------------------------------------
ECHO Checking bandwidth ...

iperf3.exe -c %ipser% -p 7777 -t 60 >> wifi-qa.txt

iperf3.exe -c %ipser% -p 7777 -t 60 -u -b 16m >> wifi-qa.txt

for /f "tokens=1 delims=" %%a in (' type wifi-qa.txt^|find /i "sender"') do set list="%%a"

for /f "tokens=7" %%G IN (%list%) DO echo Uplink : %%G Mbits/sec
 
for /f "tokens=1 delims=" %%b in (' type wifi-qa.txt^|find /i "receiver"') do set listo="%%b"

for /f "tokens=7" %%H IN (%listo%) DO echo Downlink : %%H Mbits/sec



for /f "tokens=1,* delims=]" %%m in ('find /n /v "" ^< "wifi-qa.txt" ^| findstr "^\[202\]" ') do set variable="%%n"


for /f "tokens=12" %%k IN (%variable%) DO echo Packet Loss : %%k % for pushing 25 Mbps
ECHO -----------------------------------------------------------------------------------------
ECHO Tests ended. Close the server window. Log generated in the same location.

pause




