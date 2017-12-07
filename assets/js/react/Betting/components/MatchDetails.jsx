import React, { Component } from 'react'
import PropTypes from 'prop-types'

export default class MatchDetails extends Component {
  constructor () {
    super()

    this.state = {
      selectedCompetitor: undefined
    }
  }

  handleCompetitorSelection (id) {
    this.setState({ selectedCompetitor: id })
  }

  handleBettingSubmit (evt, {competitorId, targetRef}) {
    const { onBetSubmit } = this.props
    const { betAmountRef } = this.refs

    evt.preventDefault()

    onBetSubmit({amount: targetRef.value})

    targetRef.value = ""
  }

  renderBettingActions() {
    const { selectedCompetitor } = this.state

    let betAmountRef

    return (
      <form 
        className="form-horizontal"
        onSubmit={ (evt) => { this.handleBettingSubmit(evt, { competitorId: selectedCompetitor, targetRef: betAmountRef }) } }>
        <input 
          ref={ (el) => { betAmountRef = el } }
          type="number" 
          min="0"
          step="any"/>
        <button
          type="submit">
          Bet!
        </button>
      </form>
    )
  }

  renderCompetitor (competitor) {
    const { id, image_url, name } = competitor
    const { selectedCompetitor } = this.state

    return (
      <div 
        onClick={ () => { this.handleCompetitorSelection(id) } }
        className={ `competitor ${selectedCompetitor === id ? "-selected" : ""}` }>
        <img src={ image_url }/>
        { name }
      </div> 
    )
  }

  render () {
    const { title, gameName, firstCompetitor, secondCompetitor } = this.props
    const { selectedCompetitor } = this.state

    return (
      <div className="match-details">
        <div className="header">
          { title }
        </div>
        <div className="details">
          { this.renderCompetitor(firstCompetitor) }
          { this.renderCompetitor(secondCompetitor) }
        </div>
        <div className="actions">
          { this.renderBettingActions() }
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
