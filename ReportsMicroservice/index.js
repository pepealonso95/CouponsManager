const app = require('./app')
const config = require('config-yml')
const port = (process.env.PORT || 5000)

app.listen(port, () => {
  console.log(`Server is up on http://localhost:${port}
  Endpoints:
      * GET  /reports/:iata_code
      * POST /reports
      * GET  /health`)
})
