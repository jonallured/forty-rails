import React from "react"
import ReactDOM from "react-dom"
import { UpgradeFormFetcher } from "../apps/UpgradeForm/UpgradeFormFetcher"
import { UpgradeForm, UpgradeFormProps } from "../apps/UpgradeForm"

document.addEventListener("DOMContentLoaded", () => {
  const root = document.getElementById("upgrade_form_root")
  const parsedProps = JSON.parse(root.dataset.props)

  const metaTag = document.querySelector("meta[name=csrf-token]")
  const token = metaTag && metaTag.getAttribute("content")
  const fetcher = new UpgradeFormFetcher(token)
  const honeybadger = window["Honeybadger"]

  const props: UpgradeFormProps = {
    ...parsedProps,
    fetcher,
    honeybadger,
  }

  ReactDOM.render(<UpgradeForm {...props} />, root)
})
