import {
  BaseFetcher,
  ResponseJson,
  RequestBody,
} from "../../shared/BaseFetcher"

export class WeekEntryFetcher extends BaseFetcher {
  updateWorkDay = (id: string, body: RequestBody): ResponseJson => {
    const url = `/work_days/${id}.json`
    return this.sendRequest(url, "PATCH", body)
  }
}
