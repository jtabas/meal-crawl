import React from 'react';
const PaginationButtons = props => {
  return (
    <div className="text-center">
      <div className="pages">
         <button className="button round" onClick={props.previousPage}>
           Previous Page
         </button>
         <button className="button round" onClick={props.nextPage}>
           Next Page
         </button>
        </div>
    </div>
  );
}

export default PaginationButtons;
