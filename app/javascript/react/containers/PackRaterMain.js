import React, { Component } from 'react'
import { Link } from 'react-router'

import { connect } from 'react-redux'

import FormContainer from './FormContainer'
import PackResultContainer from './PackResultContainer'
import Button from '../components/Button'

class PackRaterMain extends Component {
  constructor(props) {
    super(props)
  }
  
  render() {
    let currentContainer = ""
    if (this.props.returnedCards == null) {
      currentContainer = <FormContainer />
    } else {
      currentContainer = <PackResultContainer />
    }
    
    return(
      <div className="container">
        <div className="row">
          <div className="col-md2-1">
          </div>
          <div className="col-m2-10">
            <Button
              text="Back"
              link="/"
            />
            {currentContainer}
          </div>
          <div className="col-md-1">
          </div>
        </div>
      </div>
    )
  }
}

const mapStateToProps = (state) => {
  return {
    returnedCards: state.packs.returnedCards
  }
}

export default connect(
  mapStateToProps,
  null
)(PackRaterMain)
