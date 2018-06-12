@echo off
ECHO Network test Server side


ECHO Network server started. Run Client batch file on client device



iperf3.exe -s -p 7777 > wifi-qa-server.txt

