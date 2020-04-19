import React, { useState } from "react"
import { WeekColumn } from "./components/WeekColumn"
import { Header } from "./components/Header"
import { WeekEntryFetcher } from "./WeekEntryFetcher"
import { FortyTime } from "forty-time"

export const calculateDayTotal = (
  adjustTime,
  inTime,
  outTime,
  ptoTime
): FortyTime => {
  const totalTime = outTime.minus(inTime).plus(ptoTime).plus(adjustTime)
  return totalTime
}

export interface WorkDay {
  adjustTime: FortyTime
  dayOfWeek: string
  id: number
  inTime: FortyTime
  outTime: FortyTime
  ptoTime: FortyTime
  totalTime: FortyTime
}

export interface WorkWeek {
  dateSpan: string
  grandTotal: string
  pace: string
  workDays: WorkDay[]
}

export interface WeekEntryProps {
  fetcher: WeekEntryFetcher
  lastWeekPath: string
  nextWeekPath: string
  thisWeekPath: string
  workWeek: WorkWeek
}

const keyToAttributeMap = {
  adjustTime: "adjust_minutes",
  inTime: "in_minutes",
  outTime: "out_minutes",
  ptoTime: "pto_minutes",
}

const recalculate = (id, key, value, workWeek): WorkWeek => {
  const updatedWorkWeek = {
    ...workWeek,
  }

  const workDay = updatedWorkWeek.workDays.find((w) => w.id.toString() === id)
  workDay[key] = FortyTime.parse(value)

  const { adjustTime, inTime, outTime, ptoTime } = workDay

  const updatedTotalTime = calculateDayTotal(
    adjustTime,
    inTime,
    outTime,
    ptoTime
  )
  workDay.totalTime = updatedTotalTime

  const grandTotalMinutes = updatedWorkWeek.workDays
    .map((w) => w.totalTime.minutes)
    .reduce((a, b) => a + b)
  const grandTotal = FortyTime.parse(grandTotalMinutes)
  updatedWorkWeek.grandTotal = grandTotal
  updatedWorkWeek.pace = "even"

  return updatedWorkWeek
}

export const WeekEntry: React.FC<WeekEntryProps> = (props) => {
  const { lastWeekPath, nextWeekPath, thisWeekPath } = props
  const [workWeek, setWorkWeek] = useState(props.workWeek)

  const handleWorkDayUpdate = (id, key, value): void => {
    const attribute = keyToAttributeMap[key]
    const body = { [attribute]: value }
    props.fetcher.updateWorkDay(id, body)

    const updatedWorkWeek = recalculate(id, key, value, workWeek)
    setWorkWeek(updatedWorkWeek)
  }

  const weekColumns = workWeek.workDays.map((workDay) => {
    return (
      <WeekColumn
        handleWorkDayUpdate={handleWorkDayUpdate}
        key={workDay.id}
        workDay={workDay}
      />
    )
  })

  return (
    <>
      <Header
        lastWeekPath={lastWeekPath}
        nextWeekPath={nextWeekPath}
        thisWeekPath={thisWeekPath}
        workWeek={workWeek}
      />
      <div className="table">{weekColumns}</div>
    </>
  )
}
