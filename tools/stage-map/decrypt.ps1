# Recovers the stage map source from the published page: public/stage-map/index.html → tools/stage-map/src/index.html.
# Use it on a new machine, or if the local source is lost. An existing source is kept as index.html.bak.
# Usage:
#   $env:STATICRYPT_PASSWORD = '<password>'; & .\tools\stage-map\decrypt.ps1
$ErrorActionPreference = 'Stop'
$qui = $PSScriptRoot
$radice = (Resolve-Path (Join-Path $qui '..\..')).Path
$pubblicata = Join-Path $radice 'public\stage-map\index.html'
$cartella = Join-Path $qui 'src'
$tmp = Join-Path $qui 'out'

if (-not $env:STATICRYPT_PASSWORD) { throw 'Set $env:STATICRYPT_PASSWORD first.' }
$salt = (Get-Content (Join-Path $qui 'staticrypt.json') -Raw | ConvertFrom-Json).salt
if (Test-Path $tmp) { Remove-Item -Recurse -Force $tmp }

& npx --yes staticrypt@3.5.4 $pubblicata --decrypt -d $tmp -c false -s $salt
if ($LASTEXITCODE -ne 0 -or -not (Test-Path (Join-Path $tmp 'index.html'))) { throw 'Decryption failed: wrong password or salt.' }

New-Item -ItemType Directory -Force $cartella | Out-Null
$src = Join-Path $cartella 'index.html'
if (Test-Path $src) { Move-Item $src "$src.bak" -Force }
Move-Item (Join-Path $tmp 'index.html') $src
Remove-Item -Recurse -Force $tmp
Write-Output "Source recovered in $src."
