import React from 'react'
import { render } from 'react-dom'

import BettingRoot from './Betting/containers/BettingRoot'

const App = {}

App.bettingMount = () => {
  const elem = document.getElementById('betting-mount')

  render(
    <BettingRoot
      match={JSON.parse(elem.getAttribute('data-match'))} />,
    elem
  )
}

export default App
