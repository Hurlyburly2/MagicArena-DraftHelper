import React, { Component } from 'react'
import { Link } from 'react-router'

import { connect } from 'react-redux'
import { postImage } from '../modules/packs'

class FormContainer extends Component {  
  constructor(props) {
    super(props)
    this.handleSubmit = this.handleSubmit.bind(this)
  }
  
  handleSubmit(event) {
    event.preventDefault()
    const form = document.querySelector("#my_form");
    const formData = new FormData(form);
    
    this.props.postImage(formData)
  }
  
  render() {
    let handleSubmitForm = () => {
      this.submitForm();
    }
    
    return(  
      <div>
        <div className="row">
          <h3 className='mainHeader small-12 columns'>Upload a Screenshot</h3>
        </div>
        
        <div className="row uploadPageRight">
          <div className="small-12 medium-4 columns">
            <img src="/Screenshot1.png" className="sampleImage1"/>
          </div>
          
          <div className="small-12 medium-7 columns uploadPageRight-content">
            <h4>How it works:</h4>
            <p>Take a screenshot of your MTG: Arena draft pack in the format that you see to your left. Then, upload the screenshot here. We’ll match your screenshot to the cards in your pack along with the ratings from several well-known tier lists!</p>
            <form id="my_form" onSubmit={this.handleSubmit}>
              <input type="file" 
                     name="image" 
                     id="image_upload" 
                     accept="image/*" 
                     className="choosefile"
              />
              <input type="submit" value="Submit" className="uploadPageButton uploadSubmit"/>
            </form>
          </div>  
        </div>
        
        <div className="row helpRow">
          <p className="helpParagraph">Help?</p>
          <h4>Don't have an image and want to try out the app? No problem!</h4>
          <p>You can save any use any of this collection of sample images if you just want to try it out!</p>
        </div>
        
        <div className="row imagesRow">
          <div className="small-6 medium-3 columns">
            <a href="/Screenshot1.png" download><img src="/Screenshot1.png" className="sampleImage"/></a>
          </div>
          <div className="small-6 medium-3 columns">
            <a href="/Screenshot1.png" download><img src="/Screenshot1.png" className="sampleImage"/></a>
          </div>
          <div className="small-6 medium-3 columns">
            <a href="/Screenshot1.png" download><img src="/Screenshot1.png" className="sampleImage"/></a>
          </div>
          <div className="small-6 medium-3 columns">
            <a href="/Screenshot1.png" download><img src="/Screenshot1.png" className="sampleImage"/></a>
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

const mapDispatchToProps = (dispatch) => {
  return {
    postImage: (image) => dispatch(postImage(image))
  }
}

export default connect(
    mapStateToProps,
    mapDispatchToProps
)(FormContainer)
