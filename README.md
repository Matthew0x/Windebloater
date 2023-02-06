# This repository is synced

## Windebloat

Tired of candy crush in your menu?
You can use this PowerShell ISE script, it's work in progress.
It's pretty useful for purging new Virtual Machines of garbage in the start menu etc.

I have been planning on creating some kind of PoC of PowerShell debloating script.
This specific script could have been just a simple PS script, but I wanted to try my chances at creating a very simple PS GUI.
That's it. It took me 5 hours and 2 years of procrastination.

## What does it do?
It's basically a kind of an array with names of packages that hide in the OS. It could be Candy Crush, Skype Pro 20000, Calculator Super Extreme, or the 10th edition of Xbox Live.

You may add the packages you want into the **list.txt**, then just run the script and remove them through PowerShell. Comment out the ones which shouldn't be removed.

## TBD
Adding a non-GUI version. I had one lying around, but I will rework it and attach it later.

## Guide

1. Open PowerShell ISE in administrator mode, paste the code, select all, run the code.
2. ~~Save the script code with .PS extension and run the script as PowerShell script with admin rights~~.
   1. This would work, but I need to implement interpret recognition conditionals. PowerShell ISE can't use the same path variables as normal PowerShell it seems.

    **PS: By default PowerShell execution policy is disabled**

    Try to change it with: 

    **`Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope LocalMachine`**

    **`Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser`**

    _It's advised to restrict the execution policy after finishing your job._
    _For more info visit: https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy?view=powershell-7.2_

## Getting the list of installed Windows Store packages manually

**`Get-AppxPackage -AllUsers | Select Name`**

**_Selects packages <by name> from locally <user account> installed packages_**

**`Get-AppXProvisionedPackage -Online | Select DisplayName`**

**_Selects packages <by name> from packages provisioned for new user accounts._**

_When creating new user profile Windows copies installed app packages into new user accounts_

<the OS>

```mermaid
graph LR

a[Get-AppxPackage -AllUsers]-->b
b[Learn the list of installed bloatware packages]-->c
c[Add new package names to the list]-->d
d[Enjoy bloatware free experience]
```
