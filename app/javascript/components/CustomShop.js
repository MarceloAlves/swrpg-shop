import React, { useState } from 'react'
import PropTypes from 'prop-types'
import Fuse from 'fuse.js'
import axios from 'axios'
import ItemContainer from './Item/ItemContainer'
import ItemStoreRow from './Item/ItemStoreRow'
import useShopState, { TYPES } from '../hooks/useShopState'

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

const ITEM_TYPES = ['armor', 'gear', 'item_attachments', 'weapons']

const CustomShop = ({ items, worlds, specializedShops }) => {
  const [savedItems, dispatch] = useShopState()
  const [filteredItems, setFilteredItems] = useState([])
  const [searchValue, setSearchValue] = useState('')
  const fuse = new Fuse(items, SEARCH_OPTIONS)

  const filterItems = e => {
    const { target: { value } } = e
    let results = []

    if (value.length !== 0) {
      results = fuse.search(value)
    }

    setFilteredItems(results)
    setSearchValue(value)
  }

  const onShopChange = e => {
    const { target: { value, name } } = e
    dispatch({ type: TYPES.UPDATE_SHOP_OPTIONS, value, name })
  }

  const saveShop = () => {
    axios.post('/custom_shops', { shop: { ...savedItems }, 'authenticity_token': document.querySelector('meta[name="csrf-token"]').content }).then(result => {
      const { data: { slug } } = result
      Turbolinks.visit(`/shops/${slug}`) // eslint-disable-line
    })
  }

  return (
    <div className='container-fluid'>
      <div className='row bg-light'>
        <div className='col-12 p-5'>
          <div className='input-group'>
            <input className='form-control form-control-lg' placeholder='Filter...' name='search' value={searchValue} onChange={filterItems} />
            <div className='input-group-append'>
              <button className='btn btn-lg btn-danger' onClick={() => filterItems({ target: { value: '' } })} type='button'><i className='fa fa-times' /></button>
            </div>
          </div>
        </div>
      </div>
      <div className='row'>
        <div className='col-3 pt-2 mh-100 bg-light'>
          <h3>Store</h3>
          <div>
            <h5>Settings</h5>
            <div className='form-group row'>
              <div className='col-3'>
                <label htmlFor='shop_name'>Name</label>
              </div>
              <div className='col-9'>
                <input type='text' className='form-control form-control-sm' id='shop_name' name='name' onChange={onShopChange} />
              </div>
            </div>
            <div className='form-group row'>
              <div className='col-3'>
                <label htmlFor='shop_type'>Shop Type</label>
              </div>
              <div className='col-9'>
                <select className='form-control form-control-sm' id='shop_type' name='shop_type' onChange={onShopChange}>
                  <option value='On The Level'>On The Level</option>
                  <option value='Shady'>Shady</option>
                  <option value='Black Market'>Black Market</option>
                </select>
              </div>
            </div>
            <div className='form-group row'>
              <div className='col-3'>
                <label htmlFor='world'>World</label>
              </div>
              <div className='col-9'>
                <select className='form-control form-control-sm' id='world' name='world_id' onChange={onShopChange}>
                  {worlds.map(world => <option key={world.id} value={world.id}>{world.name}</option>)}
                </select>
              </div>
            </div>
            <div className='form-group row'>
              <div className='col-3'>
                <label htmlFor='specialized_shop'>Specialization</label>
              </div>
              <div className='col-9'>
                <select className='form-control form-control-sm' id='specialized_shop_id' name='specialized_shop_id' onChange={onShopChange}>
                  {specializedShops.map(shop => <option key={shop.id} value={shop.id}>{shop.name}</option>)}
                </select>
              </div>
            </div>
          </div>
          <button className='btn btn-block btn-primary' disabled={savedItems.items.length === 0} onClick={saveShop}>Save</button>
          <hr className='hr' />
          <h5 className='mt-3'>Items</h5>
          <div className='col-12 mt-3 overflow-auto' style={{ maxHeight: '90vh' }}>
            {savedItems.items.length === 0 && <p>No Items</p>}
            {savedItems.items.map(item => (
              <ItemStoreRow
                key={item.id}
                id={item.id}
                name={item.name}
                dispatch={dispatch}
                slug={item.key}
                price={item.price}
                originalPrice={item.originalPrice || item.price}
                itemType={item.itemType}
                isInStore />
            ))}
          </div>
        </div>
        {ITEM_TYPES.map(itemType => (
          <ItemContainer
            key={`${itemType}-container`}
            itemType={itemType}
            items={items}
            dispatch={dispatch}
            filteredItems={filteredItems}
            savedItems={savedItems.items} />
        ))}

      </div>
    </div> // end container-fluid
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
  })),
  worlds: PropTypes.arrayOf(PropTypes.shape({
    id: PropTypes.number,
    name: PropTypes.string,
    description: PropTypes.string,
    rarity_modifier: PropTypes.number,
    price_modifier: PropTypes.number,
    created_at: PropTypes.string,
    updated_at: PropTypes.string,
    is_default: PropTypes.bool,
    user_id: PropTypes.number
  })),
  specializedShops: PropTypes.arrayOf(PropTypes.shape({
    id: PropTypes.number,
    name: PropTypes.string,
    description: PropTypes.string,
    item_types: PropTypes.arrayOf(PropTypes.string),
    created_at: PropTypes.string,
    updated_at: PropTypes.string,
    is_default: PropTypes.bool,
    user_id: PropTypes.number
  }))
}

export default React.memo(CustomShop)
