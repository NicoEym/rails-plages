function checkValue(selectFields)  {
  // we initiate the field as true
  var filled = true;
  // for each field,
    selectFields.forEach((selectField) => {
    // if the field is still on "Choisir", then we return false
     if (selectField.options[selectField.selectedIndex].textContent == "Choisir")
        {filled = false};
    });
    // the function will return true only when a name will be chosen for every position on the beach
  return filled;
}


const enableButtonSubmit  = () => {
    // we select our submit button
    const submitButton = document.getElementById('submit-team');
    // if the submit button is on the page then
    if (submitButton) {
      // we disable the button
      submitButton.disabled = true;
      //setting the new url from a regex, in order to be able to redirect to swim_races/:id
      //first we get the url from the current page
    const selectors = document.querySelectorAll('select');

    // event listener on each selector
    selectors.forEach((selector) => {
      // each time they change, we will check their value
        selector.addEventListener('change', (e) => {
          // we call the function checkValue that will check if all the field have a value;
          if (checkValue(selectors) === true )
            // when all the lifeguards are chosen then the button is disabled;
              { submitButton.disabled = false }
            else
            // as long as at least one field is not populated then the button is disabled
            { submitButton.disabled = true };
      });
    });
  }
}




export { enableButtonSubmit }
