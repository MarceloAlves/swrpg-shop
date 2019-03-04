import React from 'react'
import PropTypes from 'prop-types'
import filter from 'lodash/filter'
import includes from 'lodash/includes'
import ItemCard from './ItemCard'

const ItemContainer = ({ filteredItems, items, itemType, savedItems }) => {
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
      <div className='overflow-auto' style={{ maxHeight: 'calc(100vh - 241px)' }}>
        {itemList.map(item => <ItemCard
          key={item.key}
          id={item.id}
          name={item.name}
          price={item.price}
          isRestricted={item.is_restricted}
          itemType={itemType}
          slug={item.key} />)}
      </div>
    </div>
  )
}

ItemContainer.propTypes = {
  filteredItems: PropTypes.array,
  items: PropTypes.array,
  itemType: PropTypes.string,
  savedItems: PropTypes.array
}

export default ItemContainer
