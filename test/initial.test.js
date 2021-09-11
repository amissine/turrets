//const fetch = require('node-fetch') - v3 is an ESM-only module, no require// {{{1
const log = console.log

const fetch = // {{{1
  (...args) => import('node-fetch').then(({default: fetch}) => fetch(...args))

const test = // {{{1
  async (port) => {
    const result = await fetch(`http://127.0.0.1:${port}`).
      then(response => response.text()).
      catch(err => `${err}\n\tHave you started 'npm run dev' in another terminal?\n`)

    log(result)
  }

test(8789)
