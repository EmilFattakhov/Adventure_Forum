const BASE_URL = 'http://localhost:3000/api/v1';

// requests

export const Question = {
  index() {
    return fetch(`${BASE_URL}/questions`)
      .then(res => {
        return res.json();
      })
  },
  create(params) {
    return fetch(`${BASE_URL}/questions`, {
      method: 'POST',
      credentials: 'include',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(params)
    }).then(res => {
      return res.json();
    })
  },
  show(id) {
    return fetch(`${BASE_URL}/questions/${id}`)
      .then(res => res.json());
  },
  delete(id) {
    return fetch(`${BASE_URL}/questions/${id}`, {
      method: 'DELETE',
      credentials: 'include'
    }).then(res => res.json());
  },
  update(params) {
    return fetch(`${BASE_URL}/questions/${params.id}`, {
      method: 'PATCH',
      credentials: 'include',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(params)
    }).then(res => res.json());
  }
}

export const Session = {
  create(params) {
    return fetch(`${BASE_URL}/session`, {
      method: 'POST',
      credentials: 'include',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(params)
    }).then(res => res.json());
  },

  getCurrentUser() {
    return fetch(`${BASE_URL}/current_user`, {
      credentials: 'include'
    }).then(res => res.json());
  }
}