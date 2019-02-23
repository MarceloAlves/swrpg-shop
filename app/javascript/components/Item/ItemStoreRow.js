import React from 'react'
import PropTypes from 'prop-types'
import { TYPES } from '../../hooks/useShopState'

const ItemStoreRow = ({ id, name, price, slug, isRestricted, itemType, dispatch, originalPrice }) => {
  const removeItem = key => {
    dispatch({ type: TYPES.REMOVE_ITEM, key })
  }

  const handleChangePrice = e => {
    dispatch({ type: TYPES.UPDATE_PRICE, item: { id, name, itemType, originalPrice, price: e.target.value, key: slug } })
  }

  return (
    <div className='form-group row py-1 border-bottom d-flex align-items-center fade-in'>
      <div className='col-5'>
        <label>{name} {price !== originalPrice && `(${originalPrice})`}</label>
      </div>
      <div className='col-5'>
        <input type='text' className='form-control form-control-sm' name='price' placeholder='Price' value={price} onChange={handleChangePrice} />
      </div>
      <div className='col-2'>
        <button className='btn btn-sm btn-danger' onClick={() => removeItem(slug)}><i className={'fa fa-minus'} /></button>
      </div>
    </div>
  )
}

ItemStoreRow.propTypes = {
  id: PropTypes.number,
  isRestricted: PropTypes.bool,
  slug: PropTypes.string,
  name: PropTypes.string,
  price: PropTypes.oneOfType([PropTypes.number, PropTypes.string]),
  itemType: PropTypes.string,
  originalPrice: PropTypes.number,
  dispatch: PropTypes.func
}

export default React.memo(ItemStoreRow)
