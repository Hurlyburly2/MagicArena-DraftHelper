import React, { Component } from 'react'
import { Link } from 'react-router'

import { connect } from 'react-redux'

import CardComponent from '../components/CardComponent'
import Button from '../components/Button'

class PackResultContainer extends Component {
  constructor(props) {
    super(props)
  }
  
  render() {
    
    let outputText = ""
    if (this.props.returnedCards != null) {
      let card_keys = Object.keys(this.props.returnedCards)
      outputText = card_keys.map((card_id) => {
        let current_card = this.props.returnedCards[card_id]
        let rating_keys = Object.keys(current_card.ratings)
      
        let ratings = rating_keys.map((rating_id) => {
          return <li key={current_card.ratings[rating_id].rating_id}>
                      {current_card.ratings[rating_id].rating_system_name}: {current_card.ratings[rating_id].rating}
                  </li>
        })
        
        return <CardComponent 
                  key={parseInt(current_card.card.id)}
                  id={current_card.card.id}
                  imageURL={current_card.card.small_image_url}
                  name={current_card.card.name}
                  manaCost={current_card.card.mana_cost}
                  ratings={ratings}
                />
      })
    }
    
    return(
      <div className="container">
        <div className="row">
          <div className="col-md2-1">
          </div>
          <div className="col-m2-10">
            <Button
              text="Upload Another Image"
              link="/drafts"
            />
            {outputText}
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
)(PackResultContainer)
