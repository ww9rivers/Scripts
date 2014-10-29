:: Created by: Shawn Brink
:: http://www.sevenforums.com
:: Tutorial: http://www.sevenforums.com/tutorials/91738-windows-update-reset.html
::
:: 2014-10-29 Updated by: Wei Wang
:: http://www.reddit.com/r/usefulscripts/comments/2e5kte/batch_reset_windows_update/


net stop bits
net stop wuauserv
Del "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\qmgr*.dat"

Rmdir "%Windir%\SoftwareDistribution\Download" /s /q 
Rmdir "%systemroot%\SoftwareDistribution\DataStore" /s /q 
Rmdir "%systemroot%\system32\catroot2" /s /q
::: Windows XP & 2003 - Delete %systemroot%\SoftwareDistribution\ as well
ver | findstr /i "5\.1\." > nul
IF %ERRORLEVEL% EQU 0 goto XP_OR_2003
ver | findstr /i "5\.2\." > nul
IF %ERRORLEVEL% EQU 0 goto XP_OR_2003
GOTO CONTINUE
:XP_OR_2003
Rmdir "%Windir%\SoftwareDistribution" /s /q 
:CONTINUE

sc.exe sdset bits D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)
sc.exe sdset wuauserv D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)

cd /d %windir%\system32
regsvr32.exe /s atl.dll
regsvr32.exe /s urlmon.dll
regsvr32.exe /s mshtml.dll
regsvr32.exe /s shdocvw.dll
regsvr32.exe /s browseui.dll
regsvr32.exe /s jscript.dll
regsvr32.exe /s vbscript.dll
regsvr32.exe /s scrrun.dll
regsvr32.exe /s msxml.dll
regsvr32.exe /s msxml3.dll
regsvr32.exe /s msxml6.dll
regsvr32.exe /s actxprxy.dll
regsvr32.exe /s softpub.dll
regsvr32.exe /s wintrust.dll
regsvr32.exe /s dssenh.dll
regsvr32.exe /s rsaenh.dll
regsvr32.exe /s gpkcsp.dll
regsvr32.exe /s sccbase.dll
regsvr32.exe /s slbcsp.dll
regsvr32.exe /s cryptdlg.dll
regsvr32.exe /s oleaut32.dll
regsvr32.exe /s ole32.dll
regsvr32.exe /s shell32.dll
regsvr32.exe /s initpki.dll
regsvr32.exe /s wuapi.dll
regsvr32.exe /s wuaueng.dll
regsvr32.exe /s wuaueng1.dll
regsvr32.exe /s wucltui.dll
regsvr32.exe /s wups.dll
regsvr32.exe /s wups2.dll
regsvr32.exe /s wuweb.dll
regsvr32.exe /s qmgr.dll
regsvr32.exe /s qmgrprxy.dll
regsvr32.exe /s wucltux.dll
regsvr32.exe /s muweb.dll
regsvr32.exe /s wuwebv.dll
regsvr32 /s wudriver.dll
netsh winsock reset
net start bits
net start wuauserv
bitsadmin.exe /reset /allusers
wuauclt /resetauthorization /detectnow
shutdown /r
