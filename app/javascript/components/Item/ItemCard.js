import React from 'react';
import PropTypes from 'prop-types';

const ItemCard = ({id, name, price, rarity, is_restricted, itemType, addItem, removeItem, isInStore}) => {
  return (
    <div className="card">
      <div className="card-body d-flex justify-content-between">
        <div className="info">
          {name} ({price}) {is_restricted && <span className="text-danger">(R)</span>}
        </div>
        <div className="actions">
          {!isInStore && <button className='btn btn-sm btn-primary' onClick={() => addItem(itemType, {id, name})}><i className={'fa fa-plus'}/></button>}
          {isInStore && <button className='btn btn-sm btn-danger' onClick={() => removeItem(id)}><i className={'fa fa-minus'}/></button>}
        </div>
      </div>
    </div>
  );
}

ItemCard.propTypes = {
  id: PropTypes.number,
  is_restricted: PropTypes.bool,
  slug: PropTypes.string,
  name: PropTypes.string,
  price: PropTypes.number,
  rarity: PropTypes.number,
  itemType: PropTypes.string,
  addItem: PropTypes.func,
  removeItem: PropTypes.func,
  isInStore: PropTypes.bool,
}

export default ItemCard;
