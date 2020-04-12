import React from "react"

export interface HeaderProps {
  dateSpan: string
}

export const Header: React.FC<HeaderProps> = props => {
  const { dateSpan } = props

  return (
    <nav>
      <p>{dateSpan}</p>
    </nav>
  )
}
