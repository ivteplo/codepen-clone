# Copyright (c) 2022 Ivan Teplov

bodyParser = require "body-parser"
express = require "express"
morgan = require "morgan"
path = require "path"


frontendPath = path.join __dirname, "../../frontend/public"


app = express()

# Enable logging
app.use morgan("dev")

# Parse requests body that are in JSON format
app.use bodyParser.json()

# Serve frontend
app.use express.static(frontendPath)


port = +process.env.PORT

if isNaN port
  port = 3000

app.listen port, ->
  console.log "Listening on port #{port}"
