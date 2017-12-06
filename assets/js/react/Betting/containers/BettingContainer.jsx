import React, { Component } from 'react'
import PropTypes from 'prop-types'

import MatchDetails from '../components/MatchDetails'
import BettingProgress from '../components/BettingProgress'

export default class BettingContainer extends Component {
  render () {
    const { match } = this.props

    return (
      <div>
        <MatchDetails 
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
}

