import React from 'react'
import PropTypes from 'prop-types'

const ItemCard = ({ id, name, price, slug, isRestricted, itemType, addItem, removeItem, isInStore, dispatch, originalPrice }) => {
  const handleChangePrice = e => {
    dispatch({ type: 'UPDATE_PRICE', item: { id, name, itemType, price: e.target.value, key: slug, originalPrice } })
  }

  const storeFields = () => {
    return (
      <React.Fragment>
        <div className='form-group'>
          <label htmlFor={`price-${slug}`}>Price</label>
          <input type='text' className='form-control' id={`price-${slug}`} placeholder='Price' value={price} onChange={handleChangePrice} />
        </div>
        {/* <div className='form-group'>
          <label htmlFor={`quantity-${slug}`}>Quantity</label>
          <input type='text' className='form-control' id={`quantity-${slug}`} placeholder='Quantity' value={0} />
        </div> */}
      </React.Fragment>
    )
  }

  

  return (
    <div className='card'>
      <div className='card-body d-flex justify-content-between'>
        <div className='info'>
          <div>{name} ({originalPrice}) {isRestricted && <span className='text-danger'>(R)</span>}</div>
          <div className='mt-1'>
            {isInStore && storeFields()}
          </div>
        </div>
        <div className='actions'>
          {!isInStore && <button className='btn btn-sm btn-primary' onClick={() => addItem(itemType, { id, name, price, itemType, key: slug })}><i className={'fa fa-plus'} /></button>}
          {isInStore && <button className='btn btn-sm btn-danger' onClick={() => removeItem(slug)}><i className={'fa fa-minus'} /></button>}
        </div>
      </div>
    </div>
  )
}

ItemCard.propTypes = {
  id: PropTypes.number,
  isRestricted: PropTypes.bool,
  slug: PropTypes.string,
  name: PropTypes.string,
  price: PropTypes.oneOfType([PropTypes.number, PropTypes.string]),
  rarity: PropTypes.number,
  itemType: PropTypes.string,
  addItem: PropTypes.func,
  removeItem: PropTypes.func,
  isInStore: PropTypes.bool,
  dispatch: PropTypes.func,
}

export default React.memo(ItemCard)
