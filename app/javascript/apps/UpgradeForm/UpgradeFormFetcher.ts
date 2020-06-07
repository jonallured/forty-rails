import { BaseFetcher, ResponseJson } from "../../shared/BaseFetcher"

export class UpgradeFormFetcher extends BaseFetcher {
  createUpgrade = (sourceId: string): ResponseJson => {
    const url = "/upgrade.json"
    const body = { stripe_source_id: sourceId }
    return this.sendRequest(url, "POST", body)
  }
}
