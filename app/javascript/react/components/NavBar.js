import React from 'react'
import { Link } from 'react-router'

export const NavBar = (props) => {
  return (
    <div className="wrapper">
    
      <div className="row">
        <div className='navBar'>
          <ul className='small-10 small-centered columns'>
            <li><a href="/"><img src='MagicLogo.png' id='navBar-logo'/></a></li>
            <li><a href="/">Home</a></li>
            <li><a href="/drafts">Rate a Pack</a></li>
            <li>Expansion Data</li>
            <li>About</li>
          </ul>
        </div>
      </div>
      
      <div className="row">
        {props.children}
      </div>
    </div>
    
  )
}

export default NavBar
