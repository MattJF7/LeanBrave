[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell -ArgumentList "-File `"$($MyInvocation.MyCommand.Path)`"" -Verb RunAs
    exit
}

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$registryPath = "HKLM:\SOFTWARE\Policies\BraveSoftware\Brave"
if (-not (Test-Path -Path $registryPath)) { New-Item -Path $registryPath -Force }

$mBase = [System.Drawing.ColorTranslator]::FromHtml("#1e1e2e")
$mSurf = [System.Drawing.ColorTranslator]::FromHtml("#313244")
$mText = [System.Drawing.ColorTranslator]::FromHtml("#cdd6f4")
$mSub  = [System.Drawing.ColorTranslator]::FromHtml("#bac2de")
$mBlue = [System.Drawing.ColorTranslator]::FromHtml("#89b4fa")
$mGree = [System.Drawing.ColorTranslator]::FromHtml("#a6e3a1")
$mRed  = [System.Drawing.ColorTranslator]::FromHtml("#f38ba8")
$mPeac = [System.Drawing.ColorTranslator]::FromHtml("#fab387")

function Set-DnsMode {
    param ([string] $dnsMode)
    Set-ItemProperty -Path $registryPath -Name "DnsOverHttpsMode" -Value $dnsMode -Type String -Force
}

function New-Sec {
    param($txt, $y)
    $l = New-Object System.Windows.Forms.Label
    $l.Text = $txt
    $l.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)
    $l.Location = New-Object System.Drawing.Point(15, $y)
    $l.Size = New-Object System.Drawing.Size(300, 20)
    $l.ForeColor = $mBlue
    return $l
}

function New-MBtn {
    param($txt, $x, $y, $clr)
    $b = New-Object System.Windows.Forms.Button
    $b.Text = $txt; $b.Location = New-Object System.Drawing.Point($x, $y)
    $b.Size = New-Object System.Drawing.Size(130, 35); $b.FlatStyle = "Flat"
    $b.FlatAppearance.BorderSize = 1; $b.FlatAppearance.BorderColor = $clr
    $b.BackColor = $mSurf; $b.ForeColor = $clr
    $b.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)
    return $b
}

$form = New-Object System.Windows.Forms.Form
$form.Text = "LeanBrave"
$form.Size = New-Object System.Drawing.Size(760, 680)
$form.StartPosition = "CenterScreen"
$form.BackColor = $mBase
$form.FormBorderStyle = "None"

$tBar = New-Object System.Windows.Forms.Panel
$tBar.Size = New-Object System.Drawing.Size(760, 40)
$tBar.BackColor = $mSurf
$form.Controls.Add($tBar)

$logoBox = New-Object System.Windows.Forms.PictureBox
$logoBox.Size = New-Object System.Drawing.Size(30, 30)
$logoBox.Location = New-Object System.Drawing.Point(10, 5)
$logoBox.SizeMode = "Zoom"

$logoPath = Join-Path $PSScriptRoot "logo.png"
if (Test-Path $logoPath) {
    try {
        $bmp = [System.Drawing.Bitmap]::FromFile($logoPath)
        $logoBox.Image = $bmp
        $hIcon = $bmp.GetHicon()
        $form.Icon = [System.Drawing.Icon]::FromHandle($hIcon)
    } catch {}
}
$tBar.Controls.Add($logoBox)

$tLab = New-Object System.Windows.Forms.Label
$tLab.Text = "LeanBrave"
$tLab.ForeColor = $mText
$tLab.Font = New-Object System.Drawing.Font("Segoe UI", 13, [System.Drawing.FontStyle]::Bold)
$tLab.Location = New-Object System.Drawing.Point(45, 7)
$tLab.AutoSize = $true
$tBar.Controls.Add($tLab)

$cBtn = New-Object System.Windows.Forms.Label
$cBtn.Text = [char]0x2715
$cBtn.ForeColor = $mRed
$cBtn.Font = New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)
$cBtn.Location = New-Object System.Drawing.Point(725, 6)
$cBtn.Cursor = "Hand"
$cBtn.Add_Click({ $form.Close() })
$tBar.Controls.Add($cBtn)

$tBar.Add_MouseDown({
    $script:drag = $true
    $script:mX = [System.Windows.Forms.Cursor]::Position.X - $form.Left
    $script:mY = [System.Windows.Forms.Cursor]::Position.Y - $form.Top
})
$tBar.Add_MouseMove({
    if ($script:drag) {
        $form.Left = [System.Windows.Forms.Cursor]::Position.X - $script:mX
        $form.Top = [System.Windows.Forms.Cursor]::Position.Y - $script:mY
    }
})
$tBar.Add_MouseUp({ $script:drag = $false })

$allFeatures = @()

$lPan = New-Object System.Windows.Forms.Panel
$lPan.Location = New-Object System.Drawing.Point(20, 60)
$lPan.Size = New-Object System.Drawing.Size(345, 510)
$lPan.BackColor = $mSurf
$lPan.BorderStyle = "FixedSingle"
$form.Controls.Add($lPan)

$lPan.Controls.Add((New-Sec "Telemetry Reporting" 10))
$f1 = @(
    @{ Name = "Disable Metrics Reporting"; Key = "MetricsReportingEnabled"; Value = 0; Type = "DWord" },
    @{ Name = "Disable Safe Browsing Reporting"; Key = "SafeBrowsingExtendedReportingEnabled"; Value = 0; Type = "DWord" },
    @{ Name = "Disable URL Data Collection"; Key = "UrlKeyedAnonymizedDataCollectionEnabled"; Value = 0; Type = "DWord" },
    @{ Name = "Disable Feedback Surveys"; Key = "FeedbackSurveysEnabled"; Value = 0; Type = "DWord" }
)
$y = 32
foreach ($f in $f1) {
    $cb = New-Object System.Windows.Forms.CheckBox
    $cb.Text = $f.Name; $cb.Tag = $f; $cb.Location = New-Object System.Drawing.Point(20, $y)
    $cb.Size = New-Object System.Drawing.Size(300, 22); $cb.FlatStyle = "Flat"; $cb.ForeColor = $mSub
    $lPan.Controls.Add($cb); $allFeatures += $cb; $y += 24
}

$y += 12
$lPan.Controls.Add((New-Sec "Privacy Security" $y))
$y += 22
$f2 = @(
    @{ Name = "Disable Safe Browsing"; Key = "SafeBrowsingProtectionLevel"; Value = 0; Type = "DWord" },
    @{ Name = "Disable Autofill (Addresses)"; Key = "AutofillAddressEnabled"; Value = 0; Type = "DWord" },
    @{ Name = "Disable Autofill (Credit Cards)"; Key = "AutofillCreditCardEnabled"; Value = 0; Type = "DWord" },
    @{ Name = "Disable Password Manager"; Key = "PasswordManagerEnabled"; Value = 0; Type = "DWord" },
    @{ Name = "Disable Browser Sign-in"; Key = "BrowserSignin"; Value = 0; Type = "DWord" },
    @{ Name = "Disable WebRTC IP Leak"; Key = "WebRtcIPHandling"; Value = "disable_non_proxied_udp"; Type = "String" },
    @{ Name = "Disable QUIC Protocol"; Key = "QuicAllowed"; Value = 0; Type = "DWord" },
    @{ Name = "Block Third Party Cookies"; Key = "BlockThirdPartyCookies"; Value = 1; Type = "DWord" },
    @{ Name = "Enable Do Not Track"; Key = "EnableDoNotTrack"; Value = 1; Type = "DWord" },
    @{ Name = "Force Google SafeSearch"; Key = "ForceGoogleSafeSearch"; Value = 1; Type = "DWord" },
    @{ Name = "Disable IPFS"; Key = "IPFSEnabled"; Value = 0; Type = "DWord" },
    @{ Name = "Disable Incognito Mode"; Key = "IncognitoModeAvailability"; Value = 1; Type = "DWord" },
    @{ Name = "Force Incognito Mode"; Key = "IncognitoModeAvailability"; Value = 2; Type = "DWord" }
)
foreach ($f in $f2) {
    $cb = New-Object System.Windows.Forms.CheckBox
    $cb.Text = $f.Name; $cb.Tag = $f; $cb.Location = New-Object System.Drawing.Point(20, $y)
    $cb.Size = New-Object System.Drawing.Size(300, 22); $cb.FlatStyle = "Flat"; $cb.ForeColor = $mSub
    $lPan.Controls.Add($cb); $allFeatures += $cb; $y += 24
}

$rPan = New-Object System.Windows.Forms.Panel
$rPan.Location = New-Object System.Drawing.Point(380, 60)
$rPan.Size = New-Object System.Drawing.Size(345, 510)
$rPan.BackColor = $mSurf
$rPan.BorderStyle = "FixedSingle"
$form.Controls.Add($rPan)

$rPan.Controls.Add((New-Sec "Brave Features" 10))
$f3 = @(
    @{ Name = "Disable Brave Rewards"; Key = "BraveRewardsDisabled"; Value = 1; Type = "DWord" },
    @{ Name = "Disable Brave Wallet"; Key = "BraveWalletDisabled"; Value = 1; Type = "DWord" },
    @{ Name = "Disable Brave VPN"; Key = "BraveVPNDisabled"; Value = 1; Type = "DWord" },
    @{ Name = "Disable Brave AI Chat"; Key = "BraveAIChatEnabled"; Value = 0; Type = "DWord" },
    @{ Name = "Disable Brave Shields"; Key = "BraveShieldsDisabledForUrls"; Value = '["https://*", "http://*"]'; Type = "String" },
    @{ Name = "Disable Tor"; Key = "TorDisabled"; Value = 1; Type = "DWord" },
    @{ Name = "Disable Sync"; Key = "SyncDisabled"; Value = 1; Type = "DWord" }
)
$y = 32
foreach ($f in $f3) {
    $cb = New-Object System.Windows.Forms.CheckBox
    $cb.Text = $f.Name; $cb.Tag = $f; $cb.Location = New-Object System.Drawing.Point(20, $y)
    $cb.Size = New-Object System.Drawing.Size(300, 22); $cb.FlatStyle = "Flat"; $cb.ForeColor = $mSub
    $rPan.Controls.Add($cb); $allFeatures += $cb; $y += 24
}

$y += 12
$rPan.Controls.Add((New-Sec "Performance Bloat" $y))
$y += 22
$f4 = @(
    @{ Name = "Disable Background Mode"; Key = "BackgroundModeEnabled"; Value = 0; Type = "DWord" },
    @{ Name = "Disable Media Recommendations"; Key = "MediaRecommendationsEnabled"; Value = 0; Type = "DWord" },
    @{ Name = "Disable Shopping List"; Key = "ShoppingListEnabled"; Value = 0; Type = "DWord" },
    @{ Name = "Always Open PDF Externally"; Key = "AlwaysOpenPdfExternally"; Value = 1; Type = "DWord" },
    @{ Name = "Disable Translate"; Key = "TranslateEnabled"; Value = 0; Type = "DWord" },
    @{ Name = "Disable Spellcheck"; Key = "SpellcheckEnabled"; Value = 0; Type = "DWord" },
    @{ Name = "Disable Promotions"; Key = "PromotionsEnabled"; Value = 0; Type = "DWord" },
    @{ Name = "Disable Search Suggestions"; Key = "SearchSuggestEnabled"; Value = 0; Type = "DWord" },
    @{ Name = "Disable Printing"; Key = "PrintingEnabled"; Value = 0; Type = "DWord" },
    @{ Name = "Disable Default Browser Prompt"; Key = "DefaultBrowserSettingEnabled"; Value = 0; Type = "DWord" },
    @{ Name = "Disable Developer Tools"; Key = "DeveloperToolsDisabled"; Value = 1; Type = "DWord" }
)
foreach ($f in $f4) {
    $cb = New-Object System.Windows.Forms.CheckBox
    $cb.Text = $f.Name; $cb.Tag = $f; $cb.Location = New-Object System.Drawing.Point(20, $y)
    $cb.Size = New-Object System.Drawing.Size(300, 22); $cb.FlatStyle = "Flat"; $cb.ForeColor = $mSub
    $rPan.Controls.Add($cb); $allFeatures += $cb; $y += 24
}

$dnsL = New-Object System.Windows.Forms.Label
$dnsL.Text = "DNS OVER HTTPS:"
$dnsL.Font = New-Object System.Drawing.Font("Segoe UI", 8, [System.Drawing.FontStyle]::Bold)
$dnsL.Location = New-Object System.Drawing.Point(380, 582); $dnsL.Size = New-Object System.Drawing.Size(100, 20); $dnsL.ForeColor = $mText
$form.Controls.Add($dnsL)

$dnsD = New-Object System.Windows.Forms.ComboBox
$dnsD.Location = New-Object System.Drawing.Point(485, 579); $dnsD.Size = New-Object System.Drawing.Size(120, 25)
$dnsD.Items.AddRange(@("automatic", "off", "custom")); $dnsD.FlatStyle = "Flat"; $dnsD.BackColor = $mSurf; $dnsD.ForeColor = $mText
$form.Controls.Add($dnsD)

$iBtn = New-MBtn "Import" 40 620 $mBlue
$eBtn = New-MBtn "Export" 185 620 $mPeac
$sBtn = New-MBtn "Apply Settings" 350 620 $mGree
$rBtn = New-MBtn "Reset All" 560 620 $mRed
$form.Controls.AddRange(@($eBtn, $iBtn, $sBtn, $rBtn))

$sBtn.Add_Click({
    foreach ($cb in $allFeatures) {
        if ($cb.Checked) {
            $f = $cb.Tag
            try { Set-ItemProperty -Path $registryPath -Name $f.Key -Value $f.Value -Type $f.Type -Force } catch {}
        }
    }
    if ($dnsD.SelectedItem) { Set-DnsMode -dnsMode $dnsD.SelectedItem }
    [System.Windows.Forms.MessageBox]::Show("Applied! Restart Brave.", "LeanBrave", 0, 64)
})

$rBtn.Add_Click({
    if ([System.Windows.Forms.MessageBox]::Show("Erase all settings?", "Warning", "YesNo") -eq "Yes") {
        try {
            Remove-Item -Path $registryPath -Recurse -Force
            New-Item -Path $registryPath -Force | Out-Null
            [System.Windows.Forms.MessageBox]::Show("Reset complete.", "LeanBrave", 0, 64)
        } catch {}
    }
})

$eBtn.Add_Click({
    $sfd = New-Object System.Windows.Forms.SaveFileDialog
    $sfd.Filter = "JSON (*.json)|*.json"; $sfd.FileName = "LeanBrave.json"
    if ($sfd.ShowDialog() -eq "OK") {
        $out = @{ Features = ($allFeatures |? {$_.Checked} |% {$_.Tag.Key}); DnsMode = $dnsD.SelectedItem }
        $out | ConvertTo-Json | Out-File $sfd.FileName -Force
    }
})

$iBtn.Add_Click({
    $ofd = New-Object System.Windows.Forms.OpenFileDialog
    $ofd.Filter = "JSON (*.json)|*.json"
    if ($ofd.ShowDialog() -eq "OK") {
        try {
            $set = Get-Content $ofd.FileName -Raw | ConvertFrom-Json
            $allFeatures |% { $_.Checked = ($set.Features -contains $_.Tag.Key) }
            $dnsD.SelectedItem = $set.DnsMode
        } catch {}
    }
})

[void] $form.ShowDialog()
