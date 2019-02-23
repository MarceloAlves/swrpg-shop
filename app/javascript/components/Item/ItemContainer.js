import React from 'react'
import filter from 'lodash/filter'
import includes from 'lodash/includes'
import ItemCard from './ItemCard'

const ItemContainer = ({ itemType, items, addItem, removeItem, isStoreList, savedItems, filteredItems }) => {
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
    <div className='col-2'>
      <h3 style={{ textTransform: 'capitalize' }}>{itemType.replace('_', ' ')}</h3>
      <div style={{ maxHeight: '90vh', overflowY: 'auto' }}>
        {itemList.map(item => <ItemCard
          key={`${itemType}-${item.id}`}
          id={item.id}
          name={item.name}
          price={item.price}
          rarity={item.rarity}
          isRestricted={item.is_restricted}
          itemType={itemType}
          slug={item.key}
          originalPrice={item.price}
          addItem={addItem}
          removeItem={removeItem}
          isInStore={isStoreList} />)}
      </div>
    </div>
  )
}

export default ItemContainer
