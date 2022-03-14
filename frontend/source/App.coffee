# Copyright (c) 2022 Ivan Teplov

import React from "react"
import localForage from "localForage"

import NavigationBar from "./components/NavigationBar"
import EditorPreview from "./components/EditorPreview"
import Settings from "./components/Settings"
import Editor from "./components/Editor"
import Sheet from "./components/Sheet"

import { EditorContextProvider } from "./contexts/EditorContext"

export App = ->
  [isSettingsModalOpen, setIsSettingsModalOpen] = React.useState no
  [editorSettings, setEditorSettings] = React.useState undefined
  [loadedSettings, setLoadedSettings] = React.useState no

  loadEditorSettings = ->
    setEditorSettings await localForage.getItem "editorSettings"
    setLoadedSettings yes

  React.useEffect loadEditorSettings, []

  openSettings = ->
    setIsSettingsModalOpen yes

  hideSettings = ->
    setIsSettingsModalOpen no

  onSave = ({ editorSettings, files }) ->
    if editorSettings
      await localForage.setItem "editorSettings", editorSettings

  <div className="App fill column">
    <NavigationBar onOpenSettings={openSettings} />

    {
      loadedSettings and
      <EditorContextProvider
        files={{
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
        }}
        editorSettings={editorSettings}
        onSave={onSave}
      >
        <Editor initialFile="HTML" />
        <EditorPreview />

        <Sheet
          isOpen={isSettingsModalOpen}
          onHide={hideSettings}
          contentsStyle={{
            minWidth: "90vw",
            minHeight: "75vh"
          }}
        >
          <Settings />
        </Sheet>
      </EditorContextProvider>
    }
  </div>

export default App
