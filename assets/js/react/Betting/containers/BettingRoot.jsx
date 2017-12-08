import React, { Component } from 'react'
import PropTypes from 'prop-types'

import NotificationContainer from '../../Notification/containers/NotificationContainer'
import BettingContainer from './BettingContainer'

export default class BettingRoot extends Component {
  constructor () {
    super() 

    this.state = {
      match: {},
      messages: []
    }
  }

  handleNotification (message) {
    const { messages } = this.state

    this.setState({ messages: messages.concat(message) })
  }

  componentWillMount () {
    const { match } = this.props

    this.setState({ match: match })
  }

  render () {
    const { match, messages } = this.state
    const { currentUser, firstCompetitorBets, secondCompetitorBets } = this.props

    return (
      <div className="container -centerify">
        <NotificationContainer
          messages={ messages }/>
        <BettingContainer
          onSendNotification={ (message) => { this.handleNotification(message) } } 
          firstCompetitorBets={ firstCompetitorBets }
          secondCompetitorBets={ secondCompetitorBets }
          currentUser={ currentUser }
          match={ match }/>
      </div>
    )
  }
}
