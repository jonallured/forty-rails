import { BaseFetcher, ResponseJson } from "../../shared/BaseFetcher"

export class UpgradeFormFetcher extends BaseFetcher {
  createUpgrade = (sourceId): ResponseJson => {
    const url = "/upgrade.json"
    const body = { stripe_source_id: sourceId } // eslint-disable-line @typescript-eslint/camelcase
    return this.sendRequest(url, "POST", body)
  }
}
