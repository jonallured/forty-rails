import React, { useState } from "react"
import { FortyTime } from "forty-time"

const pattern = /^[-0-9:]*$/

const EnterKeyCode = 13
const EscKeyCode = 27

const CommitKeyCodes = [EnterKeyCode, EscKeyCode]

export interface TimeInputProps {
  handleWorkDayUpdate: (id, key, value) => void
  id: number
  placeholder: string
  property: string
  time: FortyTime
}

export const TimeInput: React.FC<TimeInputProps> = (props) => {
  const { handleWorkDayUpdate, id, placeholder, property, time } = props

  const [value, setValue] = useState(time.toString())

  const name = [id, property].join(".")

  const handleBlur = (e): void => {
    const newTime = FortyTime.parse(e.target.value)
    setValue(newTime.toString())
    handleWorkDayUpdate(id, property, newTime.minutes)
  }

  const handleChange = (e): void => {
    const newValue = e.target.value

    if (newValue.match(pattern) && newValue.length < 7) {
      setValue(newValue)
    }
  }

  const handleKeyUp = (e): void => {
    if (CommitKeyCodes.includes(e.keyCode)) {
      e.target.blur()
      e.target.select()
    }
  }

  return (
    <input
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
