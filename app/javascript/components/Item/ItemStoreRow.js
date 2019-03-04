import React from 'react'
import PropTypes from 'prop-types'
import { TYPES } from '../../hooks/useShopState'

const ItemStoreRow = ({ id, name, price, slug, itemType, dispatch, originalPrice, quantity }) => {
  const removeItem = key => {
    dispatch({ type: TYPES.REMOVE_ITEM, key })
  }

  const handleChangePrice = e => {
    dispatch({ type: TYPES.UPDATE_SHOP_ITEM, item: { id, name, itemType, originalPrice, quantity, price: e.target.value, key: slug } })
  }

  const handleChangeQuantity = e => {
    dispatch({ type: TYPES.UPDATE_SHOP_ITEM, item: { id, name, itemType, originalPrice, price, key: slug, quantity: e.target.value } })
  }

  return (
    <div className='row py-1 border-bottom d-flex align-items-center fade-in'>
      <div className='col-12'>
        <div className='row no-gutters'>
          <label>{name} {price !== originalPrice && `(${originalPrice})`}</label>
        </div>

        <div className='row no-gutters'>
          <div className='col-5 p-1 d-flex align-items-end'>
            <div className='form-group m-0'>
              <label htmlFor='price'>Price</label>
              <input type='text' className='form-control form-control-sm' name='price' placeholder='Price' value={price} onChange={handleChangePrice} />
            </div>
          </div>

          <div className='col-5 p-1 d-flex align-items-end'>
            <div className='form-group m-0'>
              <label htmlFor='quantity'>Quantity</label>
              <input type='text' className='form-control form-control-sm' name='quantity' placeholder='Quantity' value={quantity} onChange={handleChangeQuantity} />
            </div>
          </div>

          <div className='col-2 p-1 d-flex align-items-end'>
            <button className='btn btn-sm btn-danger' onClick={() => removeItem(slug)}><i className={'fa fa-minus'} /></button>
          </div>
        </div>
      </div>

    </div>
  )
}

ItemStoreRow.propTypes = {
  id: PropTypes.number,
  slug: PropTypes.string,
  name: PropTypes.string,
  price: PropTypes.oneOfType([PropTypes.number, PropTypes.string]),
  itemType: PropTypes.string,
  originalPrice: PropTypes.number,
  quantity: PropTypes.oneOfType([PropTypes.string, PropTypes.number]),
  dispatch: PropTypes.func
}

export default React.memo(ItemStoreRow)
