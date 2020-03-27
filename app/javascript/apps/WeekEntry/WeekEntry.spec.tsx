import React from "react"
import { mount } from "enzyme"
import { WeekEntry, WeekEntryProps } from "./"
import { WeekEntryFetcher } from "./WeekEntryFetcher"

const defaultWorkDays = [
  {
    adjustMinutes: 0,
    dayOfWeek: "Monday",
    id: 1,
    inMinutes: 540,
    outMinutes: 1020,
    ptoMinutes: 0
  },
  {
    adjustMinutes: 0,
    dayOfWeek: "Tuesday",
    id: 2,
    inMinutes: 540,
    outMinutes: 1020,
    ptoMinutes: 0
  },
  {
    adjustMinutes: 0,
    dayOfWeek: "Wednesday",
    id: 3,
    inMinutes: 540,
    outMinutes: 1020,
    ptoMinutes: 0
  },
  {
    adjustMinutes: 0,
    dayOfWeek: "Thursday",
    id: 4,
    inMinutes: 540,
    outMinutes: 1020,
    ptoMinutes: 0
  },
  {
    adjustMinutes: 0,
    dayOfWeek: "Friday",
    id: 5,
    inMinutes: 540,
    outMinutes: 1020,
    ptoMinutes: 0
  }
]

const mockFetcher: WeekEntryFetcher = new WeekEntryFetcher("invalid")
mockFetcher.updateWorkDay = jest.fn()

const defaultProps: WeekEntryProps = {
  dates: "Feb 17-21, 2020",
  fetcher: mockFetcher,
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
