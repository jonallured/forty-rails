import React from "react"
import { WorkWeek } from "../../WeekEntry"

export interface HeaderProps {
  lastWeekPath: string
  nextWeekPath: string
  thisWeekPath: string
  workWeek: WorkWeek
}

export const Header: React.FC<HeaderProps> = (props) => {
  const { lastWeekPath, nextWeekPath, thisWeekPath, workWeek } = props
  const { dateSpan, grandTotal, pace } = workWeek

  return (
    <nav>
      <div className="left">
        <h1 className="grand_total">{grandTotal.toString()}</h1>
        <p className="pace">{pace}</p>
      </div>
      <div className="right">
        <p>{dateSpan}</p>
        <div>
          <a className="button" href={lastWeekPath}>
            &lt;
          </a>
          <a className="button" href={thisWeekPath}>
            this week
          </a>
          <a className="button" href={nextWeekPath}>
            &gt;
          </a>
        </div>
      </div>
    </nav>
  )
}
