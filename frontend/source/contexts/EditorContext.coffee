# Copyright (c) 2022 Ivan Teplov

import React from "react"

defaultContext =
  files:
    HTML:
      name: "index.html"
      language: "html"
      value: "<h1>Hello, world!</h1>"
    CSS:
      name: "index.css"
      language: "css"
      value: "body {\n\tfont-family: sans-serif;\n}"
    JavaScript:
      name: "main.js"
      language: "javascript"
      value: "console.log('hello, world!')"
  saveFile: () -> return

export EditorContext = React.createContext defaultContext

export EditorContextProvider = ({ children }) ->
  [ files, setFiles ] = React.useState defaultContext.files

  saveTimeoutID = null

  saveFile = (mode, contents) ->
    files = {
      ...files,
      [mode]: {
        ...files[mode]
        value: contents
      }
    }

    if saveTimeoutID != null
      clearTimeout saveTimeoutID

    save = ->
      setFiles files
      saveTimeoutID = null

    saveTimeoutID = setTimeout save, 1000

  <EditorContext.Provider value={{ files, saveFile }}>
    {children}
  </EditorContext.Provider>
