# SyncroSupportForm

**_++Update, launching the ps1 file straight from the Syncro system tray CMD function now++_**

Powershell Support Form for SyncroMSP

Made with instsructional assistance from Dan Stolts "ITProGuru"
https://channel9.msdn.com/Series/GuruPowerShell/GUI-Form-Using-PowerShell-Add-Panel-Label-Edit-box-Combo-Box-List-Box-CheckBox-and-More

~~Currently, this only works if you save the .ps1 and .bat files to the local machine, in the same folder~~

~~Example:~~

~~`C:\itfolder\support_form.bat` and `C:\itfolder\support_form.ps1`~~

For ease of use, use the folder Syncro uses for scripts:

`C:\ProgramData\Syncro\live\scripts`

- Create a new "CMD" system tray menu item in your Syncro profile
- Give it a Menu Title of something, such as "New Support Ticket"
~~- In the CMD field, put this:  `powershell -File C:\ProgramData\Syncro\live\scripts\support_form.bat`~~
- In the CMD field, put this:  `powershell -File C:\ProgramData\Syncro\live\scripts\support_form.ps1`
