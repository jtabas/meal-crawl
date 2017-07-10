import React from 'react';
const Restaurant = props => {
  return (
    <div className="columns large-4">
      <div className="restaurant-info-box">
          <a href={`/restaurants/${props.id}`}>
            <div className="image-wrap">
              <img src={props.photo} alt={props.name} className="restaurant-index-img" />
            </div>
            <h4>{props.name}</h4>
          </a>
      </div>
    </div>
  );
}

export default Restaurant;
