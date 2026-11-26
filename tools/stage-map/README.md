# Stage map

The password-protected connection map of the studio, published at `/stage-map/`
(`public/stage-map/index.html`). It is one self-contained HTML page, encrypted with
[StatiCrypt](https://github.com/robinmoisson/staticrypt) 3.5.4: this repository is public, so only the
encrypted page is committed.

| File | What it is |
| --- | --- |
| `src/index.html` | The map in plain text. **Git-ignored, never committed.** |
| `template-naba.html` | The dark password page with the NABA logo (a restyled StatiCrypt template). |
| `staticrypt.json` | The salt. Not a secret; kept fixed so "remember me" survives updates. |
| `build.ps1` | Encrypts `src/index.html` into `public/stage-map/index.html`. |
| `decrypt.ps1` | Recovers `src/index.html` from the published page. |

The password is not stored anywhere in the repository.

## Update the map

```powershell
$env:STATICRYPT_PASSWORD = '<password>'
& .\tools\stage-map\decrypt.ps1   # only if src/index.html is missing on this machine
# edit tools\stage-map\src\index.html, check it in a browser
& .\tools\stage-map\build.ps1
git add public/stage-map/index.html
git commit -m "Update stage map"
git push
```

The push to `main` deploys the site in about two minutes.

## Change the password

Run `build.ps1 -NewPassword` with the new password in `$env:STATICRYPT_PASSWORD`, commit and push. Visitors
who ticked "remember me" are asked for the new one. Without `-NewPassword` the script refuses a password
that does not open the published map, so a typo cannot lock everyone out.

A new password does not cut off whoever has the old one: every earlier encrypted version of the map
stays in the public repo's history and still opens with the old password. If the password leaks,
changing it is not enough: the old versions have to leave the history too.
