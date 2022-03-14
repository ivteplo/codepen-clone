# Copyright (c) 2022 Ivan Teplov

import React, { useState, useContext, createContext } from "react"
import { EditorContext } from "../contexts/EditorContext"
import MonacoEditor from "@monaco-editor/react"
import EditorPreview from "./EditorPreview"
import "./Editor.css"

editorSettings =
  tabSize: 2
  fontSize: 14
  fontFamily: "JetBrains Mono, Hack, Cascadia Code, SF Mono, Consolas, 'Courier New', monospace"
  fontLigatures: on
  mouseWheelZoom: on

export Editor = ->
  { files, saveFile } = useContext EditorContext

  [currentMode, setCurrentMode] = useState "HTML"
  file = files[currentMode]

  onChange = (newCode) ->
    saveFile currentMode, newCode

  changeTab = (mode) ->
    setCurrentMode mode

  <div className="column fill">
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
              {key}
            </button>
        )
      }
    </nav>
    <MonacoEditor
      height="50%"
      path={file.name}
      language={file.language}
      value={file.value}
      onChange={onChange}
      options={editorSettings}
    />
    <EditorPreview files={files} />
  </div>

export default Editor
