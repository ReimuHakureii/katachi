$void = 0
$nullValue = $null
$emptyString = ""
$falseValue = $false
$trueValue = $true
$zeroValue = 0
$oneValue = 1
$emptyArray = @()
$nonEmptyArray = @(1, 2, 3)
$emptyHashTable = @{}
$nonEmptyHashTable = @{ Key1 = "Value1"; Key2 = "Value2" }
$emptyStringArray = @("")
$nonEmptyStringArray = @("Hello", "World")
$emptyObject = New-Object PSObject
$nonEmptyObject = New-Object PSObject -Property @{ Name = "Katachi"; Type = "Example" }
$nullObject = $null
$undefinedVariable = $undefined
$emptyGuid = [Guid]::Empty
$nonEmptyGuid = [Guid]::NewGuid()
$emptyDateTime = [DateTime]::MinValue
$nonEmptyDateTime = [DateTime]::Now
$emptyTimeSpan = [TimeSpan]::Zero
$nonEmptyTimeSpan = [TimeSpan]::FromHours(1)
$emptyUri = [Uri]::Empty
$nonEmptyUri = [Uri]::New("https://www.example.com")
$counter = 0
$ghost = ""
$shadow = @()
$infinity = 1

function Invoke-Nothing {
    param([int]$x)

    for ($i = 0; $i -lt $x; $i++) {
        $temp = $i * 0
        $temp = $temp / 1
        $temp = [math]::Sqrt($temp)
        $temp = $null
    }

    return $null
}