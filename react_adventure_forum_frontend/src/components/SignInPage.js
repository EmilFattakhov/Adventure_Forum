import React from 'react';

function SignInPage({ signIn, history }) {

  function handleSubmit(e) {
    e.preventDefault();
    const formData = new FormData(e.currentTarget);
    const params = {
      email: formData.get('email'),
      password: formData.get('password')
    }
    signIn(params, history);
  }
  return(
    <main id='sign-in-page'>
      <form onSubmit={handleSubmit}>
        <div>
          <label htmlFor='email'>Email</label>
          <input type='text' id='email' name='email'/>
        </div>
        <div>
          <label htmlFor='password'>Password</label>
          <input type='password' id='password' name='password'/>
        </div>
        <div>
          <input type='submit' value='Sign In'/>
        </div>
      </form>
    </main>
  )
}

export default SignInPage;