@echo off
REM ********************************************************
REM                                                        *
REM    Copyright (C) Microsoft. All rights reserved.       *
REM                                                        *
REM ********************************************************
REM ********************************************************

manage-bde -protectors %systemdrive% -disable
mountvol S: /s >>install.log 2>&1
copy /Y SecureBootDebug.efi s:\EFI\Microsoft\Boot\SecurebootDebug.efi

set var={9809d174-88ef-11e1-8346-00155de8c610}

bcdedit /create "%var%" /d "KitsPolicyTool" /application osloader

bcdedit /set "%var%" path "\EFI\Microsoft\Boot\SecureBootDebug.efi" 

bcdedit /set {bootmgr} bootsequence "%var%" 

bcdedit /set "%var%" loadoptions delete 

mountvol s: /s 

bcdedit /set "%var%" device partition=S:

mountvol s: /d

@echo on
echo Rebooting the device in 30 sec
@echo off

shutdown /t 30 /r

