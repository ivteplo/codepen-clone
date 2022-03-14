# Copyright (c) 2022 Ivan Teplov

import React, { useState, useContext, createContext } from "react"
import MonacoEditor from "@monaco-editor/react"
import "./Editor.css"

defaultContext =
  files:
    html:
      name: "index.html"
      language: "html"
      value: "<!-- write your HTML code here -->"
    css:
      name: "index.css"
      language: "css"
      value: "/* write your CSS code here */"
    js:
      name: "main.js"
      language: "javascript"
      value: "// write your JavaScript code here"
  saveFile: () -> return

EditorContext = createContext defaultContext

export EditorContextProvider = ({ children }) ->
  [ files, setFiles ] = useState defaultContext.files

  saveFile = (mode, contents) ->
    setFiles {
      ...files,
      [mode]: {
        ...files[mode]
        value: contents
      }
    }

  <EditorContext.Provider value={{ files, saveFile }}>
    {children}
  </EditorContext.Provider>

export Editor = ->
  { files, saveFile } = useContext EditorContext

  [currentMode, setCurrentMode] = useState "html"
  file = files[currentMode]

  onChange = (newCode) ->
    saveFile currentMode, newCode

  changeTab = (mode) ->
    setCurrentMode mode

  <div className="column">
    <nav className="EditorTabs row">
      {
        Object.keys(files).map((key) ->
          currentFile = file

          do (file = files[key]) ->
            <button
              type="button"
              disabled={file.name == currentFile.name}
              key={key}
              onClick={changeTab.bind(this, key)}
              className="gray"
            >
              {file.name}
            </button>
        )
      }
    </nav>
    <MonacoEditor
      height="90vh"
      theme="vs-light"
      path={file.name}
      language={file.language}
      value={file.value}
      onChange={onChange}
    />
  </div>

export default Editor
