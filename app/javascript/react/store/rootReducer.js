import { combineReducers } from 'redux'

import { packs } from '../modules/packs'
import { alertMessage } from '../modules/alertMessage'

const rootReducer = combineReducers({
  packs,
  alertMessage
})

export default rootReducer
