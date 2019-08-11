import React, { Component } from 'react'
import { Link } from 'react-router'

class LandingPage extends Component {
  constructor(props) {
    super(props)
  }
  
  render() {
    return(
      <div className="row">
        <div className="small-10 small-centered columns">
          <h1>Magic Arena Draft Helper</h1>
          <h3>Early Development</h3>
          
          <ul>
            <li>
              <a href="/drafts">Rate a Draft Pack!</a>
            </li>
            <li>Expansion Statistics</li>
          </ul>
          
        </div>
      </div>
    )
  }
}

export default LandingPage
