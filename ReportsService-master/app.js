const express = require('express')
const reportRouter = require('./routes/report-routes')
require('./db/mongoose')

const app = express()

app.use(express.json())
app.use((err, req, res, next) => {
  if (err) {
    res.status(400).send('Invalid Format Provided. Only accepting proper json.')
  } else {
    next()
  }
})
app.use(reportRouter)

module.exports = app
