import React from "react"
import ReactDOM from "react-dom"
import { calculateDayTotal, WeekEntry, WeekEntryProps } from "../apps/WeekEntry"
import { WeekEntryFetcher } from "../apps/WeekEntry/WeekEntryFetcher"
import { FortyTime } from "forty-time"

document.addEventListener("DOMContentLoaded", () => {
  const root = document.getElementById("week_entry_root")
  const parsedProps = JSON.parse(root.dataset.props)

  const metaTag = document.querySelector("meta[name=csrf-token]")
  const token = metaTag && metaTag.getAttribute("content")
  const fetcher = new WeekEntryFetcher(token)

  const upgradedWorkDays = parsedProps.workWeek.workDays.map((workDay) => {
    const {
      adjustMinutes,
      dayOfWeek,
      id,
      inMinutes,
      outMinutes,
      ptoMinutes,
    } = workDay
    const adjustTime = FortyTime.parse(adjustMinutes)
    const inTime = FortyTime.parse(inMinutes)
    const outTime = FortyTime.parse(outMinutes)
    const ptoTime = FortyTime.parse(ptoMinutes)
    const totalTime = calculateDayTotal(adjustTime, inTime, outTime, ptoTime)

    return {
      adjustTime,
      dayOfWeek,
      id,
      inTime,
      outTime,
      ptoTime,
      totalTime,
    }
  })

  const grandTotalMinutes = upgradedWorkDays
    .map((w) => w.totalTime.minutes)
    .reduce((a, b) => a + b)
  const grandTotal = FortyTime.parse(grandTotalMinutes)
  const pace = "even"

  const props: WeekEntryProps = {
    ...parsedProps,
    fetcher,
    workWeek: {
      ...parsedProps.workWeek,
      grandTotal,
      pace,
      workDays: upgradedWorkDays,
    },
  }

  ReactDOM.render(<WeekEntry {...props} />, root)
})
