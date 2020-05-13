import React from "react"
import { WorkDay } from "../../WeekEntry"
import { TimeInput } from "../TimeInput"

export interface WeekColumnProps {
  handleWorkDayUpdate: (id, key, value) => void
  workDay: WorkDay
}

export const WeekColumn: React.FC<WeekColumnProps> = (props) => {
  const { workDay } = props
  const shortDay = workDay.dayOfWeek.substring(0, 3)

  const defaultInputProps = {
    handleWorkDayUpdate: props.handleWorkDayUpdate,
    id: workDay.id,
  }

  const shouldFocus = shortDay === "Mon"

  return (
    <section>
      <p>{shortDay}</p>
      <TimeInput
        {...defaultInputProps}
        autoFocus={shouldFocus}
        placeholder="in"
        property="inTime"
        time={workDay.inTime}
      />
      <TimeInput
        {...defaultInputProps}
        autoFocus={false}
        placeholder="out"
        property="outTime"
        time={workDay.outTime}
      />
      <TimeInput
        {...defaultInputProps}
        autoFocus={false}
        placeholder="pto"
        property="ptoTime"
        time={workDay.ptoTime}
      />
      <TimeInput
        {...defaultInputProps}
        autoFocus={false}
        placeholder="adjust"
        property="adjustTime"
        time={workDay.adjustTime}
      />
      <p className={`total_${workDay.id} total`}>
        {workDay.totalTime.toString()}
      </p>
    </section>
  )
}
