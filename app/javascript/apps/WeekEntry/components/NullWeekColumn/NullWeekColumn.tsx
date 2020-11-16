import React from "react"

interface NullWeekColumnProps {
  dayOfWeek: string
}

export const NullWeekColumn: React.FC<NullWeekColumnProps> = (props) => {
  return (
    <section className="nullWorkWeek">
      <p>{props.dayOfWeek}</p>
      <div className="wrapper inTime">
        <div className="inner" />
      </div>
      <div className="wrapper outTime">
        <div className="inner" />
      </div>
      <div className="wrapper ptoTime">
        <div className="inner" />
      </div>
      <div className="wrapper adjustTime">
        <div className="inner" />
      </div>
      <div className="wrapper total">
        <div className="inner" />
      </div>
    </section>
  )
}

const nullWorkDays = [
  { dayOfWeek: "Mon", id: 1 },
  { dayOfWeek: "Tue", id: 2 },
  { dayOfWeek: "Wed", id: 3 },
  { dayOfWeek: "Thu", id: 4 },
  { dayOfWeek: "Fri", id: 5 },
]

export const NullWeekColumns = nullWorkDays.map((nullWorkDay) => {
  const { dayOfWeek, id } = nullWorkDay
  return <NullWeekColumn key={id} dayOfWeek={dayOfWeek} />
})
