import React, { Component } from 'react'
import PropTypes from 'prop-types'

export default class Notification extends Component {
  render () {
    const { message } = this.props

    return (
      <div className="notification -success">
        { message }
      </div>
    )
  }
}

Notification.propTypes = {
  message: PropTypes.string.isRequired
}
