import React from 'react'
import { Link } from 'react-router'

export const BackButton = (props) => {
  return (
    <div className="backButtonCenter">
      <h4 className="backLink"><a href={props.link}><img src="/BackArrow.png" className="backArrow-icon" />{props.text}</a></h4>
    </div>
  )
}

export default BackButton
