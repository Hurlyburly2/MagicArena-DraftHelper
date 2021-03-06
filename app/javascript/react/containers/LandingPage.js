import React, { Component } from 'react'
import { Link } from 'react-router'

class LandingPage extends Component {
  constructor(props) {
    super(props)
  }
  
  render() {
    return(
      <div className="row">
      
        <div className="span-image small-12 columns">
          <img src="/lich.jpg" className="landingImage"/>
        </div>
        
        <div className="textOverImage small-10 medium-10 small-centered columns">
          <div className="row">
            <h1 className="pageTitle">Magic Arena</h1>
            <h1 id="pageSubTitle">Draft Helper</h1>
          </div>  
          <div className="row">
            <div className="small-9 small-centered medium-4 medium-uncentered columns">
              <h2>Upload a screenshot of your draft pack, and the helper will tell you which are your strongest picks!</h2>
            </div>
          </div>
          <div className="row">  
            <div className="small-10 small-centered medium-2 medium-uncentered columns">
              <a href="/drafts"><button className='btnTryNow'>Try Now!</button></a>
            </div>
          </div>
        </div>
        
        <div className="row">
          <div className="small-10 small-centered columns">
          
            <div className="small-10 small-centered medium-4 medium-uncentered columns landingPageText">
              <p>Simply open a draft pack in Magic Arena, upload a screenshot of it to the helper, and it will return your cards sorted by their ratings according to several different tier lists! Filter and sort results by color and cost.</p>
            </div>
            <div className="small-10 small-centered medium-8 medium-uncentered columns">
              <img src="/LandingPageGraphic.png" className="landingPageIcons"/>
            </div>
            
          </div>
        </div>
        
      </div>
    )
  }
}

export default LandingPage
