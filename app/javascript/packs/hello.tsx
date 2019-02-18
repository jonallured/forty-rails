import React from 'react'
import ReactDOM from 'react-dom'

import { App } from 'apps/hello/App'

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <App name="Jon" />,
    document.body.appendChild(document.createElement('div'))
  )
})
