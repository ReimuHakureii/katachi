function Get-AuditUtilisateurs {
    $utilisateurs = Get-LocalUser

    foreach ($user in $utilisateurs) {
        Write-Host "`n--- $($user.Name) ---" -ForegroundColor White

        # Statut
        $statut = if ($user.Enabled) { "Actif" } else { "Désactivé" }
        $couleurStatut = if ($user.Enabled) { "Green" } else { "Red" }
        Write-Host "  Nom complet       : $($user.FullName)"
        Write-Host "  Statut            : $statut" -ForegroundColor $couleurStatut

        # Derniere connexion
        $derniereConnexion = if ($user.LastLogon) {
            $user.LastLogon.ToString("yyyy-MM-dd HH:mm:ss")
        } else {
            "Jamais"
        }
        Write-Host "  Dernière connexion : $derniereConnexion"

        # Exp mdp
        $expMDP = if ($user.PasswordExpires) {
            $user.PasswordExpires.ToString("yyyy-MM-dd")
        } else {
            "N'expire pas"
        }
        Write-Host "  Expiration MDP     : $expMDP"

        # Exp compte
        $expireraT = if ($user.AccountExpires) {
            "Oui, le $($user.AccountExpires.ToString('yyyy-MM-dd'))"
        } else {
            "Non"
        }
        Write-Host "  Expirera-t-il ?    : $expireraT"

        # Groupes d'appartenance
        $groupes = (Get-LocalGroup | Where-Object {
            (Get-LocalGroupMember -Group $_.Name -ErrorAction SilentlyContinue).Name -contains "$env:COMPUTERNAME\$($user.Name)"
        }).Name -join ", "

        $groupes = if ($groupes) { $groupes } else { "Aucun groupe trouvé "}
        Write-Host "  Groupes            : $groupes"
    }
}

# Execution
Get-AuditUtilisateurs