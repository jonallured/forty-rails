import React from "react"
import ReactDOM from "react-dom"
import { WeekEntry, WeekEntryProps } from "../apps/WeekEntry"
import { WeekEntryFetcher } from "../apps/WeekEntry/WeekEntryFetcher"

document.addEventListener("DOMContentLoaded", () => {
  const root = document.getElementById("week_entry_root")
  const parsedProps = JSON.parse(root.dataset.props)

  const metaTag = document.querySelector("meta[name=csrf-token]")
  const token = metaTag && metaTag.getAttribute("content")
  const fetcher = new WeekEntryFetcher(token)

  const props: WeekEntryProps = {
    ...parsedProps,
    fetcher
  }

  ReactDOM.render(<WeekEntry {...props} />, root)
})
