import React, { Component } from 'react';
import Restaurant from './Restaurant';
import PaginationButtons from './PaginationButtons';


class RestaurantsList extends Component {
  constructor (props) {
    super(props);
    this.state = {
      restaurants: [],
      currentPage: 1,
      restaurantsPerPage: 3
    };

    this.previousPage = this.previousPage.bind(this);
    this.nextPage = this.nextPage.bind(this);
  }

  componentWillReceiveProps (nextProps) {
    this.setState({ restaurants: nextProps.restaurants });
  }

  previousPage (event) {
    if (this.state.currentPage !== 1) {
      let newPage = this.state.currentPage - 1;
      this.setState({ currentPage: newPage });
    }
  }

  nextPage (event) {
    if (this.state.currentPage * this.state.restaurantsPerPage < this.state.restaurants.length) {
      let newPage = this.state.currentPage + 1;
      this.setState({ currentPage: newPage });
    }
  }

  render () {
    let indexOfLastRestaurant = this.state.currentPage * this.state.restaurantsPerPage;
    let rightBoundIndex = this.state.restaurants.length;
    let indexOfFirstRestaurant = indexOfLastRestaurant - this.state.restaurantsPerPage;
    let currentRestaurants;

    if (indexOfFirstRestaurant <= 0) {
      currentRestaurants = this.state.restaurants.slice(0, 3);
    } else if (indexOfLastRestaurant > this.state.restaurants.length) {
      indexOfLastRestaurant = (this.state.currentPage - 1) * this.state.restaurantsPerPage;
      currentRestaurants = this.state.restaurants.slice(indexOfLastRestaurant, rightBoundIndex);
    } else {
      currentRestaurants = this.state.restaurants.slice(indexOfFirstRestaurant, indexOfLastRestaurant);
    }

    let newRestaurants = currentRestaurants.map((restaurant, index) => {
      console.log(restaurant.photo);
      return (
        <Restaurant
          key={index}
          id={restaurant.id}
          name={restaurant.name}
          // rating={Number((restaurant.rating).toFixed(1))}
          address={restaurant.address.split(',')[0]}
          photo={restaurant.photo}
        />
      );
    });

    let buttons = null;
    if (this.state.restaurants.length > this.state.restaurantsPerPage) {
      buttons = <PaginationButtons
      previousPage={this.previousPage}
      nextPage={this.nextPage}
      />;
    }

    return (
      <div>
        {newRestaurants}
        {buttons}
      </div>
    );
  }
}

export default RestaurantsList;
