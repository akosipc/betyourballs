import React, { Component } from 'react'
import PropTypes from 'prop-types'
import numeral from 'numeral'

import MatchDetails from '../components/MatchDetails'
import BettingProgress from '../components/BettingProgress'

export default class BettingContainer extends Component {
  handleBet ({amount}) {
    const { onSendNotification } = this.props

    onSendNotification(`Submitted a ${numeral(amount).format("$0,0.00")} bet`)
  }

  render () {
    const { match } = this.props

    return (
      <div>
        <MatchDetails 
          onBetSubmit={ (args) => this.handleBet(args) }
          firstCompetitor={ match.competitor_1 }
          secondCompetitor={ match.competitor_2 }
          title={ match.title }
          gameName={ match.game_name }/>
        <BettingProgress/>
      </div>
    )
  }
}

BettingContainer.propTypes = {
  match: PropTypes.object.isRequired,
}

