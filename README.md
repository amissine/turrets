Source:

``` sh
git clone https://github.com/cloudflare/modules-rollup-esm.git
```

Moved all common dependencies up:
```
  "dependencies": {
    "bignumber.js": "^4.1.0",
    "moment": "^2.29.1",
    "node-fetch": "^3.0.0",
    "stellar-sdk": "^8.2.4"
  },
  "devDependencies": {
    "@rollup/plugin-commonjs": "^17.0.0",
    "@rollup/plugin-node-resolve": "^11.1.0",
    "prettier": "^1.19.1",
    "rollup": "^2.36.1",
    "rollup-plugin-copy": "^3.3.0",
    "rollup-plugin-terser": "^7.0.2"
  }
```

# 👷 Modules Wrangler template

## NOTE: You must be using wrangler 1.16 or newer to use this template

A template for kick starting a Cloudflare Workers project using:

- Modules (ES Modules to be specific)
- Rollup
- Wrangler

Worker code is in `src/index.mjs`.

Rollup is configured to output a bundled ES Module to `dist/index.mjs`.

- This bundle is also configured to be the main module, using the `module` key in `package.json`.
