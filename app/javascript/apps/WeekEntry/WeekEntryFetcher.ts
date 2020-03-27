import { BaseFetcher, ResponseJson } from "../../shared/BaseFetcher"

export class WeekEntryFetcher extends BaseFetcher {
  updateWorkDay = (id, body): ResponseJson => {
    const url = `/work_days/${id}.json`
    return this.sendRequest(url, "PATCH", body)
  }
}
