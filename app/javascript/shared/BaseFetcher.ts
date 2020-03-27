export type RequestBody = object | object[]
export type ResponseJson = Promise<object | object[]>

const jsonContentType = "application/json"

export class BaseFetcher {
  token: string

  constructor(token: string) {
    this.token = token
  }

  sendRequest = (
    url: string,
    method: string,
    body?: RequestBody
  ): ResponseJson => {
    const headers = {
      Accept: jsonContentType,
      "Content-Type": "application/json",
      "X-CSRF-TOKEN": this.token,
    }

    const credentials: RequestCredentials = "same-origin"

    const options = {
      body: JSON.stringify(body),
      credentials,
      headers,
      method,
    }

    return fetch(url, options).then((response) => {
      if (!response.ok) throw new Error("non 200 response")

      const contentType = response.headers.get("Content-Type")

      if (contentType && contentType.match(jsonContentType)) {
        return response.json()
      } else {
        return response.text()
      }
    })
  }
}
