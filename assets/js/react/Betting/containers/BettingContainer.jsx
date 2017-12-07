import React, { Component } from 'react'
import PropTypes from 'prop-types'
import numeral from 'numeral'

import MatchDetails from '../components/MatchDetails'
import BettingProgress from '../components/BettingProgress'

import BettingAPI from '../services/API'

export default class BettingContainer extends Component {
  handleBet ({amount, competitorId}) {
    const { onSendNotification, currentUser } = this.props
    const { id } = this.props.match

    let data = {
      amount: parseFloat(amount),
      currency: "USD",
      status: "pending",
      match_id: id,
      user_id: currentUser.id,
      competitor_id: competitorId
    }

    BettingAPI.createBet({
      data: data,
      onSuccess: (response) => { 
        onSendNotification(
          {
            message: `Submitted a ${numeral(amount).format("$0,0.00")} bet`,
            status: "success"
          }
        )
      },
      onError: (message) => { 
        onSendNotification({message: message, status: "danger"}) 
      }
    })
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
  currentUser: PropTypes.object.isRequired,
  betProgress: PropTypes.object.isRequired
}

