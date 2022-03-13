# Copyright (c) 2022 Ivan Teplov

bodyParser = require "body-parser"
express = require "express"
morgan = require "morgan"


app = express()

# Enable logging
app.use morgan("dev")

# Parse requests body that are in JSON format
app.use bodyParser.json()


port = +process.env.PORT

if isNaN port
  port = 3000

app.listen port, ->
  console.log "Listening on port #{port}"
