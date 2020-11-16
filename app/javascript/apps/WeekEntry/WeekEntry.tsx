import React, { useState } from "react"
import { WeekColumn } from "./components/WeekColumn"
import { Header } from "./components/Header"
import { WeekEntryFetcher } from "./WeekEntryFetcher"
import { FortyTime } from "forty-time"
import { recalculate } from "./helpers"

const Nudge = () => {
  return (
    <p className="nudge">
      Free accounts only have access to the current and previous week -{" "}
      <a href="/upgrade">upgrade your account</a>!
    </p>
  )
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
  grandTotal: FortyTime
  pace: string
  weekToDateIds: number[]
  workDays: WorkDay[]
}

export interface User {
  isFree: boolean
}

export interface WeekEntryProps {
  fetcher: WeekEntryFetcher
  lastWeekPath: string
  nextWeekPath: string
  thisWeekPath: string
  workWeek: WorkWeek
  user: User
}

const keyToAttributeMap = {
  adjustTime: "adjust_minutes",
  inTime: "in_minutes",
  outTime: "out_minutes",
  ptoTime: "pto_minutes",
}

export const WeekEntry: React.FC<WeekEntryProps> = (props) => {
  const { lastWeekPath, nextWeekPath, thisWeekPath, user } = props
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

  const showNudge = user.isFree

  return (
    <>
      <Header
        lastWeekPath={lastWeekPath}
        nextWeekPath={nextWeekPath}
        thisWeekPath={thisWeekPath}
        workWeek={workWeek}
      />
      {showNudge && <Nudge />}
      <div className="table">{weekColumns}</div>
    </>
  )
}
