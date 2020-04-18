import React from "react"
import { WorkDay } from "../../WeekEntry"
import { FortyTime } from "forty-time"

export interface WeekColumnProps {
  handleWorkDayUpdate: (id, key, value) => void
  workDay: WorkDay
}

export const WeekColumn: React.FC<WeekColumnProps> = (props) => {
  const { workDay } = props
  const shortDay = workDay.dayOfWeek.substring(0, 3)
  const prefix = workDay.id

  const handleChange = (e): void => {
    const { name, value } = e.target
    const [id, key] = name.split(".")
    const minutes = FortyTime.parse(value).minutes

    props.handleWorkDayUpdate(id, key, minutes)
  }

  return (
    <section>
      <p>{shortDay}</p>
      <input
        defaultValue={workDay.inTime.toString()}
        name={`${prefix}.inTime`}
        onChange={handleChange}
        placeholder="in"
        type="text"
      />
      <input
        defaultValue={workDay.outTime.toString()}
        name={`${prefix}.outTime`}
        onChange={handleChange}
        placeholder="out"
        type="text"
      />
      <input
        defaultValue={workDay.ptoTime.toString()}
        name={`${prefix}.ptoTime`}
        onChange={handleChange}
        placeholder="pto"
        type="text"
      />
      <input
        defaultValue={workDay.adjustTime.toString()}
        name={`${prefix}.adjustTime`}
        onChange={handleChange}
        placeholder="adjust"
        type="text"
      />
      <p className={`total_${prefix} total`}>{workDay.totalTime.toString()}</p>
    </section>
  )
}
