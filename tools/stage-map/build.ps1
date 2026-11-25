# Encrypts the stage map (tools/stage-map/src/index.html) into public/stage-map/index.html with StatiCrypt.
# Usage, from any folder:
#   $env:STATICRYPT_PASSWORD = '<password>'; & .\tools\stage-map\build.ps1
# Then commit public/stage-map/index.html and push: the site deploys on push to main.
$ErrorActionPreference = 'Stop'
$qui = $PSScriptRoot
$radice = (Resolve-Path (Join-Path $qui '..\..')).Path
$src = Join-Path $qui 'src\index.html'
$out = Join-Path $qui 'out'

if (-not $env:STATICRYPT_PASSWORD) { throw 'Set $env:STATICRYPT_PASSWORD first (the password is never stored in the repo).' }
if (-not (Test-Path $src)) { throw "Missing $src. Recover it from the published page with decrypt.ps1." }
if (Test-Path $out) { Remove-Item -Recurse -Force $out }

# the same salt every time (staticrypt.json), so a visitor's "remember me" survives an update;
# StatiCrypt resolves the config path from the current folder, so it runs from this one with relative paths
$argomenti = @(
  '--yes', 'staticrypt@3.5.4', 'src\index.html', '-d', 'out', '-c', 'staticrypt.json', '--short',
  '-t', 'template-naba.html', '--remember', '30',
  '--template-title', 'NABA Virtual Studio',
  '--template-instructions', 'Enter the password you received with the link.',
  '--template-button', 'Open the map',
  '--template-placeholder', 'Password',
  '--template-remember', 'Remember me on this device for 30 days',
  '--template-error', 'Wrong password. Check it and try again.'
)
Push-Location $qui
try { & npx @argomenti; $esito = $LASTEXITCODE } finally { Pop-Location }
if ($esito -ne 0) { throw 'StatiCrypt failed.' }

$pagina = Join-Path $out 'index.html'
if ((Get-Content $pagina -Raw) -match 'VS-RENDER') { throw 'The output still contains plaintext: not copied.' }
Copy-Item $pagina (Join-Path $radice 'public\stage-map\index.html') -Force
Remove-Item -Recurse -Force $out
Write-Output 'public/stage-map/index.html updated. Commit and push to publish.'
