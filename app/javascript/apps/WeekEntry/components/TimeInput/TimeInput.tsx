import React from "react"
import { FortyTime } from "forty-time"

export interface TimeInputProps {
  handleWorkDayUpdate: (id, key, value) => void
  id: number
  placeholder: string
  property: string
  time: FortyTime
}

export const TimeInput: React.FC<TimeInputProps> = (props) => {
  const { handleWorkDayUpdate, id, placeholder, property, time } = props

  const name = [id, property].join(".")
  const value = time.toString()

  const handleChange = (e): void => {
    const newTime = FortyTime.parse(e.target.value)
    handleWorkDayUpdate(id, property, newTime.minutes)
  }

  return (
    <input
      defaultValue={value}
      name={name}
      onChange={handleChange}
      placeholder={placeholder}
      type="text"
    />
  )
}
