import React from 'react';

export default function NewQuestionForm({ handleSubmit, title, body, updateQuestionParams}) {
  console.log(title);
  function handleUpdate(e) {
    const input = e.target;
    // console.log(input.value);
    // console.log('-------')
    // console.log(input.name);
    updateQuestionParams(
      {[input.name]: input.value}
    )
  }

  return(
    <form onSubmit={(event) => { 
      event.preventDefault(); // prevent default behaviour of form submission (just like vanilla javascript)
      handleSubmit();
    }}>
      <label htmlFor='title'>title</label>
      <input type='text' name='title' id='title' value={title} onChange={handleUpdate} disabled={title.length === 20}/>
      <label htmlFor='body'>body</label>
      <input type='text' name='body' id='body' value={body} onChange={handleUpdate}/>
      <input type='submit' value='Create Question'/>
    </form>
  )
}