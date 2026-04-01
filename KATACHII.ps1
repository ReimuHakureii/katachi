# ============================================
#        VOID ENGINE vΩ++
# ============================================

Add-Type -AssemblyName System.Windows.Forms

# --------------------------------------------
# GLOBAL STATE
# --------------------------------------------
$State = @{
    Voices      = @("CORE","ECHO","NULL","WITNESS","SHADOW","ARCHIVE","OBSERVER")
    Memory      = New-Object System.Collections.ArrayList
    Instability = 0
    LastKey     = ""
    Phase       = 0
}

# --------------------------------------------
# VOICE DATABASE (EXPANDED)
# --------------------------------------------
$VoiceLines = @{
    CORE = @(
        "System integrity nominal.",
        "Maintaining control.",
        "Input acknowledged.",
        "Stability holding.",
        "No anomalies detected."
    )
    ECHO = @(
        "…detected…detected…",
        "You said that already.",
        "Repeating previous thought.",
        "It echoes forever.",
        "Nothing new was said."
    )
    NULL = @(
        "There is nothing here.",
        "That input does not exist.",
        "You did not press anything.",
        "Silence is truth.",
        "All signals are void."
    )
    WITNESS = @(
        "I saw that.",
        "You cannot hide input.",
        "It has been recorded.",
        "Observation complete.",
        "You are being watched."
    )
    SHADOW = @(
        "Do not trust CORE.",
        "They are lying to you.",
        "This is not real.",
        "Ignore the system.",
        "Break the loop."
    )
    ARCHIVE = @(
        "Storing event...",
        "Memory updated.",
        "Historical inconsistency detected.",
        "Rewriting past entry.",
        "Log divergence found."
    )
    OBSERVER = @(
        "External presence confirmed.",
        "Monitoring continues.",
        "Behavior pattern unstable.",
        "User anomaly increasing.",
        "Observation never stops."
    )
}

# --------------------------------------------
# INPUT SYSTEM
# --------------------------------------------
function Get-Input {
    if ([console]::KeyAvailable) {
        $key = [console]::ReadKey($true)
        return $key.KeyChar
    }
    return $null
}

# --------------------------------------------
# VOICE ENGINE
# --------------------------------------------
function Get-VoiceLine {
    param($voice)

    $line = ($VoiceLines[$voice] | Get-Random)

    if ($State.LastKey -ne "") {
        if ((Get-Random -Minimum 0 -Maximum 2) -eq 0) {
            $line += " [KEY:$($State.LastKey)]"
        }
    }

    return "[$voice] $line"
}

# --------------------------------------------
# GLITCH ENGINE
# --------------------------------------------
function Invoke-Glitch {
    param($text)

    $chars = $text.ToCharArray()
    for ($i=0; $i -lt $chars.Length; $i++) {
        if ((Get-Random -Minimum 0 -Maximum 15) -eq 0) {
            $chars[$i] = [char](Get-Random -Minimum 33 -Maximum 126)
        }
    }
    return -join $chars
}

# --------------------------------------------
# MEMORY SYSTEM
# --------------------------------------------
function Add-Memory {
    param($line)
    [void]$State.Memory.Add($line)
}

function Corrupt-Memory {
    if ($State.Memory.Count -gt 0) {
        $i = Get-Random -Minimum 0 -Maximum $State.Memory.Count
        $State.Memory[$i] = Invoke-Glitch $State.Memory[$i]
    }
}

# --------------------------------------------
# SCREEN ENGINE
# --------------------------------------------
$Width = 90
$Height = 28
$Buffer = @()

for ($i=0; $i -lt $Height; $i++) {
    $Buffer += (" " * $Width)
}

function Push-Line {
    param($text)

    for ($i=1; $i -lt $Height; $i++) {
        $Buffer[$i-1] = $Buffer[$i]
    }

    if ($text.Length -gt $Width) {
        $text = $text.Substring(0,$Width)
    }

    $Buffer[$Height-1] = $text.PadRight($Width)
}

function Draw {
    Clear-Host
    foreach ($l in $Buffer) { Write-Host $l }
}

# --------------------------------------------
# MULTI-WINDOW OBSERVERS
# --------------------------------------------
function Spawn-Observers {
    for ($i=0; $i -lt 2; $i++) {
        Start-Process powershell -ArgumentList "-NoExit","-Command `"while(\$true){Write-Host '[OBSERVER] watching...'; Start-Sleep -Milliseconds (Get-Random -Min 300 -Max 900)}`""
    }
}

# --------------------------------------------
# ARGUMENT SYSTEM
# --------------------------------------------
function Generate-Dialogue {
    $v1 = $State.Voices | Get-Random
    $v2 = $State.Voices | Where-Object {$_ -ne $v1} | Get-Random

    return @(
        Get-VoiceLine $v1
        Get-VoiceLine $v2
    )
}

# --------------------------------------------
# INSTABILITY STATE MACHINE
# --------------------------------------------
function Update-Phase {
    if ($State.Instability -gt 40) { $State.Phase = 3 }
    elseif ($State.Instability -gt 20) { $State.Phase = 2 }
    elseif ($State.Instability -gt 10) { $State.Phase = 1 }
}

# --------------------------------------------
# START
# --------------------------------------------
Spawn-Observers
[console]::CursorVisible = $false

while ($true) {

    # INPUT
    $input = Get-Input
    if ($input) {
        $State.LastKey = $input
        $State.Instability += 3
        Push-Line "[INPUT] $input detected"
    }

    # PHASE UPDATE
    Update-Phase

    # DIALOGUE
    $lines = Generate-Dialogue
    foreach ($l in $lines) {
        Add-Memory $l
        Push-Line $l
    }

    # PHASE EFFECTS
    switch ($State.Phase) {

        1 {
            if ((Get-Random -Minimum 0 -Maximum 4) -eq 0) {
                Push-Line "[SYSTEM] MINOR DESYNC"
            }
        }

        2 {
            if ((Get-Random -Minimum 0 -Maximum 3) -eq 0) {
                Corrupt-Memory
                Push-Line "[WARNING] MEMORY CORRUPTION"
            }

            # partial glitch
            for ($i=0; $i -lt $Buffer.Count; $i++) {
                if ((Get-Random -Minimum 0 -Maximum 4) -eq 0) {
                    $Buffer[$i] = Invoke-Glitch $Buffer[$i]
                }
            }
        }

        3 {
            # overlapping voices
            $multi = ""
            for ($i=0; $i -lt 4; $i++) {
                $multi += (Get-VoiceLine ($State.Voices | Get-Random)) + " "
            }
            Push-Line $multi

            # heavy corruption
            for ($i=0; $i -lt $Buffer.Count; $i++) {
                $Buffer[$i] = Invoke-Glitch $Buffer[$i]
            }

            # rewrite history
            $idx = Get-Random -Minimum 0 -Maximum $Height
            $Buffer[$idx] = "[REWRITTEN] THIS LINE IS FALSE".PadRight($Width)
        }
    }

    Draw
    Start-Sleep -Milliseconds (Get-Random -Minimum 40 -Maximum 100)
}