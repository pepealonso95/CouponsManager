const app = require('./app')
const config = require('config-yml')
const port = config.app.port

app.listen(port, () => {
  console.log(`Server is up on http://localhost:${port}
  Endpoints:
      * GET  /reports/:iata_code
      * POST /reports
      * GET  /health`)
})
