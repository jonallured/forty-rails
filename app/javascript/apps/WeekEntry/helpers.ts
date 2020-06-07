import { FortyTime } from "forty-time"
import { WorkDay, WorkWeek } from "./"

interface RawWorkDay {
  adjustMinutes: number
  dayOfWeek: string
  id: number
  inMinutes: number
  outMinutes: number
  ptoMinutes: number
}

export const convertToTimes = (workDays: RawWorkDay[]): WorkDay[] => {
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
    const total = outTime.minus(inTime).plus(ptoTime).plus(adjustTime)
    const totalMinutes = Math.max(0, total.minutes)
    const totalTime = FortyTime.parse(totalMinutes)

    return {
      ...workDay,
      totalTime,
    }
  })
}

export const calculateTotal = (workDays: WorkDay[]): FortyTime => {
  const totalMinutes = workDays
    .map((w) => w.totalTime.minutes)
    .reduce((a, b) => a + b, 0)
  return FortyTime.parse(totalMinutes)
}

export const calculatePace = (total: FortyTime, target: FortyTime): string => {
  const difference = total.minus(target)
  if (difference.minutes === 0) return "even"

  return difference.toString()
}

interface WeekToDate {
  target: FortyTime
  total: FortyTime
}

const calculateWeekToDate = (
  workDays: WorkDay[],
  weekToDateIds: number[]
): WeekToDate => {
  const targetMinutes = weekToDateIds.length * 8 * 60
  const target = FortyTime.parse(targetMinutes)

  const weekToDateDays = workDays.filter((day) => {
    return weekToDateIds.includes(day.id)
  })

  const total = calculateTotal(weekToDateDays)

  return {
    target,
    total,
  }
}

export const calculate = (workWeek: WorkWeek): WorkWeek => {
  const workDays = calculateWorkDays(workWeek.workDays)
  const grandTotal = calculateTotal(workDays)
  const weekToDate = calculateWeekToDate(workDays, workWeek.weekToDateIds)
  const pace = calculatePace(weekToDate.total, weekToDate.target)

  return {
    ...workWeek,
    grandTotal,
    pace,
    workDays,
  }
}

export const recalculate = (
  id: number,
  key: string,
  value: number,
  workWeek: WorkWeek
): WorkWeek => {
  const workDay = workWeek.workDays.find((w) => w.id === id)
  workDay[key] = FortyTime.parse(value)
  const updatedWorkWeek = calculate(workWeek)
  return updatedWorkWeek
}
