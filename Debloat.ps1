#================================================================

# Development

#================================================================
#$aboutLabel.Dock = "Top"
#$aboutLabel.Location  = New-Object System.Drawing.Point(20,20)
#$aboutLabel.Margin = New-Object System.Windows.Forms.Padding(10,10,10,10)
#Write-Output($aboutLabel.Margin)
#$aboutLabel.AutoSize = $true
#$printButton1.SetStyle(System.Windows.Forms.ControlStyles.Selectable, $False)
#Write-Output($mainWindow.Width, $aboutLabel.Width, $aboutLabel.Margin.Left, $aboutLabel.Margin.Right, $aboutLabel.Margin.Horizontal)

# Code theft section /s
#https://stackoverflow.com/questions/61429550/powershell-windows-form-border-color-controls

#================================================================

# START

#================================================================

# primary logic
$psISE.CurrentFile.FullPath
#$PSCommandPath
#$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
$scriptPath = split-path -parent $psISE.CurrentFile.FullPath
$appsFile = Get-Content "$scriptPath\list.txt"
$appsList = @($appsFile)

function debloat() {
    foreach ($app in $appsList) {    
        try {
            Get-AppxPackage -Name $app | Remove-AppxPackage -AllUsers
            Get-AppXProvisionedPackage -Online | where DisplayName -EQ $app | Remove-AppxProvisionedPackage -Online

            $appPath = "$Env:LOCALAPPDATA\Packages\$app*"
            Remove-Item $appPath -Recurse -Force -ErrorAction 0
        }
        catch {}
        finally { Write-Host "Removing $app" -ForegroundColor Green }
    }
    Write-Host "Finished!" -ForegroundColor Yellow
}

#================================================================

# mainWindow
Add-Type -assembly System.Windows.Forms
$mainWindow = New-Object System.Windows.Forms.Form
$mainWindow.Text = "Windebloater"
$mainWindow.Width = 400
$mainWindow.Height = 600
$mainWindow.BackColor = "#6a9fd5"
$mainWindow.StartPosition = 'CenterScreen'
$mainWindow.KeyPreview = $True

#================================================================

# GUI variables
$elementHeight = 60
$elementMargin = 30
$backColor = "#eeeeee"
$focusColor = "#edd6bf"
$largeFont = "Verdana, 16"
$normalfont = "Verdana, 12"

#================================================================

# GUI components
$aboutLabel = New-Object System.Windows.Forms.Label
$printButton1 = New-Object System.Windows.Forms.Button
$printButton2 = New-Object System.Windows.Forms.Button
$debloatButton = New-Object System.Windows.Forms.Button

#================================================================

# aboutLabel
$aboutLabel.Anchor = "Top"
$aboutLabel.BackColor = $backColor
$aboutLabel.Location = New-Object System.Drawing.Point(0, $($elementHeight * 0 + $elementMargin))
$aboutLabel.Width = $mainWindow.Width
$aboutLabel.Height = $elementHeight
$aboutLabel.TextAlign = "MiddleCenter"
$aboutLabel.Font = $largefont
$aboutLabel.Text = "Commands"

#================================================================

# printButton1
$printButton1.Anchor = "Top"
$printButton1.BackColor = $backColor
$printButton1.TabIndex = 0
$printButton1.Add_GotFocus({ $printButton1.BackColor = $focusColor } )
$printButton1.Add_LostFocus( { $printButton1.BackColor = $backColor } )
$printButton1.Width = $mainWindow.Width * 3 / 4
$printButton1.Height = $elementHeight
$printButton1.Location = New-Object System.Drawing.Point($(($mainWindow.Width - $printButton1.Width) / 2), $($elementHeight * 1 + $elementMargin * 2))
$printButton1.Font = $normalfont
$printButton1.Text = "Show user profile installed bloatware"
$printButton1Click = {
    Write-Host "`nWriting packages..." -ForegroundColor Yellow
    Get-AppxPackage -AllUsers | Select Name | Write-Host
}
$printButton1.Add_Click($printButton1Click)

#================================================================

# printButton2
$printButton2.Anchor = "Top"
$printButton2.BackColor = $backColor
$printButton2.TabIndex = 0
$printButton2.Add_GotFocus({ $printButton2.BackColor = $focusColor } )
$printButton2.Add_LostFocus( { $printButton2.BackColor = $backColor } )
$printButton2.Width = $mainWindow.Width * 3 / 4
$printButton2.Height = $elementHeight
$printButton2.Location = New-Object System.Drawing.Point($(($mainWindow.Width - $printButton2.Width) / 2), $($elementHeight * 2 + $elementMargin * 3))
$printButton2.Font = $normalfont
$printButton2.Text = "Show bloatware provisioned to install"
$printButton2Click = { 
    Write-Host "`nWriting packages..." -ForegroundColor Yellow
    Get-AppXProvisionedPackage -Online | Select DisplayName | Write-Host
}
$printButton2.Add_Click($printButton2Click)

#================================================================

# debloatButton
$debloatButton.Anchor = "Top"
$debloatButton.BackColor = $backColor
$debloatButton.TabIndex = 0
$debloatButton.Add_GotFocus({ $debloatButton.BackColor = $focusColor } )
$debloatButton.Add_LostFocus( { $debloatButton.BackColor = $backColor } )
$debloatButton.Width = $mainWindow.Width * 3 / 4
$debloatButton.Height = $elementHeight
$debloatButton.Location = New-Object System.Drawing.Point($(($mainWindow.Width - $debloatButton.Width) / 2), $($elementHeight * 3 + $elementMargin * 4))
$debloatButton.Font = $largefont
$debloatButton.Text = "DEBLOAT"
$debloatButton.Add_Click({ debloat })

#================================================================

# mainWindow config
$mainWindow.Controls.Add($aboutLabel)
$mainWindow.Controls.Add($printButton1)
$mainWindow.Controls.Add($printButton2)
$mainWindow.Controls.Add($printButton2)
$mainWindow.Controls.Add($debloatButton)
$mainWindow.ShowDialog()
#$mainWindow.Controls.AddRange(@($aboutLabel, $printButton1, $printButton2))

#================================================================

# END

#================================================================