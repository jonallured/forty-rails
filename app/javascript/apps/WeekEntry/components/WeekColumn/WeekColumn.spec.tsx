import React from "react"
import { mount } from "enzyme"
import { WeekColumn, WeekColumnProps } from "./"

describe("WeekColumn", () => {
  it("renders a bunch of inputs", () => {
    const props: WeekColumnProps = {
      day: "Monday"
    }
    const wrapper = mount(<WeekColumn {...props} />)
    expect(wrapper.find("input")).toHaveLength(4)
  })
})
