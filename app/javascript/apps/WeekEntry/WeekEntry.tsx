import React from "react"
import { WeekColumn } from "./components/WeekColumn"

const days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]

export interface WeekEntryProps {
  dates: string
}

export const WeekEntry: React.FC<WeekEntryProps> = props => {
  const { dates } = props
  const weekColumns = days.map((day, index) => {
    return <WeekColumn key={index} day={day} />
  })
  return (
    <>
      <h1>{dates}</h1>
      {weekColumns}
    </>
  )
}
