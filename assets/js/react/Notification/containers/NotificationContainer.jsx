import React, { Component } from 'react'
import PropTypes from 'prop-types'

import Notification from '../components/Notification'

export default class NotificationContainer extends Component {
  renderNotifications() {
    const { messages } = this.props

    return messages.map( (message, index) => {
      return (
        <Notification
          key={ index }
          status={ message.status }
          message={ message.message }/>
      )
    })
  }

  render () { 
    const { messages } = this.props

    return (
      <div className="notification-container">
        { messages.length === 0 ? "" :
          this.renderNotifications()
        }
      </div>
    )
  }
}

NotificationContainer.propTypes = {
  messages: PropTypes.array
}
