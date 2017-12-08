import React, { Component } from 'react'
import PropTypes from 'prop-types'
import numeral from 'numeral'

import socket from '../../../socket'

import MatchDetails from '../components/MatchDetails'
import BettingProgress from '../components/BettingProgress'

import BettingAPI from '../services/API'

export default class BettingContainer extends Component {
  constructor () {
    super()

    this.state = {
      firstCompetitorBets: 0.00,
      secondCompetitorBets: 0.00,
      connected: false
    }
  }

  componentWillMount () {
    const { firstCompetitorBets, secondCompetitorBets } = this.props

    this.setState({
      firstCompetitorBets: firstCompetitorBets,
      secondCompetitorBets: secondCompetitorBets
    })
  }

  componentDidMount () {
    const { match } = this.props

    const channel = socket.channel(`match:${match.id}`)

    channel.join()
      .receive('ok', (response) => { this.setState({connected: true}) })
      .receive('error', (reason) => { console.error(reason) })

    channel.on('update_price', ({amount, competitor_id}) => { 
      this.updateTotalBets(parseFloat(amount), this.figureCompetitorFlag(competitor_id))
    })
  }

  figureCompetitorFlag (competitorId) {
    const { competitor_1, competitor_2 } = this.props.match

    if (competitor_1.id === competitorId) {
      return "A"
    } else if (competitor_2.id === competitorId) {
      return "B"
    }
  }

  updateTotalBets(amount, competitor) {
    const { firstCompetitorBets, secondCompetitorBets } = this.state

    if (competitor === "A") {
      this.setState({firstCompetitorBets: firstCompetitorBets + amount})
    } else if (competitor === "B") {
      this.setState({secondCompetitorBets: secondCompetitorBets + amount})
    }
  }

  handleBet ({amount, competitorId, competitorFlag}) {
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
        onSendNotification( { message: `Submitted a ${numeral(amount).format("$0,0.00")} bet`, status: "success" })
      },
      onError: (message) => { 
        onSendNotification({message: message, status: "danger"}) 
      }
    })
  }

  render () {
    const { match } = this.props
    const { firstCompetitorBets, secondCompetitorBets, connected } = this.state

    return (
      <div>
        <MatchDetails 
          onBetSubmit={ (args) => this.handleBet(args) }
          firstCompetitor={ match.competitor_1 }
          secondCompetitor={ match.competitor_2 }
          title={ match.title }
          connected={ connected }
          gameName={ match.game_name }/>
        <BettingProgress
          firstBets={ firstCompetitorBets }
          secondBets={ secondCompetitorBets }/>
      </div>
    )
  }
}

BettingContainer.propTypes = {
  match: PropTypes.object.isRequired,
  currentUser: PropTypes.object.isRequired,
  firstCompetitorBets: PropTypes.number.isRequired,
  secondCompetitorBets: PropTypes.number.isRequired
}

