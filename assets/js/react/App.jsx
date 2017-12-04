import React from 'react'
import { render } from 'react-dom'

import BettingContainer from './Betting/containers/BettingContainer'

const App = {}

App.bettingMount = () => {
  render(
    <BettingContainer/>,
    document.getElementById('betting-mount')
  )
}

export default App
