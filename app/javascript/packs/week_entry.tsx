import React from "react"
import ReactDOM from "react-dom"
import { WeekEntry, WeekEntryProps } from "../apps/WeekEntry"
import { calculate, convertToTimes } from "../apps/WeekEntry/helpers"
import { WeekEntryFetcher } from "../apps/WeekEntry/WeekEntryFetcher"

document.addEventListener("DOMContentLoaded", () => {
  const root = document.getElementById("week_entry_root")
  const parsedProps = JSON.parse(root.dataset.props)

  const metaTag = document.querySelector("meta[name=csrf-token]")
  const token = metaTag && metaTag.getAttribute("content")
  const fetcher = new WeekEntryFetcher(token)
  parsedProps.workWeek.workDays = convertToTimes(parsedProps.workWeek.workDays)
  const workWeek = calculate(parsedProps.workWeek)

  const props: WeekEntryProps = {
    ...parsedProps,
    fetcher,
    workWeek,
  }

  ReactDOM.render(<WeekEntry {...props} />, root)
})
