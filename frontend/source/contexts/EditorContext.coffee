# Copyright (c) 2022 Ivan Teplov

import React from "react"

defaultContext =
  files: {}
  editorSettings:
    tabSize: 2
    fontSize: 14
    fontFamily: "JetBrains Mono, Hack, Cascadia Code, SF Mono, Consolas, 'Courier New', monospace"
    fontLigatures: on
    mouseWheelZoom: on
  saveFile: () -> return
  saveEditorSettings: () -> return

export EditorContext = React.createContext defaultContext

export EditorContextProvider = ({
  files: _files = {},
  editorSettings: _editorSettings = defaultContext.editorSettings,
  onSave,
  children
}) ->
  [ files, setFiles ] = React.useState _files
  [ editorSettings, setEditorSettings ] = React.useState {
    ...defaultContext.editorSettings,
    ..._editorSettings
  }

  saveTimeoutID = null

  saveEditorSettings = (settings) ->
    setEditorSettings settings
    onSave({
      editorSettings: settings
    }) if onSave instanceof Function

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
      onSave({ files }) if onSave instanceof Function

    saveTimeoutID = setTimeout save, 1000

  context = {
    files,
    editorSettings,
    saveFile,
    saveEditorSettings
  }

  <EditorContext.Provider value={context}>
    {children}
  </EditorContext.Provider>
