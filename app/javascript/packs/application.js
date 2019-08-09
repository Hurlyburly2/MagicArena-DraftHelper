
import React from 'react'
import { render } from 'react-dom'

import configureStore from '../react/store/configureStore'
import App from '../react/components/App'
import RedBox from 'redbox-react'

const store = configureStore()

document.addEventListener('DOMContentLoaded', () => {
  let reactElement = document.getElementById('app')

    render(
      <App store = {store} />, 
      reactElement
    )
  })
