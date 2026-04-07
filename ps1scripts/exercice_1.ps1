$nomOrdinateur   = $env:COMPUTERNAME
$nomUtilisateur  = $env:USERNAME
$espaceLibreGB   = [math]::Round((Get-PSDrive C).Free / 1GB, 2)
$nbProcessus     = (Get-Process).Count

Write-Host "Nom de l'ordinateur     : $nomOrdinateur"
Write-Host "Utilisateur courant     : $nomUtilisateur"
Write-Host "Espace libre sur C:     : $espaceLibreGB GB"
Write-Host "Nombre de processus     : $nbProcessus"

if ($espaceLibreGB -lt 10) {
    Write-Host "[CRITIQUE] Espace disque insuffisant ($espaceLibreGB GB)" -ForegroundColor Red
}
elseif ($espaceLibreGB -lt 50) {
    Write-Host "[ATTENTION] Espace disque limité ($espaceLibreGB GB)" -ForegroundColor Yellow
}
else {
    Write-Host "[OK] Espace disque suffisant ($espaceLibreGB GB)" -ForegroundColor Green
}