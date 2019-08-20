import React, { Component } from 'react'
import { Link } from 'react-router'

import { connect } from 'react-redux'

import FormContainer from './FormContainer'
import PackResultContainer from './PackResultContainer'
import BackButton from '../components/BackButton'

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
      <div className="row">
        <div className="small-10 small-centered columns">
          <BackButton
            text="Back"
            link="/"
            image="BackArrow.png"
          />
          {currentContainer}
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
