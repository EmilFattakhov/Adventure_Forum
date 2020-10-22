import React from 'react';
import { Route, Redirect } from 'react-router-dom';

// props looks like:
// {
//   isAuthenticated: false,
//   component: <Component/>,
//   to: '/questions/new'
// }
// ...routeProps looks like { to: '/questions/new' }
function AuthRoute({ isAuthenticated, component, ...routeProps }) {
  console.log(routeProps);
  console.log(routeProps);
  if(!isAuthenticated) {
    return <Redirect to='/sign_in'/>
  }

  return <Route {...routeProps} component={component} />
}

export default AuthRoute;