import React from "react"
import ReactDOM from "react-dom"
import { WeekEntry, WeekEntryProps } from "../apps/WeekEntry"

document.addEventListener("DOMContentLoaded", () => {
  const root = document.getElementById("week_entry_root")
  const props: WeekEntryProps = JSON.parse(root.dataset.props)
  ReactDOM.render(<WeekEntry {...props} />, root)
})
