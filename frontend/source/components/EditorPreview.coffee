# Copyright (c) 2022 Ivan Teplov

import React from "react"
import "./EditorPreview.css"
import classNames from "classnames"

encodeFile = (contentType, contents) ->
  "data:#{contentType};base64,#{btoa contents}"

export EditorPreview = ({ files, className, ...props }) ->
  # TODO: add support for displaying console messages in a separate 'popup'

  css = encodeFile "text/css", files.CSS.value

  js = encodeFile "text/javascript", files.JavaScript.value

  html = encodeFile "text/html", """
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="#{css}">
    <script defer src="#{js}"></script>
    #{files.HTML.value}
  """

  classes = classNames "EditorPreview fill", className

  <iframe {...props} src={html} className={classes}>
    {files.HTML.value}
  </iframe>

export default EditorPreview
