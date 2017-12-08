import React, { Component } from 'react'
import PropTypes from 'prop-types'
import numeral from 'numeral'

export default class BettingBar extends Component {
  render () {
    const { amount, barWidth } = this.props 

    return (
      <div className="bar" style={{ width: `${barWidth}%` }}>
        { numeral(amount).format("$0,0.00") }
      </div>
    )
  }
}

BettingBar.propTypes = {
  amount: PropTypes.number.isRequired,
  barWidth: PropTypes.number.isRequired
}
