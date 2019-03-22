################################################  Powershell Support Form for Syncro  ##########################################################
#################################  Made with instsructional assistance from Dan Stolts "ITProGuru"  ############################################
### https://channel9.msdn.com/Series/GuruPowerShell/GUI-Form-Using-PowerShell-Add-Panel-Label-Edit-box-Combo-Box-List-Box-CheckBox-and-More  ###
################################################################################################################################################

################################################################################################################################################
#############  Currently, this only works if you save this script to the local machine as .ps1 (ex. C:\itfolder\support_form.ps1), #############
#############  make a .bat file with the same name, in the same folder (ex. C:\itfolder\support_form.bat), with this in            #############
#############  the .bat file [@echo off powershell.exe -Command "& '%~dpn0.ps1'"] (Keep the quotes,don't use the brackets)         #############
################################################################################################################################################

Add-Type -AssemblyName WindowsBase, PresentationFramework, PresentationCore
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

Import-Module $Env:SyncroModule -DisableNameChecking
$hostname = "$env:computername"
$date = (Get-Date)


######################  Enter Your Own Values below  ###########################


## Your Syncro sub-domain prefix
$subdomain = 'YOUR_SUBDOMAIN_HERE'

## Path to temporarily save your screenshot to
$screenShotPath = 'C:\temp\Screenshots'

## Title of your form
$formTitle = 'IT Support Request Form'

## Uses path to Syncro's default icon.  Change to point to your own icon
$Icon = [system.drawing.icon]::ExtractAssociatedIcon('C:\ProgramData\Syncro\Images\logo.ico')

## Alert Category if a user cancels a ticket
$cancelledTicket = 'Ticket Cancelled'


############## Automatically Grab User's First and Last Name ###################


$dom = $env:userdomain
$usr = $env:username
$currentUser = ([adsi]"WinNT://$dom/$usr,user").fullname


########################  Form Settings  ############################


$form = New-Object System.Windows.Forms.Form
$form.Icon = $Icon
$form.Text = "$formTitle"
$form.Size = New-Object System.Drawing.Size(475,475)
$form.StartPosition = 'CenterScreen'
$form.ControlBox = $False
$form.BackColor = 'Ivory'
$form.Font = [System.Drawing.Font]::new("Roboto", 10)


########################  Add Buttons  ##############################


$buttonPanel = New-Object Windows.Forms.Panel  
    $buttonPanel.Size = New-Object Drawing.Size @(350,40) 
    $buttonPanel.Dock = "Bottom"    
    $cancelButton = New-Object Windows.Forms.Button  
        $cancelButton.Top = $buttonPanel.Height - $cancelButton.Height - 10; $cancelButton.Left = $buttonPanel.Width - $cancelButton.Width - 10 
        $cancelButton.Text = "Cancel" 
        $cancelButton.DialogResult = "Cancel" 
        $cancelButton.Anchor = "Right" 
        $cancelButton.BackColor = "Pink"
        $cancelButton.ForeColor = "Red"

    ## Create the OK button, which will anchor to the left of Cancel 
    $okButton = New-Object Windows.Forms.Button   
        $okButton.Top = $cancelButton.Top ; $okButton.Left = $cancelButton.Left - $okButton.Width - 5 
        $okButton.Text = "Submit" 
        $okButton.DialogResult = "Ok" 
        $okButton.Anchor = "Right"
        $okButton.BackColor = "MintCream"
        $okButton.Enabled = $False
        # $okButton.Add_Click = ({ $x = $textSubject.Text; $form.Close() })


    ## Add the buttons to the button panel 
    $buttonPanel.Controls.Add($okButton) 
    $buttonPanel.Controls.Add($cancelButton) 

## Add the button panel to the form 
$form.Controls.Add($buttonPanel) 

## Set Default actions for the buttons 
$form.AcceptButton = $okButton          # ENTER = Ok 
$form.CancelButton = $cancelButton      # ESCAPE = Cancel


##############################  Labels  ##############################


$labelHost = New-Object System.Windows.Forms.Label
$labelHost.Location = New-Object System.Drawing.Point(10,20)
$labelHost.Size = New-Object System.Drawing.Size(90,20)
$labelHost.Text = 'Device'
$labelHost.Font = [System.Drawing.Font]::new("Roboto", 10, [System.Drawing.FontStyle]::Bold)
$form.Controls.Add($labelHost)

$labelSubject = New-Object System.Windows.Forms.Label
$labelSubject.Location = New-Object System.Drawing.Point(10,60)
$labelSubject.Size = New-Object System.Drawing.Size(90,20)
$labelSubject.Text = 'Subject'
$labelSubject.Font = [System.Drawing.Font]::new("Roboto", 10, [System.Drawing.FontStyle]::Bold)
$labelSubject.ForeColor = 'Red'
$form.Controls.Add($labelSubject)

$labelDesc = New-Object System.Windows.Forms.Label
$labelDesc.Location = New-Object System.Drawing.Point(10,100)
$labelDesc.Size = New-Object System.Drawing.Size(90,40)
$labelDesc.Text = 'Description'
$labelDesc.Font = [System.Drawing.Font]::new("Roboto", 10, [System.Drawing.FontStyle]::Bold)
$labelDesc.ForeColor = 'Red'
$form.Controls.Add($labelDesc)

$labelName = New-Object System.Windows.Forms.Label
$labelName.Location = New-Object System.Drawing.Point(10,200)
$labelName.Size = New-Object System.Drawing.Size(90,20)
$labelName.Text = 'Name'
$labelName.Font = [System.Drawing.Font]::new("Roboto", 10, [System.Drawing.FontStyle]::Bold)
$form.Controls.Add($labelName)

$labelEmail = New-Object System.Windows.Forms.Label
$labelEmail.Location = New-Object System.Drawing.Point(10,240)
$labelEmail.Size = New-Object System.Drawing.Size(90,40)
$labelEmail.Text = 'Email'
$labelEmail.Font = [System.Drawing.Font]::new("Roboto", 10, [System.Drawing.FontStyle]::Bold)
$form.Controls.Add($labelEmail)


########################  Input Fields  ########################


$textHost = New-Object System.Windows.Forms.TextBox
$textHost.Location = New-Object System.Drawing.Point(120,20)
$textHost.Size = New-Object System.Drawing.Size(120,20)
$textHost.ReadOnly = $True
$textHost.Text = "$Hostname"
$form.Controls.Add($textHost)

$textSubject = New-Object System.Windows.Forms.TextBox
$textSubject.Location = New-Object System.Drawing.Point(120,60)
$textSubject.Size = New-Object System.Drawing.Size(330,20)
$textSubject.MaxLength = 255
$form.Controls.Add($textSubject)

$textDesc = New-Object System.Windows.Forms.TextBox
$textDesc.Multiline = $True
$textDesc.WordWrap = $True
$textDesc.Location = New-Object System.Drawing.Point(120,100)
$textDesc.Size = New-Object System.Drawing.Size(330,80)
$textDesc.MaxLength = 1000
$textDesc.ScrollBars = 3
$form.Controls.Add($textDesc)

$textName = New-Object System.Windows.Forms.TextBox
$textName.Location = New-Object System.Drawing.Point(120,200)
$textName.Size = New-Object System.Drawing.Size(330,20)
$textName.Text = "$currentUser"
$form.Controls.Add($textName)

$textEmail = New-Object System.Windows.Forms.TextBox
$textEmail.Location = New-Object System.Drawing.Point(120,240)
$textEmail.Size = New-Object System.Drawing.Size(330,20)
$form.Controls.Add($textEmail)


##################  Form Field Validation  ######################


$textSubject.add_TextChanged -and $textDesc.add_TextChanged({ Checkfortext })

function Checkfortext
{
    if ($textSubject.Text.Length -ne 0 -and $textDesc.Text.Length -ne 0) 
	{
		$okButton.Enabled = $true
        $labelSubject.Text = 'Subject'
        $labelSubject.ForeColor = 'Black'
        $labelDesc.Text = 'Description'
        $labelDesc.ForeColor = 'Black'
	}
	else
	{
		$okButton.Enabled = $false
        $labelSubject.Text = 'Subject *'
        $labelSubject.ForeColor = 'Red'
        $labelDesc.Text = 'Description *'
        $labelDesc.ForeColor = 'Red'
	}
}

#################################################################

$form.Topmost = $true

$form.Add_Shown({$textSubject.Select()})

$result = $form.ShowDialog()

## Output text from entered fields
$subjectEntry = $textSubject.Text
$descEntry = $textDesc.Text
$nameEntry = $textName.Text
$emailEntry = $textEmail.Text

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
    {
        #####################  CURRENTLY ONLY ABLE TO UPLOAD TO ASSET.  #####################
        ########  UNCOMMENT 'Upload-File' TO ENABLE UPLOADING SCREENSHOT TO ASSET  ##########
        
        ## Take Screenshot
        Get-ScreenCapture -FullFileName "$screenShotPath\screenshot.jpg"
        #Upload-File -Subdomain "$subdomain" -FilePath "$screenShotPath\screenshot.jpg"

        ## Create ticket
        $ticketOutput = Create-Syncro-Ticket -Subdomain "$subdomain" -Subject "$subjectEntry - $emailEntry" -IssueType "Submission" -Status "New"

        ## Write the output of the ticket to console, assign it a varaible
        Write-Host $ticketOutput

        ## Grab ticket number from the output
        $ticketNumber = $ticketOutput.ticket.number

        ## Add a ticket comment
        Create-Syncro-Ticket-Comment -Subdomain "$subdomain" -TicketIdOrNumber $ticketNumber -Subject "Issue" -Body "Submitted by $nameEntry $emailEntry - $descEntry" -Hidden $False
        
        ## Delete screenshot
        Remove-Item "$screenShotPath\screenshot.jpg"
    }
else 
    {
        Write-Host $cancelledTicket

        ## Optionally write cancelled ticket event to Asset as Alert
        ## Uncomment next line to activate
        # Rmm-Alert -Category "$cancelledTicket" -Body "User $nameEntry $emailEntry Cancelled a Support Request"
    }
