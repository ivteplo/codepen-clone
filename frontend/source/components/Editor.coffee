# Copyright (c) 2022 Ivan Teplov

import React from "react"
import MonacoEditor from "@monaco-editor/react"

import { EditorContext } from "../contexts/EditorContext"
import usePreferredMode from "../hooks/usePreferredMode"

import "./Editor.css"

export Editor = ({ initialFile, height }) ->
  { files, editorSettings, saveFile } = React.useContext EditorContext
  theme = usePreferredMode()
  editorTheme = if theme == "light" then "light" else "vs-dark"

  [currentMode, setCurrentMode] = React.useState initialFile
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
      height={height}
      path={file.name}
      language={file.language}
      defaultValue={file.value}
      onChange={onChange}
      options={editorSettings}
      theme={editorTheme}
    />
  </div>

export default Editor
