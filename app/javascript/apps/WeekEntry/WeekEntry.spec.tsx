import React from "react"
import { mount } from "enzyme"
import { WeekEntry, WeekEntryProps } from "./"

const defaultWorkDays = [
  {
    adjustMinutes: 0,
    dayOfWeek: "Monday",
    inMinutes: 540,
    outMinutes: 1020,
    ptoMinutes: 0
  },
  {
    adjustMinutes: 0,
    dayOfWeek: "Tuesday",
    inMinutes: 540,
    outMinutes: 1020,
    ptoMinutes: 0
  },
  {
    adjustMinutes: 0,
    dayOfWeek: "Wednesday",
    inMinutes: 540,
    outMinutes: 1020,
    ptoMinutes: 0
  },
  {
    adjustMinutes: 0,
    dayOfWeek: "Thursday",
    inMinutes: 540,
    outMinutes: 1020,
    ptoMinutes: 0
  },
  {
    adjustMinutes: 0,
    dayOfWeek: "Friday",
    inMinutes: 540,
    outMinutes: 1020,
    ptoMinutes: 0
  }
]

const defaultProps: WeekEntryProps = {
  dates: "Feb 17-21, 2020",
  workWeek: { workDays: defaultWorkDays }
}

describe("WeekEntry", () => {
  it("renders 5 columns", () => {
    const props = {
      ...defaultProps
    }
    const wrapper = mount(<WeekEntry {...props} />)
    expect(wrapper.find("WeekColumn")).toHaveLength(5)
  })
})
