import { FortyTime } from "forty-time"
import { WorkDay, WorkWeek } from "./"

export const convertToTimes = (workDays): WorkDay[] => {
  return workDays.map((workDay) => {
    return {
      adjustTime: FortyTime.parse(workDay.adjustMinutes),
      dayOfWeek: workDay.dayOfWeek,
      id: workDay.id,
      inTime: FortyTime.parse(workDay.inMinutes),
      outTime: FortyTime.parse(workDay.outMinutes),
      ptoTime: FortyTime.parse(workDay.ptoMinutes),
      totalTime: FortyTime.parse(0),
    }
  })
}

export const calculateWorkDays = (workDays: WorkDay[]): WorkDay[] => {
  return workDays.map((workDay) => {
    const { adjustTime, inTime, outTime, ptoTime } = workDay
    const totalTime = outTime.minus(inTime).plus(ptoTime).plus(adjustTime)

    return {
      ...workDay,
      totalTime,
    }
  })
}

export const calculateGrandTotal = (workDays: WorkDay[]): FortyTime => {
  const totalMinutes = workDays
    .map((w) => w.totalTime.minutes)
    .reduce((a, b) => a + b)
  return FortyTime.parse(totalMinutes)
}

export const calculatePace = (
  grandTotal: FortyTime,
  target: FortyTime
): string => {
  const difference = grandTotal.minus(target)
  if (difference.minutes === 0) return "even"

  return difference.toString()
}

export const calculate = (workWeek: WorkWeek): WorkWeek => {
  const workDays = calculateWorkDays(workWeek.workDays)
  const grandTotal = calculateGrandTotal(workDays)
  const target = FortyTime.parse("40:00")
  const pace = calculatePace(grandTotal, target)

  return {
    ...workWeek,
    grandTotal,
    pace,
    workDays,
  }
}

export const recalculate = (id, key, value, workWeek): WorkWeek => {
  const workDay = workWeek.workDays.find((w) => w.id.toString() === id)
  workDay[key] = FortyTime.parse(value)
  const updatedWorkWeek = calculate(workWeek)
  return updatedWorkWeek
}
