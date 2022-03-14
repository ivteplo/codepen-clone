# Copyright (c) 2022 Ivan Teplov

import React, { useState, useContext, createContext } from "react"
import { EditorContext } from "../contexts/EditorContext"
import MonacoEditor from "@monaco-editor/react"
import "./Editor.css"

export Editor = ({ initialFile }) ->
  { files, editorSettings, saveFile } = useContext EditorContext

  [currentMode, setCurrentMode] = useState initialFile
  file = files[currentMode]

  onChange = (newCode) ->
    saveFile currentMode, newCode

  changeTab = (mode) ->
    setCurrentMode mode

  <div className="Editor column fill">
    {
      Object.keys(files).length > 1 and
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
    }
    <MonacoEditor
      height="40vh"
      path={file.name}
      language={file.language}
      defaultValue={file.value}
      onChange={onChange}
      options={editorSettings}
    />
  </div>

export default Editor
