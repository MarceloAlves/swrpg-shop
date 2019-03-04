import React, { useContext, useCallback } from 'react'
import PropTypes from 'prop-types'
import StoreContext from '../context/StoreContext'
import classnames from 'classnames'
import { TYPES } from '../../hooks/useShopState'

const ItemCard = ({ id, isRestricted, itemType, name, price, slug }) => {
  const dispatch = useContext(StoreContext)

  const addItem = useCallback(() => {
    dispatch({ type: TYPES.ADD_ITEM, item: { id, name, price, itemType, quantity: -1, key: slug } })
  })

  const classes = classnames('card my-1', { 'border-danger': isRestricted })

  return (
    <div className={classes}>
      <div className='card-body p-3 d-flex justify-content-between align-items-center'>
        <span>{name}</span>
        <div className='actions ml-2'>
          <button className='btn btn-sm btn-primary' onClick={addItem}>
            <i className={'fa fa-plus'} />
          </button>
        </div>
      </div>
    </div>
  )
}

ItemCard.propTypes = {
  id: PropTypes.number,
  isRestricted: PropTypes.bool,
  itemType: PropTypes.string,
  name: PropTypes.string,
  price: PropTypes.oneOfType([PropTypes.number, PropTypes.string]),
  slug: PropTypes.string
}

export default React.memo(ItemCard)
