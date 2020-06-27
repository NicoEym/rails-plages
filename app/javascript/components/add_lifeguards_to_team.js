const addLifeguardsToTeam  = () => {
    const submitButton = document.getElementById('submit-team');
    if (submitButton) {
      //setting the new url from a regex, in order to be able to redirect to calendar/:id
      //first we get the url from the current page
    const url = window.location.href
    console.log(url)
    //regex to get every text after the /beaches
    const path = /beaches.*/g;
    console.log(path)
    // we create a new url excluding everything in the current url after /beaches
    const newurl = url.replace(path, '')
    console.log(newurl)
    // event listener on the validate button
    submitButton.addEventListener('click', (e) => {
      var i = 1;
      const formsEvent = document.querySelectorAll('.simple_form');
        //we submit each form form one after the other with a delay of 100 milliseconds
        formsEvent.forEach((form) => {
            // console.log(form.options[form.selectedIndex].value);
            setTimeout(function(){ Rails.fire(form, 'submit'); }, i * 100);
            i = i + 1;
          });
        //redirect after all event form have been submitted
       setTimeout(function(){ window.location.replace(newurl); }, i * 100);
    });
  }
}

export { addLifeguardsToTeam }
