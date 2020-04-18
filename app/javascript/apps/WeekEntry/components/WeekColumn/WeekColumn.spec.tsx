import React from "react"
import { mount } from "enzyme"
import { WeekColumn, WeekColumnProps } from "./"
import { defaultDay } from "../../WeekEntry.spec"

const defaultProps: WeekColumnProps = {
  handleWorkDayUpdate: jest.fn(),
  workDay: {
    ...defaultDay,
    dayOfWeek: "Monday",
    id: 1,
  },
}

describe("WeekColumn", () => {
  it("renders a bunch of inputs", () => {
    const props: WeekColumnProps = {
      ...defaultProps,
    }
    const wrapper = mount(<WeekColumn {...props} />)
    expect(wrapper.find("input")).toHaveLength(4)
  })
})
