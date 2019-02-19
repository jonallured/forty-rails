import React from 'react'
import ReactDOM from 'react-dom'

import { App } from 'apps/hello/App'

document.addEventListener('DOMContentLoaded', () => {
  const root = document.getElementById("root")
  const props = JSON.parse(root.dataset.bootstrap)
  ReactDOM.render(<App {...props} />, root)
})
