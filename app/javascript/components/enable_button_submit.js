function checkAllChosen(selectFields)  {
  // we initiate the filled as true
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

// function the get the unique values from an array
function onlyUnique(value, index, self) {
    return self.indexOf(value) === index;
}


function checkNoDouble(selectFields)  {
  // we initiate the double? as true
  var double = true;
  var array = [];
  // for each field,
    selectFields.forEach((selectField) => {
      // We put all the name in a array
      array.push(selectField.options[selectField.selectedIndex].textContent);
    });

    // we get only the unique value of this array
    var unique = array.filter( onlyUnique );
    // if the size of the unique array is the same as the size of the initial array then we do not have duplicate
    if (  unique.length == array.length)
        {double = false};
    // the function will return true only when there is no duplciate name in the form
  return double;
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
          // we call the function checkValue that will check if all the field have a unique value;
          if (checkAllChosen(selectors) === true && checkNoDouble(selectors) === false )
            // when all the lifeguards are chosen with no double names then the button is enabled;
              { submitButton.disabled = false }
            else
            // as long as at least one field is not populated/or if there is twice the same name then the button is disabled
            { submitButton.disabled = true };
      });
    });
  }
}




export { enableButtonSubmit }
