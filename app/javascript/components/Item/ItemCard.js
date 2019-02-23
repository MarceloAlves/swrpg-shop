import React from 'react'
import PropTypes from 'prop-types'
import classnames from 'classnames'
import { TYPES } from '../../hooks/useShopState'

const ItemCard = ({ id, name, price, slug, isRestricted, itemType, dispatch }) => {
  const addItem = item => {
    dispatch({ type: TYPES.ADD_ITEM, item: { ...item } })
  }

  const classes = classnames('card', { 'border-danger': isRestricted })

  return (
    <div className={classes}>
      <div className='card-body d-flex justify-content-between'>
        <div className='info p-1'>
          <p>{name}</p>
        </div>
        <div className='actions'>
          <button className='btn btn-sm btn-primary' onClick={() => addItem({ id, name, price, itemType, key: slug })}>
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
  slug: PropTypes.string,
  name: PropTypes.string,
  price: PropTypes.oneOfType([PropTypes.number, PropTypes.string]),
  rarity: PropTypes.number,
  itemType: PropTypes.string,
  isInStore: PropTypes.bool,
  originalPrice: PropTypes.number,
  dispatch: PropTypes.func
}

export default React.memo(ItemCard)
