[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidatePattern('^https://')]
    [string]$ApiBaseUrl,

    [Parameter(Mandatory)]
    [ValidatePattern('^https://')]
    [string]$WebBaseUrl
)

$ErrorActionPreference = 'Stop'

function Assert-HttpSuccess {
    param(
        [Parameter(Mandatory)]
        [string]$Url
    )

    $response = Invoke-WebRequest -Uri $Url -UseBasicParsing -TimeoutSec 30
    if ($response.StatusCode -lt 200 -or $response.StatusCode -ge 400) {
        throw "Smoke test failed for $Url with HTTP $($response.StatusCode)."
    }
}

$apiUrl = "$($ApiBaseUrl.TrimEnd('/'))/api/Productos?pagina=1&tamanoPagina=1"
Assert-HttpSuccess -Url $apiUrl
Assert-HttpSuccess -Url $WebBaseUrl.TrimEnd('/')

Write-Output 'SMOKE_TEST_OK'
