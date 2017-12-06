import React, { Component } from 'react'
import PropTypes from 'prop-types'

export default class MatchDetails extends Component {
  renderCompetitor (competitor) {
    const { image_url, name } = competitor

    return (
      <div>
        <img src={ image_url }/>
        { name }
      </div>
    )
  }
  render () {
    const { title, gameName, firstCompetitor, secondCompetitor } = this.props
    return (
      <div className="match-details">
        <div className="header">
          { title }
          { gameName }
        </div>
        <div className="details">
          <div className="competitor">
            { this.renderCompetitor(firstCompetitor) }
          </div>
          <div className="competitor">
            { this.renderCompetitor(secondCompetitor) }
          </div>
        </div>
      </div>
    )
  }
}

MatchDetails.propTypes = {
  firstCompetitor: PropTypes.shape({
    id: PropTypes.string.isRequired,
    image_url: PropTypes.string.isRequired,
    name: PropTypes.string.isRequired
  }),
  secondCompetitor: PropTypes.shape({
    id: PropTypes.string.isRequired,
    image_url: PropTypes.string.isRequired,
    name: PropTypes.string.isRequired
  }),
  title: PropTypes.string.isRequired,
  gameName: PropTypes.string.isRequired
}
