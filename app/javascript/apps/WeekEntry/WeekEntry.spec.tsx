import React from "react"
import { mount } from "enzyme"
import { WeekEntry, WeekEntryProps, WorkDay } from "./"
import { WeekEntryFetcher } from "./WeekEntryFetcher"
import { FortyTime } from "forty-time"

export const defaultDay = {
  adjustTime: FortyTime.parse(0),
  inTime: FortyTime.parse(540),
  outTime: FortyTime.parse(1020),
  ptoTime: FortyTime.parse(0),
  totalTime: FortyTime.parse(0),
}

const defaultWorkDays: WorkDay[] = [
  {
    ...defaultDay,
    dayOfWeek: "Monday",
    id: 1,
  },
  {
    ...defaultDay,
    dayOfWeek: "Tuesday",
    id: 2,
  },
  {
    ...defaultDay,
    dayOfWeek: "Wednesday",
    id: 3,
  },
  {
    ...defaultDay,
    dayOfWeek: "Thursday",
    id: 4,
  },
  {
    ...defaultDay,
    dayOfWeek: "Friday",
    id: 5,
  },
]

const mockFetcher: WeekEntryFetcher = new WeekEntryFetcher("invalid")
mockFetcher.updateWorkDay = jest.fn()

const defaultProps: WeekEntryProps = {
  fetcher: mockFetcher,
  lastWeekPath: "",
  nextWeekPath: "",
  thisWeekPath: "",
  workWeek: {
    dateSpan: "Feb 17-21, 2020",
    grandTotal: FortyTime.parse(0),
    pace: "even",
    workDays: defaultWorkDays,
  },
}

describe("WeekEntry", () => {
  it("renders 5 columns", () => {
    const props = {
      ...defaultProps,
    }
    const wrapper = mount(<WeekEntry {...props} />)
    expect(wrapper.find("WeekColumn")).toHaveLength(5)
  })
})
