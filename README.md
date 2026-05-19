# Hertfordshire Hedging

Marketing site for Hertfordshire Hedging Ltd — specialists in supplying, planting and maintaining the finest quality hedging across Hertfordshire and the Home Counties.

## Stack

Plain static site. No build step, no dependencies. Just HTML, inline CSS, and inline JS.

- `index.html` — single-page site with Home / About / Services / Gallery / Contact sections (JS-driven view switching)
- `404.html` — branded not-found page (auto-served by Netlify)
- `img/` — gallery and hero images (self-hosted)
- `favicon.svg` — site icon
- `robots.txt`, `sitemap.xml` — SEO
- `netlify.toml` — deploy config, security headers, caching rules

## Local development

Just open `index.html` in a browser. For a closer-to-production preview with absolute paths working correctly, run a local server:

```bash
# Python 3
python3 -m http.server 8000

# Or with Node
npx serve .
```

Then visit http://localhost:8000.

## Deployment

Auto-deployed by Netlify on every push to `main`. Live at:

- https://herts-hedging.netlify.app (once Netlify is connected — see below)

### First-time Netlify setup

1. Go to https://app.netlify.com → **Add new site** → **Import an existing project**
2. Choose GitHub, then this repo (`Action3412/-herts-hedging-`)
3. Build settings: leave blank — `netlify.toml` already configures `publish = "."`
4. Click **Deploy**

## Updating content

1. Edit `index.html` locally
2. Commit and push to `main`
3. Netlify rebuilds within ~30 seconds

### Adding images

Drop new JPGs into `img/` and reference them with `/img/your-file.jpg` in the HTML.

### Updating contact details / copy

Search `index.html` for the relevant text — copy lives directly in the HTML (no CMS).

## Notes

- Security headers and immutable asset caching are configured in `netlify.toml`
- Schema.org `LocalBusiness` markup is embedded in the `<head>` of `index.html`
- The OG image, Twitter image, and canonical URL all reference `herts-hedging.netlify.app` — update these when a custom domain is added
