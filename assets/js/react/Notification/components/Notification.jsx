import React, { Component } from 'react'
import PropTypes from 'prop-types'

export default class Notification extends Component {
  render () {
    const { message, status } = this.props

    return (
      <div className={ `notification -${ status }` }>
        { message }
      </div>
    )
  }
}

Notification.propTypes = {
  message: PropTypes.string.isRequired,
  status: PropTypes.string.isRequired
}
