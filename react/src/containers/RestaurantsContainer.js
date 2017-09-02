import React, { Component } from 'react';
import SearchBar from '../components/SearchBar';
import RestaurantsList from '../components/RestaurantsList';
import CrawlForm from '../components/CrawlForm';

class RestaurantsContainer extends Component {
  constructor (props) {
    super(props);
    this.state = {
      searchTerm: '',
      cuisineSearch: '',
      numberOfStops: null,
      allRestaurants: []
    };

    this.compare = this.compare.bind(this);
    this.getData = this.getData.bind(this);
    this.onChange = this.onChange.bind(this);
    this.findRestaurants = this.findRestaurants.bind(this);
    this.cuisineChange= this.cuisineChange.bind(this);
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
    allRestaurants.forEach((restaurant) => {
      var restaurantMatch = false;
      if (restaurant.name.toLowerCase().includes(searchTerm.toLowerCase())) {
        restaurantMatch = true;
      }
      if (restaurantMatch) { foundRestaurants.push(restaurant); }
    });
    return foundRestaurants;
  }

  cuisineChange (event) {
    let newCuisine = event.target.value;
    this.setState({ cuisineSearch: newCuisine });
  }

  render () {
    var restaurantsToShow = [];
    if (this.state.searchTerm === '') {
      restaurantsToShow = this.state.allRestaurants;
    } else {
      restaurantsToShow = this.findRestaurants(this.state.searchTerm);
    }

    return (
      <div>
        <div className="row large-12 large-centered columns" id="Restaurants-Container">
          <SearchBar
            onChange={this.onChange}
            handleClear={this.handleClear}
            value={this.state.searchTerm}
          />
          <RestaurantsList
            restaurants={restaurantsToShow}
          />
          <CrawlForm
            cuisineChange={this.cuisineChange}
            cuisineSearch={this.state.cuisineSearch}
          />
        </div>
        <footer>
          <div className="row">
            <a className="large-6 columns text-left" href="https://github.com/jtabas">Github</a>
            <a className="large-6 columns text-right" href="https://www.linkedin.com/in/jtabas/">LinkedIn</a>
          </div>
        </footer>
      </div>
    );
  }
}

export default RestaurantsContainer;
