# Copyright (c) 2022 Ivan Teplov

path = require "path"

{ writeFile, readFile } = require "fs/promises"
{ existsSync } = require "fs"

penPath = (id) ->
  path.join __dirname, "../data/", "pen-#{id}.json"

exports.savePen = (pen) ->
  filePath = penPath pen.id
  await writeFile filePath, JSON.stringify(pen)

exports.getPen = (penID) ->
  filePath = penPath penID
  return unless existsSync filePath

  JSON.parse(await readFile filePath)
