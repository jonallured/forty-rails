import React, { useState } from "react"
import { FortyTime } from "forty-time"

const pattern = /^[-0-9:]*$/

export interface TimeInputProps {
  autoFocus: boolean
  handleWorkDayUpdate: (id, key, value) => void
  id: number
  placeholder: string
  property: string
  time: FortyTime
}

export const TimeInput: React.FC<TimeInputProps> = (props) => {
  const { autoFocus, handleWorkDayUpdate, id, placeholder, property, time } =
    props

  const [value, setValue] = useState(time.toString())

  const name = [id, property].join(".")

  const handleBlur = (e): void => {
    const newTime = FortyTime.parse(e.target.value)
    setValue(newTime.toString())
    handleWorkDayUpdate(id, property, newTime.value)
  }

  const handleChange = (e): void => {
    const newValue = e.target.value

    if (newValue.match(pattern) && newValue.length < 7) {
      setValue(newValue)
    }
  }

  const handleKeyUp = (e): void => {
    if (e.keyCode === 13 || e.keyCode === 27) {
      e.target.blur()
      e.target.select()
    }
  }

  return (
    <input
      autoFocus={autoFocus}
      name={name}
      onBlur={handleBlur}
      onChange={handleChange}
      onKeyUp={handleKeyUp}
      placeholder={placeholder}
      type="text"
      value={value}
    />
  )
}
