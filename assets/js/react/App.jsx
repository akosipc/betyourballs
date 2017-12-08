import React from 'react'
import { render } from 'react-dom'

import BettingRoot from './Betting/containers/BettingRoot'

const App = {}

const defaultAsZero = (value) => { return value === "" ? 0 : parseFloat(value) }

App.bettingMount = () => {
  const elem = document.getElementById('betting-mount')

  render(
    <BettingRoot
      match={JSON.parse(elem.getAttribute('data-match'))} 
      firstCompetitorBets={defaultAsZero(elem.getAttribute('data-competitor1-amount'))}
      secondCompetitorBets={defaultAsZero(elem.getAttribute('data-competitor2-amount'))}
      currentUser={JSON.parse(elem.getAttribute('data-current-user'))} />,
    elem
  )
}

export default App
