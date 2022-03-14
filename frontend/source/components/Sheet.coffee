# Copyright (c) 2022 Ivan Teplov

import React from "react"
import classNames from "classnames"

import { EditorContextProvider } from "../contexts/EditorContext"
import "./Sheet.css"

export Sheet = ({ isOpen, contentsStyle = {}, className, onHide, children, ...props }) ->
  classes = classNames "Sheet column", {
    open: !!isOpen
  }, className

  hide = ->
    onHide() if onHide instanceof Function

  <div {...props} className={classes} aria-hidden={isOpen ? "false" : "true"}>
    <div className="SheetOverlay" onClick={hide} />
    <div className="SheetContents column" style={contentsStyle}>
      <button
        type="button"
        className="SheetCloseButton"
        onClick={hide}
        title="Close"
      >
        &times;
      </button>
      {children}
    </div>
  </div>

export default Sheet
