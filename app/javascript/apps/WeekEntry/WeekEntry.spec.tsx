import React from "react"
import { mount } from "enzyme"
import { WeekEntry } from "./"

describe("WeekEntry", () => {
  it("renders 5 columns", () => {
    const wrapper = mount(<WeekEntry />)
    expect(wrapper.find("WeekColumn")).toHaveLength(5)
  })
})
