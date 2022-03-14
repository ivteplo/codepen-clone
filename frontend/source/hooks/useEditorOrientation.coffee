# Copyright (c) 2022 Ivan Teplov

import React from "react"

export useEditorOrientation = ->
  media = window.matchMedia "(min-width: 64rem)"

  getValue = -> if media.matches then "row" else "column"

  [value, setValue] = React.useState getValue()

  onChange = ->
    setValue getValue()

  media.addEventListener "change", onChange
  return value

export default useEditorOrientation
