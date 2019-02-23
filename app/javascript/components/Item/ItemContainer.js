import React from 'react'
import PropTypes from 'prop-types'
import filter from 'lodash/filter'
import includes from 'lodash/includes'
import ItemCard from './ItemCard'

const ItemContainer = ({ itemType, items, dispatch, savedItems, filteredItems }) => {
  const isFiltered = key => {
    if (filteredItems.length === 0) {
      return true
    }

    return includes(filteredItems, key)
  }

  const isSavedItem = key => {
    const keys = savedItems.map(i => i.key)
    return !includes(keys, key)
  }

  const isItemType = item => item.item_type === itemType

  const itemList = filter(items, (item) => isItemType(item) && isFiltered(item.key) && isSavedItem(item.key))

  return (
    <div className='col pt-2'>
      <h3 className='text-capitalize'>{itemType.replace('_', ' ')}</h3>
      <div className='vh-100 overflow-auto'>
        {itemList.map(item => <ItemCard
          key={item.key}
          id={item.id}
          name={item.name}
          price={item.price}
          isRestricted={item.is_restricted}
          itemType={itemType}
          slug={item.key}
          dispatch={dispatch} />)}
      </div>
    </div>
  )
}

ItemContainer.propTypes = {
  itemType: PropTypes.string,
  items: PropTypes.array,
  dispatch: PropTypes.func,
  savedItems: PropTypes.array,
  filteredItems: PropTypes.array
}

export default ItemContainer
