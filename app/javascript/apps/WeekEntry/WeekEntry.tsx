import React from "react"
import { WeekColumn, WorkDayData } from "./components/WeekColumn"
import { FortyTime } from "forty-time"

interface WorkDay {
  adjustMinutes: number
  dayOfWeek: string
  inMinutes: number
  outMinutes: number
  ptoMinutes: number
}

interface WorkWeek {
  workDays: WorkDay[]
}

export interface WeekEntryProps {
  dates: string
  workWeek: WorkWeek
}

const computeWorkDayData = (workDay: WorkDay): WorkDayData => {
  return {
    adjustAmount: FortyTime.parse(workDay.adjustMinutes).toString(),
    dayOfWeek: workDay.dayOfWeek,
    inTime: FortyTime.parse(workDay.inMinutes).toString(),
    outTime: FortyTime.parse(workDay.outMinutes).toString(),
    ptoAmount: FortyTime.parse(workDay.ptoMinutes).toString()
  }
}

export const WeekEntry: React.FC<WeekEntryProps> = props => {
  const { dates, workWeek } = props
  const weekColumns = workWeek.workDays.map((workDay, index) => {
    const workDayData = computeWorkDayData(workDay)
    return <WeekColumn key={index} workDay={workDayData} />
  })
  return (
    <>
      <h1>{dates}</h1>
      <div className="table">{weekColumns}</div>
    </>
  )
}
