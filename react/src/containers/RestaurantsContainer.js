import React, { Component } from 'react';
// import SearchBar from '../components/SearchBar';
// import RestaurantsList from '../components/RestaurantsList';

class RestaurantsContainer extends Component {
  constructor (props) {
    super(props);
    this.state = {
      searchTerm: '',
      allRestaurants: []
    };

    this.compare = this.compare.bind(this);
    this.getData = this.getData.bind(this);
    this.onChange = this.onChange.bind(this);
    this.findRestaurants = this.findRestaurants.bind(this);
  }

  compare (a, b) {
    const ratingA = a.rating;
    const ratingB = b.rating;

    let comparison = 0;
    if (ratingA < ratingB) {
      comparison = 1;
    } else if (ratingA > ratingB) {
      comparison = -1;
    }
    return comparison;
  }

  getData () {
    let RestaurantContainer = this;
    fetch('/api/v1/restaurants.json')
      .then(response => {
        if (response.ok) {
          return response;
        } else {
          let errorMessage = `${response.status} ($response.statusText)`;
          let error = new Error(errorMessage);
          throw (error);
        }
      })
      .then(response => response.json())
      .then(body => body.sort(RestaurantContainer.compare))
      .then(sortedRestaurants => {
        RestaurantContainer.setState({ allRestaurants: sortedRestaurants });
      })
      .catch(error => console.error(`Error in fetch ${error.message}`));
  }

  componentDidMount () {
    this.getData();
  }

  onChange (event) {
    let newSearchTerm = event.target.value;
    this.setState({ searchTerm: newSearchTerm });
  }

  findRestaurants (searchTerm) {
    let allRestaurants = this.state.allRestaurants;
    let foundRestaurants = [];
    // console.log(searchTerm);
    allRestaurants.forEach((restaurant) => {
      var restaurantMatch = false;
      if (restaurant.name.toLowerCase().includes(searchTerm.toLowerCase())) {
        restaurantMatch = true;
      }
      if (restaurantMatch) { foundRestaurants.push(restaurant); }
    });
    return foundRestaurants;
  }

  render () {
    var restaurantsToShow = [];
    if (this.state.searchTerm === '') {
      restaurantsToShow = this.state.allRestaurants;
    } else {
      restaurantsToShow = this.findRestaurants(this.state.searchTerm);
    }

    return (
      <div className="large-12 large-centered columns" id="Restaurants-Container">
        <SearchBar
          onChange={this.onChange}
          handleClear={this.handleClear}
          value={this.state.searchTerm}
        />
        <RestaurantsList
          restaurants={restaurantsToShow}
        />
      </div>
    );
  }
}

export default RestaurantsContainer;
