# Immagini dei progetti (`public/images/`)

Metti in `public/images/` un'immagine per ogni progetto, con lo **stesso nome del file Markdown** del progetto.

Esempi:
- `src/content/projects/multi-user.md` → `public/images/multi-user.jpg` (o .png, .gif, .webp)
- `src/content/projects/led-volume.md` → `public/images/led-volume.png`
- `src/content/projects/ocio.md` → `public/images/ocio.gif`

Il sito prova in ordine: `.jpg` → `.jpeg` → `.png` → `.gif` → `.webp`, e usa la prima estensione che trova.

## Note

- Dimensioni consigliate: 1600×900 px, sotto 500 KB per file
- GIF animate: supportate
- Case-insensitive: `Multi-User.jpg` e `multi-user.jpg` funzionano entrambi
