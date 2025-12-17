# Run this script with ./getCameraIds.ps1 -verkadaApiKey "<Your Verkada API keys>"
# The API key you use must have read access to the Cameras endpoint.

param (
    [string]$verkadaApiKey
)

# $verkadaApiKey = ""
$verkadaBaseUrl = "https://api.verkada.com"

function Get-VerkadaApiToken {
    param ([string]$ApiKey)
    $response = Invoke-RestMethod -Method Post -Uri "$verkadaBaseUrl/token" -Headers @{
        "x-api-key" = $ApiKey
    }
    return $response.token
}

function Get-VerkadaHeaders {
    return @{
        "x-verkada-auth" = "$verkadaApiToken"
    }
}

Write-Host "Authenticating to Verkada API..."
$verkadaApiToken = Get-VerkadaApiToken -ApiKey $verkadaApiKey
$verkadaHeaders = Get-VerkadaHeaders


$verkadaCameraUrl = "$verkadaBaseUrl/cameras/v1/devices"
$verkadaCameraResponse = Invoke-RestMethod -Uri $verkadaCameraUrl -Method GET -Headers $verkadaHeaders

$flattened = $verkadaCameraResponse.cameras | ForEach-Object {
    [PSCustomObject]@{
        camera_id = $_.camera_id
        camera_name = $_.name
    }
}

$flattened | Export-Csv "cameraInfo.csv" -NoTypeInformation