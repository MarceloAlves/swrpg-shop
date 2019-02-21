import React, { useReducer, useState } from 'react'
import PropTypes from 'prop-types'
import ItemCard from './Item/ItemCard'
import Fuse from 'fuse.js'
import { useItemList } from '../hooks/useItemlist'
import ItemContainer from './Item/ItemContainer'

const SEARCH_OPTIONS = {
  shouldSort: true,
  threshold: 0.6,
  location: 0,
  distance: 100,
  maxPatternLength: 32,
  minMatchCharLength: 1,
  keys: [
    'name'
  ]
}

const reducer = (state, action) => {
  switch (action.type) {
    case 'ADD_ITEM':
      return { items: state.items.concat(action.item) }
    case 'REMOVE_ITEM':
      const newItems = state.items.filter(item => item.key !== action.key)
      return { items: newItems }
    default:
      return state
  }
}

const CustomShop = ({ items }) => {
  const [savedItems, dispatch] = useReducer(reducer, { items: [] })
  const [itemList, setItemList] = useItemList(items)
  const [searchValue, setSearchValue] = useState('')
  const fuse = new Fuse(items, SEARCH_OPTIONS)

  const addItem = (itemType, item) => {
    dispatch({ type: 'ADD_ITEM', item: { ...item } })
  }

  const removeItem = key => {
    dispatch({ type: 'REMOVE_ITEM', key })
  }

  const filterItems = e => {
    const { target: { value } } = e
    let results = items

    if (value.length !== 0) {
      results = fuse.search(value)
    }

    setItemList(results)
    setSearchValue(value)
  }

  const resetForm = e => {
    setItemList(items)
  }

  return (
    <div className='container-fluid'>
      <div className='row'>
        <div className='col-12 p-5'>
          <div className='input-group'>
            <input className={'form-control form-control-lg'} placeholder='Search...' name='search' value={searchValue} onChange={filterItems} />
            <div className='input-group-append'>
              <button className='btn btn-lg btn-danger' onClick={resetForm} type='button'><i className='fa fa-times' /></button>
            </div>
          </div>
        </div>
      </div>
      <div className='row'>
        {['armor', 'gear', 'item_attachments', 'weapons'].map(slug => {
          return <ItemContainer key={`${slug}-container`} slug={slug} items={itemList[slug]} addItem={addItem} removeItem={removeItem} savedItems={savedItems.items} />
        })}
        <div className='col-3'>
          <h3>In Store</h3>
          <div style={{ maxHeight: '90vh', overflowY: 'auto' }}>
            {savedItems.items.map(item => <ItemCard key={item.id} name={item.name} slug={item.key} price={item.price} removeItem={removeItem} isInStore />)}
          </div>
        </div>
      </div>
    </div>
  )
}

CustomShop.propTypes = {
  items: PropTypes.arrayOf(PropTypes.shape({
    id: PropTypes.number,
    is_restricted: PropTypes.bool,
    key: PropTypes.string,
    name: PropTypes.string,
    price: PropTypes.number,
    rarity: PropTypes.number
  }))
}

export default React.memo(CustomShop)
