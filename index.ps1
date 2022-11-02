Add-Type -AssemblyName PresentationFramework

Invoke-WebRequest -Uri https://raw.githubusercontent.com/OlaYZen/PSXAML/main/MainWindow.xaml?token=GHSAT0AAAAAABZUKU5I2XAWPS2BI54QQXQUY3CMKVA -OutFile $PSScriptRoot"".\xamlui.xaml
$xamlui = Import-Csv $PSScriptRoot"".\xamlui.xaml




$xamlFile=$xamlui

$inputXAML=Get-Content -Path $xamlFile -Raw
$inputXAML=$inputXAML -replace 'mc:Ignorable="d"','' -replace "x:N","N" -replace '^<Win.*','<Window'
[XML]$XAML=$inputXAML

$reader = New-Object System.Xml.XmlNodeReader $XAML
try {
    $Form=[Windows.Markup.Xamlreader]::Load($reader)
}catch {
    Write-Host $_.Exception
    throw
}

$xaml.SelectNodes("//*[@Name]") | ForEach-Object {
    try {
        Set-Variable -Name "var_$($_.Name)" -Value $Form.FindName($_.Name) -ErrorAction stop
    }
    catch {
        throw
    }
}

Get-Variable var_*

$Form.ShowDialog()