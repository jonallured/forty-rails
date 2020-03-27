import React from "react"
import { mount } from "enzyme"
import { WeekColumn, WeekColumnProps } from "./"

const defaultWorkDay = {
  adjustAmount: "0:00",
  dayOfWeek: "Monday",
  inTime: "8:00",
  outTime: "17:00",
  ptoAmount: "0:00",
}

const defaultProps: WeekColumnProps = {
  workDay: defaultWorkDay,
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
