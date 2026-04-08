function Add-ReglePareFeu {
    param([string]$DisplayName)

    New-NetFirewallRule -DisplayName $DisplayName -Direction Inbound -Action Allow
}

Add-ReglePareFeu -DisplayName "Test-Lab08-HTTP"