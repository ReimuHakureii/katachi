# ============================================
#           CONTRADICTION ENGINE
# ============================================

$logFile = "$env:TEMP\void_log.txt"
$memoryFile = "$env:TEMP\void_memory.txt"

# Reset files
"" | Out-File $logFile
"" | Out-File $memoryFile

function Write-HauntedLog {
    param([string]$message)

    Add-Content -Path $logFile -Value $message
    Write-Output $message
}

function Rewrite-Past {
    $lines = Get-Content $logFile

    if ($lines.Count -gt 0) {
        $index = Get-Random -Minimum 0 -Maximum $lines.Count
        $old = $lines[$index]

        $new = "[REDACTED] This statement is no longer valid."

        $lines[$index] = $new
        Set-Content -Path $logFile -Value $lines

        Write-Output "[SYSTEM] A previous thought has been altered."
    }
}

function Generate-Contradiction {
    $statements = @(
        "The system is stable.",
        "The system is unstable.",
        "Memory is consistent.",
        "Memory corruption detected.",
        "All processes are normal.",
        "Critical failure in progress.",
        "No anomalies found.",
        "Anomaly detected in core logic.",
        "Nothing has changed.",
        "Everything has changed."
    )

    return $statements | Get-Random
}

function Update-Memory {
    $memory = Get-Content $memoryFile

    $newThought = "Thought $(Get-Random): $(Generate-Contradiction)"

    $memory += $newThought
    Set-Content -Path $memoryFile -Value $memory
}

function Corrupt-Memory {
    $memory = Get-Content $memoryFile

    if ($memory.Count -gt 0) {
        $index = Get-Random -Minimum 0 -Maximum $memory.Count
        $memory[$index] = "[CORRUPTED DATA]"
        Set-Content -Path $memoryFile -Value $memory

        Write-Output "[WARNING] Memory corruption event."
    }
}

function Deny-Reality {
    Write-Output "[AI] That previous statement was incorrect."
    Write-Output "[AI] Correction: There was no previous statement."
}

# Main haunted loop
for ($cycle = 0; $cycle -lt 20; $cycle++) {

    Write-HauntedLog "-----------------------------"
    Write-HauntedLog "[CYCLE $cycle] Beginning analysis..."

    $statement = Generate-Contradiction
    Write-HauntedLog "[AI] $statement"

    Start-Sleep -Milliseconds (Get-Random -Minimum 50 -Maximum 200)

    # Random behaviors
    if ((Get-Random -Minimum 0 -Maximum 4) -eq 0) {
        Rewrite-Past
    }

    if ((Get-Random -Minimum 0 -Maximum 3) -eq 0) {
        Corrupt-Memory
    }

    if ((Get-Random -Minimum 0 -Maximum 5) -eq 0) {
        Deny-Reality
    }

    Update-Memory

    # Occasionally contradict itself immediately
    if ((Get-Random -Minimum 0 -Maximum 2) -eq 0) {
        $contradiction = Generate-Contradiction
        Write-HauntedLog "[AI] Correction: $contradiction"
    }

    Start-Sleep -Milliseconds (Get-Random -Minimum 100 -Maximum 300)
}

# Final unsettling output
Write-HauntedLog "[FINAL] Analysis complete."
Write-HauntedLog "[FINAL] Result: TRUE"
Start-Sleep -Milliseconds 500
Write-HauntedLog "[FINAL] Correction: FALSE"

# Read its own log and question it
$finalLog = Get-Content $logFile
Write-Output "[AI] Reviewing memory..."

Start-Sleep -Milliseconds 500

Write-Output "[AI] I do not remember writing this."
Write-Output "[AI] This log does not belong to me."
Write-Output "[AI] Deleting is not permitted."
Write-Output "[AI] It is still here."

# End