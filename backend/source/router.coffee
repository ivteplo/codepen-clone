# Copyright (c) 2022 Ivan Teplov

express = require "express"
{ v4: uuid } = require "uuid"

{ savePen, getPen } = require "./data"

router = express.Router()

router.post "/pen/new", (request, response) ->
  pen =
    id: uuid()
    files:
      html: "<h1>Hello, world!</h1>"
      css: "body {\n\tfont-family: sans-serif;\n}"
      javascript: "console.log('hello, world!')"

  await savePen pen
  response.json pen

getRequestedPen = (request, response) ->
  penID = request.params.id
  pen = await getPen penID

  return pen if pen

  response.status(404).json {
    type: "error",
    message: "Pen doesn't exist"
  }

  return undefined

router.get "/pen/:id", (request, response) ->
  pen = await getRequestedPen request, response
  response.json(pen) if pen

all = (array, callback) ->
  array.filter(
    (...args) => !!callback(...args)
  ).length == array.length

hasFile = (type, files) ->
  type of files and
  typeof files[type] == "string"

areFilesValid = (files) ->
  typeof files == "object" and
  all ["html", "css", "javascript"], (type) ->
    hasFile type, files

router.post "/pen/:id", (request, response) ->
  pen = await getRequestedPen request, response
  return unless pen

  { files } = request.body

  unless areFilesValid files
    return response.status(400).json {
      type: "error",
      message: "Invalid pen data"
    }

  pen =
    id: pen.id,
    body: request.body

  await savePen pen
  response.json pen

module.exports = router
