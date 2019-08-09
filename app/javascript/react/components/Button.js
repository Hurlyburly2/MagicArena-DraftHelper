import React from 'react'
import { Link } from 'react-router'

export const Button = (props) => {
  return (
    <h4><a href={props.link}>{props.text}</a></h4>
  )
}

export default Button
