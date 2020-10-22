import React from 'react';
import { Link } from 'react-router-dom';
import './Navbar.css'

function Navbar({ user }) {
  return(
    <nav>
      <div className='split-container'>
        <div></div>
        <div className='navbar'>
        <Link style={{ textDecoration: 'none' }} to='/home'><p>Home page</p></Link>
        <Link style={{ textDecoration: 'none' }} to='/questions'><p>Frequently Asked Questions</p></Link>
        <Link style={{ textDecoration: 'none' }} to='/questions/new'><p>Ask Local Experts</p></Link>
        {
        user ? <p>{user.first_name} {user.last_name}</p> : <Link to='/sign_in'><h3>Sign In</h3></Link>
        }
        </div> 
      </div>
      
      
    </nav>
  )
}

export default Navbar
