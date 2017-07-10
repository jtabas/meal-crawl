import React from 'react';
const Restaurant = props => {
  return (
    <div className="restaurant-info-box">
        <a href={`/restaurants/${props.id}`}>
          <h2>{props.name}</h2>
        </a>
        <img src={props.photo} alt={props.name} className="restaurant-index-img" />
    </div>
  );
}

export default Restaurant;
