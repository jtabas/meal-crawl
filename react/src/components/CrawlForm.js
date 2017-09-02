import React from 'react';
const CrawlForm = props => {
  return (
      <form>
        <input
        type="text"
        placeholder="Cuisine"
        cuisineChange={props.cuisineChange}
        />

        <select>
          <option value={2}>{2}</option>
          <option value={3}>{3}</option>
          <option value={4}>{4}</option>
          <option value={5}>{5}</option>
          <option value={5}>{5}</option>
          <option value={6}>{6}</option>
          <option value={7}>{7}</option>
          <option value={8}>{8}</option>
          <option value={9}>{9}</option>
          <option value={10}>{10}</option>
        </select>
        <input type="submit" value="Submit" />
      </form>
    );
  }
export default CrawlForm;
