# Copyright (c) 2022 Ivan Teplov

import React from "react"
import NavigationBar from "./components/NavigationBar"
import { Editor, EditorContextProvider } from "./components/Editor"

export App = ->
  <div className="App fill column">
    <NavigationBar />
    <EditorContextProvider>
      <Editor />
    </EditorContextProvider>
  </div>

export default App
