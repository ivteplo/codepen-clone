# Copyright (c) 2022 Ivan Teplov

import React from "react"

export usePreferredMode = ->
  media = window.matchMedia "(prefers-color-scheme: dark)"

  getTheme = -> media.matches ? "dark" : "light"

  [mode, setMode] = React.useState getTheme()

  onChange = ->
    setMode getTheme()

  media.addEventListener "change", onChange
  return mode

export default usePreferredMode
