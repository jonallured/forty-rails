import React from "react"

export interface HeaderProps {
  dateSpan: string
  lastWeekPath: string
  nextWeekPath: string
  thisWeekPath: string
}

export const Header: React.FC<HeaderProps> = (props) => {
  const { dateSpan, lastWeekPath, nextWeekPath, thisWeekPath } = props

  return (
    <nav>
      <p>{dateSpan}</p>
      <div>
        <a href={lastWeekPath}>&lt;</a>
        <a href={thisWeekPath}>this week</a>
        <a href={nextWeekPath}>&gt;</a>
      </div>
    </nav>
  )
}
