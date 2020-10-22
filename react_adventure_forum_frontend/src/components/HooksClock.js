import React, { useState, useEffect } from 'react'

export default function HooksClock() {
  const [time, setTime] = useState(new Date());
  const [ticker, setTicker] = useState(0);

  useEffect(() => {
    const id = setInterval(() => {
      setTicker((state) => {
        return state + 1;
      })
    }, 1000)
    return () => clearInterval(id)
  }, [])

  useEffect(() => {
    setTime(new Date());
  }, [ticker]);

  return(
    <div className='home-page'>
        <div><h4>Welcome to the Adventure forum</h4></div>
        <div><p>Have a question about hiking and camping? Ask local experts!</p></div>
        <div><h3>{time.toLocaleTimeString()}</h3></div>
      </div>
  )
}
