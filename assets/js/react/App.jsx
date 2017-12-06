import React from 'react'
import { render } from 'react-dom'

import BettingContainer from './Betting/containers/BettingContainer'

const App = {}

App.bettingMount = () => {
  const elem = document.getElementById('betting-mount')

  render(
    <BettingContainer 
      match={JSON.parse(elem.getAttribute('datamatch'))} />,
    elem
  )
}

export default App
