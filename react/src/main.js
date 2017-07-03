import 'babel-polyfill';
import React from 'react';
import ReactDOM from 'react-dom';
import RestaurantsContainer from './containers/RestaurantsContainer';


$(function () {
  let app = document.getElementById('app')
  if (app) {
    ReactDOM.render(
      <RestaurantsContainer />,
      app
    );
  }
});
