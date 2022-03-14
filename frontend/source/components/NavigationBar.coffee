# Copyright (c) 2022 Ivan Teplov

import React from "react"
import "./NavigationBar.css"

export NavigationBar = ->
  <nav className="NavigationBar row">
    <h1>Code</h1>

    <div className="row NavigationBarMenu">
      <button className="primary" type="button">Settings</button>
    </div>
  </nav>

export default NavigationBar
