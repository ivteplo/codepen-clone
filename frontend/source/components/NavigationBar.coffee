# Copyright (c) 2022 Ivan Teplov

import React from "react"
import "./NavigationBar.css"
import classNames from "classnames"

export NavigationBar = ({ onOpenSettings, className, ...props }) ->
  classes = classNames "NavigationBar row", className

  openSettings = ->
    onOpenSettings() if onOpenSettings instanceof Function

  <nav className={classes}>
    <h1>Code</h1>

    <div className="row NavigationBarMenu">
      <button
        onClick={openSettings}
        className="primary"
        type="button"
      >
        Settings
      </button>
    </div>
  </nav>

export default NavigationBar
