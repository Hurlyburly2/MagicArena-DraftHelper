import React from 'react'
import { Link } from 'react-router'

export const CardComponent = (props) => {
  return (
    <div>
      <ul>
        <li>{props.id}</li>
        <li><img src={props.imageURL} /></li>
        <li>{props.name}</li>
        <li>Mana Cost: {props.manaCost}</li>
        <li>Ratings: <ul>
                        {props.ratings}
                      </ul>
                      </li>
      </ul>
    </div>
  )
}

export default CardComponent
