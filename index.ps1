Add-Type -AssemblyName PresentationFramework

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


function RemSearchwin10Checked(){

            Set-ItemProperty -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\" -Name "SearchboxTaskbarMode" -Value 0
            Stop-Process -n explorer
            c:\windows\explorer.exe

}
function RemSearchwin10UnChecked(){
            Set-ItemProperty -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\" -Name "SearchboxTaskbarMode" -Value 2
            Stop-Process -n explorer
            c:\windows\explorer.exe
}



#========================================================
#   checkbox12 hides Search in win 10
#========================================================

$WPFUnpin_Search.Add_Checked{RemSearchwin10Checked}
$WPFUnpin_Search.Add_UnChecked{RemSearchwin10UnChecked}

$value1 = Get-ItemProperty -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\" -Name "SearchboxTaskbarMode"
if($value1.SearchboxTaskbarMode -eq 0)
{
    $WPFUnpin_Search.Checked = $true
}



$Form.ShowDialog()