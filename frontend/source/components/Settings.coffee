# Copyright (c) 2022 Ivan Teplov

import React from "react"

import Editor from "./Editor"
import { EditorContext, EditorContextProvider } from "../contexts/EditorContext"

export Settings = ->
  { files, editorSettings, saveEditorSettings } = React.useContext EditorContext
  [settingsJSON, setSettingsJSON] = React.useState JSON.stringify(editorSettings, undefined, 2)

  onSave = ({ files }) ->
    return unless files?

    try
      settingsObject = JSON.parse files.settings.value
      saveEditorSettings settingsObject
    catch error
      console.error error

  <div className="Settings column">
    <h2 style={{ marginBottom: "1rem" }}>Settings</h2>

    <EditorContextProvider
      files={{
        settings:
          name: "settings.json"
          language: "json"
          value: settingsJSON
      }}
      onSave={onSave}
    >
      <Editor initialFile="settings" height="calc(75vh - 6rem)"></Editor>
    </EditorContextProvider>
  </div>

export default Settings
