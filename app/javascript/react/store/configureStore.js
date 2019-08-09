import { createStore, applyMiddleware } from 'redux'
import thunkMiddleware from 'redux-thunk'

import rootReducer from './rootReducer'

let configureStore = () => {
  let store = createStore(
    rootReducer,
    applyMiddleware(thunkMiddleware)
  )
  return store
}

export default configureStore
