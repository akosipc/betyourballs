import React, { Component } from 'react'
import PropTypes from 'prop-types'

import MatchDetails from '../components/MatchDetails'
import BettingProgress from '../components/BettingProgress'

export default class BettingContainer extends Component {
  render () {
    return (
      <div>
        <MatchDetails/>
        <BettingProgress/>
      </div>
    )
  }
}

BettingContainer.propTypes = {
  match: PropTypes.object.isRequired,
  betProgress: PropTypes.object.isRequired
}

