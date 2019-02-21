import React from 'react'
import filter from 'lodash/filter'
import ItemCard from './ItemCard'

const ItemContainer = ({ slug, items, addItem, removeItem, isStoreList, savedItems }) => {
  const filteredItems = filter(items, (item) => !savedItems.map(i => i.key).includes(item.key))

  return (
    <div className='col-2'>
      <h3 style={{ textTransform: 'capitalize' }}>{slug.replace('_', ' ')}</h3>
      <div style={{ maxHeight: '90vh', overflowY: 'auto' }}>
        {filteredItems.map(item => <ItemCard
          key={`${slug}-${item.id}`}
          id={item.id}
          name={item.name}
          price={item.price}
          rarity={item.rarity}
          isRestricted={item.is_restricted}
          itemType={slug}
          slug={item.key}
          addItem={addItem}
          removeItem={removeItem}
          isInStore={isStoreList} />)}
      </div>
    </div>
  )
}

export default ItemContainer
