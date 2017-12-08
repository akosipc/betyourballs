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
    const { id } = this.props.firstCompetitor

    evt.preventDefault()

    onBetSubmit({
      amount: targetRef.value, 
      competitorId: competitorId,
      competitorFlag: competitorId === id ? "A" : "B"
    })

    targetRef.value = ""
    this.setState({selectedCompetitor: undefined})
  }

  renderBettingActions() {
    const { selectedCompetitor } = this.state

    let betAmountRef

    return (
      <form 
        className="form-horizontal"
        onSubmit={ (evt) => { this.handleBettingSubmit(evt, { competitorId: selectedCompetitor, targetRef: betAmountRef }) } }>
        <div className="form-group">
          <input 
            ref={ (el) => { betAmountRef = el } }
            disabled={ selectedCompetitor === undefined ? true : false }
            className="form-control"
            type="number" 
            min="0.01"
            step="any"/>
          <button
            disabled={ selectedCompetitor === undefined ? true : false }
            className="btn btn-primary"
            type="submit">
            Bet!
          </button>
        </div>
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
    const { title, gameName, firstCompetitor, secondCompetitor, connected } = this.props
    const { selectedCompetitor } = this.state

    return (
      <div className="match-details">
        <div className="header">
          { connected ?  
            <div className="connected-badge -connected">
            </div> 
            :
            <div className="connected-badge">
            </div>
          }
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
  gameName: PropTypes.string.isRequired,
  connected: PropTypes.bool
}
