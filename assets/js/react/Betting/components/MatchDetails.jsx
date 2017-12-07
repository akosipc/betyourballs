import React, { Component } from 'react'
import PropTypes from 'prop-types'

export default class MatchDetails extends Component {
  handleBettingSubmit (evt, {competitorId, targetRef}) {
    const { onBetSubmit } = this.props
    const { betAmountRef } = this.refs

    evt.preventDefault()

    onBetSubmit({amount: targetRef.value})

    targetRef.value = ""
  }

  renderBettingActions({ id }) {
    let betAmountRef

    return (
      <form onSubmit={ (evt) => { this.handleBettingSubmit(evt, { competitorId: id, targetRef: betAmountRef }) } }>
        <input 
          ref={ (el) => { betAmountRef = el } }
          type="number" 
          min="0"
          step="any"/>
      </form>
    )
  }

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
            { this.renderBettingActions(firstCompetitor) }
          </div>
          <div className="competitor">
            { this.renderCompetitor(secondCompetitor) }
            { this.renderBettingActions(secondCompetitor) }
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
