/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

console.log('Hello World from Webpacker')


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";

// Internal imports, e.g:
import { addLifeguardsToTeam } from '../components/add_lifeguards_to_team';
import { enableButtonSubmit } from '../components/enable_button_submit';
// import { initSelect2 } from '../components/init_select2';
import { initMapbox } from '../plugins/init_mapbox';
import { initSweetalert } from '../plugins/init_sweetalert';




document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:

  initMapbox();
  enableButtonSubmit();
  initSweetalert('#sweet-alert-season', {
  title: "Êtes vous sûr(e) de vouloir supprimer cette saison ?",
  text: "Cette action va supprimer les jours, les équipes, les sauveteurs et leurs dispo. Cette action ne pourra pas être annulée.",
  icon: "warning"
    }, (value) => {
      if (value) {
        const link = document.querySelector('#delete-link');
        link.click();
      }
  });


   initSweetalert('#sweet-alert-beach', {
  title: "Êtes vous sûr(e) de vouloir supprimer cette plage ?",
  text: "Cette action va supprimer la plage et les équipes qui y travaillent. Cette action ne pourra pas être annulée.",
  icon: "warning"
    }, (value) => {
      if (value) {
        const link = document.querySelector('#delete-link');
        link.click();
      }
  });
});





