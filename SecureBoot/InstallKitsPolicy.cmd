@echo off
REM ********************************************************
REM                                                        *
REM    Copyright (C) Microsoft. All rights reserved.       *
REM                                                        *
REM ********************************************************
REM ********************************************************

manage-bde -protectors %systemdrive% -disable
mountvol S: /s 
copy /Y SecureBootDebug.efi s:\EFI\Microsoft\Boot\SecurebootDebug.efi

copy /Y Microsoft-Windows-Kits-Secure-Boot-Policy.p7b s:\SecureBootDebugPolicy.p7b

set var={9809d174-88ef-11e1-8346-00155de8c610}

bcdedit /create "%var%" /d "KitsPolicyTool" /application osloader 

bcdedit /set "%var%" path "\EFI\Microsoft\Boot\SecureBootDebug.efi"

bcdedit /set {bootmgr} bootsequence "%var%"

bcdedit /set "%var%" loadoptions Install

mountvol s: /s 

bcdedit /set "%var%" device partition=S: 

mountvol s: /d
@echo on
echo Rebooting the device in 30 sec
@echo off
shutdown /t 30 /r

