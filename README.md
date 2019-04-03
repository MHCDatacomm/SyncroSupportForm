# SyncroSupportForm

**Powershell Support Form for SyncroMSP**
Launches a form on the user's desktop, from the Syncro sys tray right-click menu. (screenshot here https://prnt.sc/n6xzm7)

Made with instsructional assistance mostly from Dan Stolts "ITProGuru"
https://channel9.msdn.com/Series/GuruPowerShell/GUI-Form-Using-PowerShell-Add-Panel-Label-Edit-box-Combo-Box-List-Box-CheckBox-and-More

This script must exist on each end-user's desktop.  I've set it to automatically be located in Syncro's default script path: `C:\ProgramData\Syncro\live\scripts`

The script will automatically do the following:
- Pulls in the logged-in user's frist and last name, and populates it in the "Name" field
- Makes the "Subject" and "Description" fields *required*
- Takes a screenshot and posts to the ASSET, formated as `screenshot_ticket#_time/date.jpg` (posting to a Ticket isn't supported in the SyncroModule...yet)
- Deletes screenshot once form is submitted
- Creates a RMM Alert labeled "User {first and last name} Cancelled a Support Request" if the form is opened then cancelled by a user

**How-To**
- Create new "CMD" menu item under Device System Tray Menu in your Policy
- Give it a title (I used 'New Support Ticket')
- *Option 1 - Automated* - Insert this into the CMD line, replacing YOUR_DOMAIN_HERE with your own Syncro subdomain: `powershell -command "Set-Variable -Name "subdomain" -Value "YOUR_DOMAIN_HERE"; (New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/MHCDatacomm/SyncroSupportForm/master/support_form.ps1','C:\ProgramData\Syncro\live\scripts\support_form.ps1');C:\ProgramData\Syncro\live\scripts\support_form.ps1"`
-- This will automatically download the script from this repo each time the menu open is clicked.  You can also replace the URL with one of your own if you'd like to host the script on your own server or repo.
- Option 2 - Manual - Copy this script into the `C:\ProgramData\Syncro\live\scripts` folder, then insert this into the CMD line of the system tray menu option: `powershell -command "Set-Variable -Name "subdomain" -Value "YOUR_DOMAIN_HERE";C:\ProgramData\Syncro\live\scripts\support_form.ps1"'

**Future Plans**
- Make "Take Screenshot" and "Upload File" buttons, so the user has a choice
- List user's current open tickets and ticket status under the "Email" field
