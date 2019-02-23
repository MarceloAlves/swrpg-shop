import React, { useReducer, useState } from 'react'
import PropTypes from 'prop-types'
import ItemCard from './Item/ItemCard'
import Fuse from 'fuse.js'
import findIndex from 'lodash/findIndex'
import axios from 'axios'
import ItemContainer from './Item/ItemContainer'

const SEARCH_OPTIONS = {
  shouldSort: true,
  threshold: 0.3,
  location: 0,
  distance: 50,
  maxPatternLength: 32,
  minMatchCharLength: 1,
  id: 'key',
  keys: [
    'name'
  ]
}

const reducer = (state, action) => {
  switch (action.type) {
    case 'ADD_ITEM':
      state.items = state.items.concat(action.item)
      return {...state}
    case 'REMOVE_ITEM':
      state.items = state.items.filter(item => item.key !== action.key)
      return { ...state }
    case 'UPDATE_PRICE':
      const arr = Array.from(state.items)
      const itemIndex = findIndex(arr, { key: action.item.key })
      arr.splice(itemIndex, 1, action.item)
      return { ...state, items: arr }
    case 'UPDATE_SHOP_OPTIONS':
      const newState = Object.assign(state, { [action.name]: action.value})
      return {...newState}
    default:
      return state
  }
}

const CustomShop = ({ items, worlds, specializedShops }) => {
  const [savedItems, dispatch] = useReducer(reducer, { items: [], world_id: "1", specialized_shop_id: "1", name: '', shop_type: 'On The Level' })
  const [filteredItems, setFilteredItems] = useState([])
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
    let results = []

    if (value.length !== 0) {
      results = fuse.search(value)
    }

    setFilteredItems(results)
    setSearchValue(value)
  }

  const resetForm = e => {
    setFilteredItems([])
  }

  const onShopChange = e => {
    const { target: { value, name } } = e
    dispatch({type: 'UPDATE_SHOP_OPTIONS', value, name })
  }

  const saveShop = () => {
    axios.post('/custom_shops', {shop: {...savedItems}, 'authenticity_token': document.querySelector('meta[name="csrf-token"]').content}).then(result => {
      const { data: { slug } } = result
      Turbolinks.visit(`/shops/${slug}`)
    })
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
        {['armor', 'gear', 'item_attachments', 'weapons'].map(itemType => {
          return <ItemContainer key={`${itemType}-container`} itemType={itemType} items={items} filteredItems={filteredItems} addItem={addItem} removeItem={removeItem} savedItems={savedItems.items} />
        })}
        <div className='col-3'>
          <h3>Store</h3>
          <div>
            <h5>Settings</h5>
            <div className='form-group'>
              <label htmlFor="shop_name">Name</label>
              <input type='text' className='form-control' id="shop_name" name="name" onChange={onShopChange} />
            </div>
            <div className="form-group">
              <label htmlFor="shop_type">Shop Type</label>
              <select className="form-control" id="shop_type" name="shop_type" onChange={onShopChange}>
                <option value="On The Level">On The Level</option>
                <option value="Shady">Shady</option>
                <option value="Black Market">Black Market</option>
              </select>
            </div>
            <div className="form-group">
              <label htmlFor="world">World</label>
              <select className="form-control" id="world" name="world_id" onChange={onShopChange}>
                {worlds.map(world => <option key={world.id} value={world.id}>{world.name}</option>)}
              </select>
            </div>
            <div className="form-group">
              <label htmlFor="specialized_shop">Shop Type</label>
              <select className="form-control" id="specialized_shop_id" name="specialized_shop_id" onChange={onShopChange}>
                {specializedShops.map(shop => <option key={shop.id} value={shop.id}>{shop.name}</option>)}
              </select>
            </div>
          </div>
          <button className='btn btn-primary' disabled={savedItems.items.length === 0} onClick={saveShop}>Save</button>
          <hr className="hr" />
          <h5 className="mt-3">Items</h5>
          <div className="mt-3" style={{ maxHeight: '60vh', overflowY: 'auto' }}>
            {savedItems.items.length === 0 && <p>No Items</p>}
            {savedItems.items.map(item => <ItemCard key={item.id} id={item.id} name={item.name} slug={item.key} price={item.price} removeItem={removeItem} dispatch={dispatch} originalPrice={item.originalPrice || item.price} itemType={item.itemType} isInStore />)}
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
