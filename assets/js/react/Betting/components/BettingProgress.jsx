import React, { Component } from 'react'
import PropTypes from 'prop-types'
import numeral from 'numeral'

import BettingBar from './BettingBar'

export default class BettingProgress extends Component {
  calculateBarWidth (amount) {
    const { firstBets, secondBets } = this.props
    let value = amount / (firstBets + secondBets) * 100 / 2

    return value >= 10 ? value : 10.00
  }

  render () {
    const { firstBets, secondBets } = this.props

    return (
      <div className="betting-progress">
        <div className="header">
          Betting Progress
        </div>
        <div className="progress-bar">
          <BettingBar
            amount={ firstBets }  
            barWidth={ this.calculateBarWidth(firstBets) } />
          <BettingBar
            amount={ secondBets } 
            barWidth={ this.calculateBarWidth(secondBets) } />
        </div>
      </div>
    )
  }
}

BettingProgress.propTypes = {
  firstBets: PropTypes.number.isRequired,
  secondBets: PropTypes.number.isRequired
}
