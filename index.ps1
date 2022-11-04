Add-Type -AssemblyName PresentationFramework
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

function OlaYZen {
Clear-Host
write-host "                                           "
write-host "==========================================="
write-host "==========================================="
write-host "                                           "
write-host "YYYY             YYYYZZZZZZZZZZZZZZZZZZZZZ "
write-host " Y::Y           Y::::::::::::::::::::::::Z "
write-host "  Y::Y         Y::YYYZZZZZZZZZZZZZZZZZ:::Z "
write-host "   Y::Y       Y::Y                 Z:::Z   "
write-host "    Y:::Y   Y:::Y                 Z:::Z    "
write-host "     Y:::Y Y:::Y                 Z:::Z     "
write-host "      Y:::Y:::Y                 Z:::Z      "
write-host "       Y:::::Y                Z:::Z        "
write-host "        Y:::Y                Z:::Z         "
write-host "        Y:::Y               Z:::Z          "
write-host "        Y:::Y             Z:::Z            "
write-host "        Y:::Y            Z:::Z             "
write-host "        Y:::Y           Z:::Z              "
write-host "        Y:::Y         Z:::ZZZZZZZZZZZZZZZZ "
write-host "        Y:::Y        Z:::::::::::::::::::Z "
write-host "        YYYYY        ZZZZZZZZZZZZZZZZZZZZZ "
write-host "                                           "
write-host "==========================================="
write-host "==========================================="
write-host "                                           "
write-host "                                           "
write-host "============= made by OlaYZen ============="
write-host "                                           "
}














powershell.exe -WindowStyle Hidden -file > $null

#Invoke-WebRequest -Uri https://raw.githubusercontent.com/OlaYZen/PSXAML/main/MainWindow.xaml?token=GHSAT0AAAAAABZUKU5I2XAWPS2BI54QQXQUY3CMKVA -OutFile $PSScriptRoot"".\xamlui.xaml
#$xamlui = Import-Csv $PSScriptRoot"".\xamlui.xaml
#$xamlFile=$xamlui


#$inputXML="C:\Users\olai.boe\Documents\GitHub\PSXAML\MainWindow.xaml"
$inputXML = (new-object Net.WebClient).DownloadString("https://raw.githubusercontent.com/OlaYZen/PSXAML/main/MainWindow.xaml") #uncomment for Production

$inputXML = $inputXML -replace 'mc:Ignorable="d"', '' -replace "x:N", 'N' -replace '^<Win.*', '<Window'
[void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
[xml]$XAML = $inputXML
#Read XAML

$reader = (New-Object System.Xml.XmlNodeReader $xaml) 
try { $Form = [Windows.Markup.XamlReader]::Load( $reader ) }
catch [System.Management.Automation.MethodInvocationException] {
    Write-Warning "We ran into a problem with the XAML code.  Check the syntax for this control..."
    write-host $error[0].Exception.Message -ForegroundColor Red
    If ($error[0].Exception.Message -like "*button*") {
        write-warning "Ensure your &lt;button in the `$inputXML does NOT have a Click=ButtonClick property.  PS can't handle this`n`n`n`n"
    }
}
catch {
    Write-Host "Unable to load Windows.Markup.XamlReader. Double-check syntax and ensure .net is installed."
}

#===========================================================================
# Store Form Objects In PowerShell
#===========================================================================

$xaml.SelectNodes("//*[@Name]") | ForEach-Object { Set-Variable -Name "WPF$($_.Name)" -Value $Form.FindName($_.Name) }

function RemSearchwin10(){
    if ($WPFUnpin_Search.IsChecked)
        {
            Set-ItemProperty -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\" -Name "SearchboxTaskbarMode" -Value 0
            Stop-Process -n explorer
            c:\windows\explorer.exe
        }
    else
        {
            Set-ItemProperty -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\" -Name "SearchboxTaskbarMode" -Value 2
            Stop-Process -n explorer
            c:\windows\explorer.exe
        }
}

function RemTaskViewwin10(){
    if ($WPFUnpin_Task_View.IsChecked)
        {
            Set-ItemProperty -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\" -Name "ShowTaskViewButton" -Value 0
            Stop-Process -n explorer
            c:\windows\explorer.exe
        }
    else
        {
            Set-ItemProperty -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\" -Name "ShowTaskViewButton" -Value 1
            Stop-Process -n explorer
            c:\windows\explorer.exe
        }
}

function RemCortana(){
    if ($WPFUnpin_Cortana.IsChecked)
        {
            Set-ItemProperty -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCortanaButton" -Value 0
            Stop-Process -n explorer
            c:\windows\explorer.exe
        }
    else
        {
            Set-ItemProperty -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCortanaButton" -Value 1
            Stop-Process -n explorer
            c:\windows\explorer.exe
        }
}
function RemPeople(){
    if ($WPFUnpin_People.IsChecked)
        {
            Set-ItemProperty -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Value 0
            Stop-Process -n explorer
            c:\windows\explorer.exe
        }
    else
        {
            Set-ItemProperty -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Value 1
            Stop-Process -n explorer
            c:\windows\explorer.exe
        }
}

function RemInkWS(){
    if ($WPFUnpin_Ink_Workspace.IsChecked)
        {
            Set-ItemProperty -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PenWorkspace\" -Name "PenWorkspaceButtonDesiredVisibility" -Value 0
            Stop-Process -n explorer
            c:\windows\explorer.exe
        }
    else
        {
            Set-ItemProperty -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PenWorkspace\" -Name "PenWorkspaceButtonDesiredVisibility" -Value 1
            Stop-Process -n explorer
            c:\windows\explorer.exe
        }
}

function RemTouchKey(){
    if ($WPFUnpin_Touch_Keyboard.IsChecked)
        {
            Set-ItemProperty -path "HKCU:\SOFTWARE\Microsoft\TabletTip\1.7" -Name "TipbandDesiredVisibility" -Value 0
            Stop-Process -n explorer
            c:\windows\explorer.exe
        }
    else
        {
            Set-ItemProperty -path "HKCU:\SOFTWARE\Microsoft\TabletTip\1.7" -Name "TipbandDesiredVisibility" -Value 1
            Stop-Process -n explorer
            c:\windows\explorer.exe
        }
}
function Unpinabovewin10(){
    if ($WPFUnpin_All_Above.IsChecked)
        {
            $WPFUnpin_Search.IsChecked = $true
            $WPFUnpin_Task_View.IsChecked = $true
            $WPFUnpin_Cortana.IsChecked = $true
            $WPFUnpin_People.IsChecked = $true
            $WPFUnpin_Ink_Workspace.IsChecked = $true
            $WPFUnpin_Touch_Keyboard.IsChecked = $true

        }
    else
        {
            $WPFUnpin_Search.IsChecked = $false           
            $WPFUnpin_Task_View.IsChecked = $false
            $WPFUnpin_Cortana.IsChecked = $false
            $WPFUnpin_People.IsChecked = $false
            $WPFUnpin_Ink_Workspace.IsChecked = $false
            $WPFUnpin_Touch_Keyboard.IsChecked = $false

            Set-ItemProperty -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\" -Name "SearchboxTaskbarMode" -Value 2
            Set-ItemProperty -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\" -Name "ShowTaskViewButton" -Value 1
            Set-ItemProperty -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCortanaButton" -Value 1
            Set-ItemProperty -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Value 1
            Set-ItemProperty -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PenWorkspace\" -Name "PenWorkspaceButtonDesiredVisibility" -Value 1
            Set-ItemProperty -path "HKCU:\SOFTWARE\Microsoft\TabletTip\1.7" -Name "TipbandDesiredVisibility" -Value 1
            Stop-Process -n explorer
            c:\windows\explorer.exe
        }
}
function FileExt(){
    if ($WPFFileExtensions.IsChecked)
        {
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\" -Name "HideFileExt" -Value 0
            Stop-Process -n explorer
            c:\windows\explorer.exe
        }
    else
        {
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\" -Name "HideFileExt" -Value 1
            Stop-Process -n explorer
            c:\windows\explorer.exe
        }
}

function HiddenFiles(){
    if ($WPFHiddenFiles.IsChecked)
        {
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\" -Name "Hidden" -Value 1
            Stop-Process -n explorer
            c:\windows\explorer.exe
        }
    else
        {
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\" -Name "Hidden" -Value 2
            Stop-Process -n explorer
            c:\windows\explorer.exe
        }
}

function ICBbutton(){
    if ($WPFItemBoxes.IsChecked)
        {
            Set-ItemProperty -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "AutoCheckSelect" -Value 1
            Stop-Process -n explorer
            c:\windows\explorer.exe
        }
    else
        {
            Set-ItemProperty -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "AutoCheckSelect" -Value 0
            Stop-Process -n explorer
            c:\windows\explorer.exe
        }
}
function HideShell(){
    if ($WPFHideShell.IsChecked)
        {
            powershell.exe -WindowStyle Hidden -file > $null
        }
    else
        {
            powershell.exe -WindowStyle Normal -file > $null
        }
}

function RadButton1 {
    if ($RadioButton1.Checked)
        {
            Set-ItemProperty -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_Layout" -Value 0
            Stop-Process -n explorer
            c:\windows\explorer.exe
        }
}

function RadButton2 {
    if ($RadioButton2.Checked)
        {
            Set-ItemProperty -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_Layout" -Value 1
            Stop-Process -n explorer
            c:\windows\explorer.exe
        }
}
function RadButton3 {
    if ($RadioButton3.Checked)
        {
            Set-ItemProperty -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_Layout" -Value 2
            Stop-Process -n explorer
            c:\windows\explorer.exe
        }
}












$WPFUnpin_Search.Add_Checked{RemSearchwin10}
$WPFUnpin_Search.Add_UnChecked{RemSearchwin10}
$value6 = Get-ItemProperty -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\" -Name "SearchboxTaskbarMode"
if($value6.SearchboxTaskbarMode -eq 0)
{
    $WPFUnpin_Search.IsChecked = $true
}

$WPFUnpin_Task_View.Add_Checked({RemTaskViewwin10})
$WPFUnpin_Task_View.Add_UnChecked({RemTaskViewwin10})
$value7 = Get-ItemProperty -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\" -Name "ShowTaskViewButton"
if($value7.ShowTaskViewButton -eq 0)
{
    $WPFUnpin_Task_View.IsChecked = $true
}

$WPFUnpin_Cortana.Add_Checked({RemCortana})
$WPFUnpin_Cortana.Add_UnChecked({RemCortana})
$value8 = Get-ItemProperty -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\" -Name "ShowCortanaButton"
if($value8.ShowCortanaButton -eq 0)
{
    $WPFUnpin_Cortana.IsChecked = $true
}

$WPFUnpin_People.Add_Checked({RemPeople})
$WPFUnpin_People.Add_UnChecked({RemPeople})
$value9 = Get-ItemProperty -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand"
if($value9.PeopleBand -eq 0)
{
    $WPFUnpin_People.IsChecked = $true
}

$WPFUnpin_Ink_Workspace.Add_Checked({RemInkWS})
$WPFUnpin_Ink_Workspace.Add_UnChecked({RemInkWS})
$value10 = Get-ItemProperty -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PenWorkspace\" -Name "PenWorkspaceButtonDesiredVisibility"
if($value10.PenWorkspaceButtonDesiredVisibility -eq 0)
{
    $WPFUnpin_Ink_Workspace.IsChecked = $true
}

$WPFUnpin_Touch_Keyboard.Add_Checked({RemTouchKey})
$WPFUnpin_Touch_Keyboard.Add_UnChecked({RemTouchKey})
$value11 = Get-ItemProperty -path "HKCU:\SOFTWARE\Microsoft\TabletTip\1.7" -Name "TipbandDesiredVisibility"
if($value11.TipbandDesiredVisibility -eq 0)
{
    $WPFUnpin_Touch_Keyboard.IsChecked = $true
}

#========================================================
#   Unpin/pin all
#========================================================

$WPFUnpin_All_Above.Add_Checked({Unpinabovewin10})
$WPFUnpin_All_Above.Add_UnChecked({Unpinabovewin10})

if($value6.SearchboxTaskbarMode -eq 0)
{
    if($value7.ShowTaskViewButton -eq 0)
    {
        if($value8.ShowCortanaButton -eq 0)
        {
            if($value9.PeopleBand -eq 0)
            {
                if($value10.PenWorkspaceButtonDesiredVisibility -eq 0)
                {
                    if($value11.TipbandDesiredVisibility -eq 0)
                    {
                        $WPFUnpin_All_Above.IsChecked = $true
                    }
                }
            }
        }

    }
}
else {
    $WPFUnpin_All_Above.IsChecked = $false
}




Get-Variable WPFHiddenFiles



$WPFHiddenFiles.Add_Checked({HiddenFiles})
$WPFHiddenFiles.Add_UnChecked({HiddenFiles})
$value31 = Get-ItemProperty -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt"
if($value31.HideFileExt -eq 0)
{
    $WPFHiddenFiles.IsChecked = $true
}

$WPFFileExtensions.Add_Checked({FileExt})
$WPFFileExtensions.Add_UnChecked({FileExt})
$value32 = Get-ItemProperty -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden"
if($value32.Hidden -eq 1)
{
    $WPFFileExtensions.IsChecked = $true
}


$WPFItemBoxes.Add_Checked({ICBbutton})
$WPFItemBoxes.Add_UnChecked({ICBbutton})
$value17 = Get-ItemProperty -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "AutoCheckSelect"
if($value17.AutoCheckSelect -eq 1)
{
    $WPFItemBoxes.IsChecked = $true 
}



$value4 = Get-ItemProperty -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\" -Name "TaskbarDa"
if($value4.TaskbarDa -eq 0)
{
}











function Win10 {
    $WPFUnpin_Search.Visibility = "Visible"
    $WPFUnpin_Task_View.Visibility = "Visible"
    $WPFUnpin_Cortana.Visibility = "Visible"
    $WPFUnpin_People.Visibility = "Visible"
    $WPFUnpin_Ink_Workspace.Visibility = "Visible"
    $WPFUnpin_Touch_Keyboard.Visibility = "Visible"
    $WPFUnpin_All_Above.Visibility = "Visible"
    $WPFClockDisplay.Visibility = "Visible"
    $WPFOSLabel.Content = "Windows 10 Detected"
}

function Win11 {
    $WPFCompactView.Visibility = "Visible"
    $WPFLabel_22h2.Visibility = "Visible"
    $WPFOSLabel.Content = "Windows 11 Detected" 
}




#========================================================
#   Start Layout on 22H2 Windows 11
#========================================================

$groupBox = New-Object System.Windows.Forms.GroupBox
$groupBox.Location ='20,210'
$groupBox.size = '160,80'
$groupBox.Text = "Start Layout"
$Tab1.Controls.Add($groupBox)

$RadioButton1 = New-Object System.Windows.Forms.RadioButton
$RadioButton1.Location ='10,15'
$RadioButton1.size = '200,20'
$RadioButton1.Checked = $false
$RadioButton1.Text = "Default" 
$RadioButton1.Add_Click({RadButton1})
$groupBox.Controls.Add($RadioButton1)

$RadioButton2 = New-Object System.Windows.Forms.RadioButton
$RadioButton2.Location ='10,35'
$RadioButton2.size = '200,20'
$RadioButton2.Checked = $False
$RadioButton2.Text = "More Pins"
$RadioButton2.Add_Click({RadButton2})
$groupBox.Controls.Add($RadioButton2)

$RadioButton3= New-Object System.Windows.Forms.RadioButton
$RadioButton3.Location ='10,55'
$RadioButton3.size = '200,20'
$RadioButton3.Checked = $false
$RadioButton3.Text = "More Recommendations"
$RadioButton3.Add_Click({RadButton3})
$groupBox.Controls.Add($RadioButton3)

$value16 = Get-ItemProperty -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_Layout"
if($value16.Start_Layout -eq 0)
{
    $RadioButton1.Checked = $true 
}
elseif($value16.Start_Layout -eq 1)
{
    $RadioButton2.Checked = $true 
}
elseif($value16.Start_Layout -eq 2)
{
    $RadioButton3.Checked = $true 
}






#========================================================
#   Tab 4 Powershell Settings
#========================================================


$WPFHideShell.Add_Checked({HideShell})
$WPFHideShell.Add_UnChecked({HideShell})

#Disable Both win 10 and 11 stuff

$WPFUnpin_Search.Visibility = "Hidden"
$WPFUnpin_Task_View.Visibility = "Hidden"
$WPFUnpin_Cortana.Visibility = "Hidden"
$WPFUnpin_People.Visibility = "Hidden"
$WPFUnpin_Ink_Workspace.Visibility = "Hidden"
$WPFUnpin_Touch_Keyboard.Visibility = "Hidden"
$WPFUnpin_All_Above.Visibility = "Hidden"
$WPFClockDisplay.Visibility = "Hidden"
$WPFCompactView.Visibility = "Hidden"
$WPFLabel_22h2.Visibility = "Hidden"


if($value4.TaskbarDa -eq 0)
{Win11}
elseif($value4.TaskbarDa -eq 1)
{Win11}
elseif($value9.PeopleBand -eq 0)
{Win10}
elseif($value9.PeopleBand -eq 1)
{Win10}
elseif($value10.PenWorkspaceButtonDesiredVisibility -eq 0)
{Win10}
elseif($value10.PenWorkspaceButtonDesiredVisibility -eq 1)
{Win10}
elseif($value11.TipbandDesiredVisibility -eq 0)
{Win10}
elseif($value11.TipbandDesiredVisibility -eq 1)
{Win10}
else {
    $OSlabel.Text = "OS NOT DETECTED"
}




OlaYZen






$Form.ShowDialog()