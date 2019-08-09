import React from 'react'
import { Link } from 'react-router'

export const NavBar = (props) => {
  return (
    <div>
      <h1>NAVBAR</h1>
      {props.children}
    </div>
  )
}

export default NavBar
