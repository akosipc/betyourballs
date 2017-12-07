import axios from 'axios'

const BettingAPI = {
  createBet({ data: data, onSuccess: onSuccess, onError: onError }) {
    const url = `${window.location.origin}/wormhole/bets`

    axios({
      method: "POST",
      url: url,
      data: { bet: data }
    }).then( (response) => {
      onSuccess(response)
    }).catch((error) => {
      const { errors } = error.response.data

      console.error(error.response)
      onError(errors[0][:message])
    })
  }
}

export default BettingAPI
