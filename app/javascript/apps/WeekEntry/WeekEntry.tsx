import React from "react"
import { WeekColumn, WorkDayData } from "./components/WeekColumn"
import { Header } from "./components/Header"
import { WeekEntryFetcher } from "./WeekEntryFetcher"
import { FortyTime } from "forty-time"

interface WorkDay {
  adjustMinutes: number
  dayOfWeek: string
  id: number
  inMinutes: number
  outMinutes: number
  ptoMinutes: number
}

export interface WorkWeek {
  dateSpan: string
  workDays: WorkDay[]
}

export interface WeekEntryProps {
  fetcher: WeekEntryFetcher
  lastWeekPath: string
  nextWeekPath: string
  thisWeekPath: string
  workWeek: WorkWeek
}

const computeWorkDayData = (workDay: WorkDay): WorkDayData => {
  return {
    adjustAmount: FortyTime.parse(workDay.adjustMinutes).toString(),
    dayOfWeek: workDay.dayOfWeek,
    id: workDay.id,
    inTime: FortyTime.parse(workDay.inMinutes).toString(),
    outTime: FortyTime.parse(workDay.outMinutes).toString(),
    ptoAmount: FortyTime.parse(workDay.ptoMinutes).toString(),
  }
}

export const WeekEntry: React.FC<WeekEntryProps> = (props) => {
  const { lastWeekPath, nextWeekPath, thisWeekPath, workWeek } = props

  const handleWorkDayUpdate = (id, key, value): void => {
    const body = { [key]: value }
    props.fetcher.updateWorkDay(id, body)
  }

  const weekColumns = workWeek.workDays.map((workDay) => {
    const workDayData = computeWorkDayData(workDay)
    return (
      <WeekColumn
        handleWorkDayUpdate={handleWorkDayUpdate}
        key={workDay.id}
        workDay={workDayData}
      />
    )
  })

  return (
    <>
      <Header
        dateSpan={workWeek.dateSpan}
        lastWeekPath={lastWeekPath}
        nextWeekPath={nextWeekPath}
        thisWeekPath={thisWeekPath}
      />
      <div className="table">{weekColumns}</div>
    </>
  )
}
