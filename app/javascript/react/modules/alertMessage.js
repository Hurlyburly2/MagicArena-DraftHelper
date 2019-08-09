const initialState = {
  message: ""
}

const alertMessage = (state = initialState, action) => {
  switch (action.type) {
    case DISPLAY_ALERT_MESSAGE:
      return {
        ...state,
        message: action.alertMessage
      }
    case CLOSE_ALERT_MESSAGE:
      return initialState
    default:
      return state
  }
}

const DISPLAY_ALERT_MESSAGE = 'DISPLAY_ALERT_MESSAGE'
const displayAlertMessage = alertMessage => {
  return {
    type: DISPLAY_ALERT_MESSAGE,
    alertMessage
  }
}

const CLOSE_ALERT_MESSAGE = 'CLOSE_ALERT_MESSAGE'
const closeAlertMessage = () => {
  return {
    type: CLOSE_ALERT_MESSAGE
  }
}

export {
  alertMessage,
  displayAlertMessage,
  closeAlertMessage
}
