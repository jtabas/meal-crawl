import React from 'react';
const Restaurant = props => {
  return (
    <div className="restaurant-info-box">
    <img src={props.photo} alt={props.name} className="restaurant-index-img" />
        <a href={`/restaurants/${props.id}`}>
          <h2>{props.name}</h2>
        </a>
        <p>Rating: {props.rating} <br />
        Address: {props.address} </p>
    </div>
  );
}

export default Restaurant;
