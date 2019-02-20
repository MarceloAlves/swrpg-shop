import React, {useReducer, useState, useEffect} from "react"
import PropTypes from "prop-types"
import ItemCard from "./Item/ItemCard";
import Fuse from 'fuse.js'
import groupBy from 'lodash/groupBy'
import { useItemList } from '../hooks/useItemlist'

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
      const newItems = state.items.filter(item => item.id !== action.id);
      return { items: newItems }
    default:
      return state;
  }
}

const CustomShop = ({ items }) => {
  const fuse = new Fuse(items, SEARCH_OPTIONS)
  const [savedItems, dispatch] = useReducer(reducer, {items: []})
  const [itemList, setItemList] = useItemList(items)
  const [searchValue, setSearchValue] = useState('')

  const addItem = (itemType, item) => {
    dispatch({ type: 'ADD_ITEM', item: { ...item } })
  }

  const removeItem = id => {
    dispatch({ type: 'REMOVE_ITEM', id })
  }

  const filterItems = e => {
    const {target: { value }} = e
    let results = items

    if(value.length !== 0) {
      results = fuse.search(value)
    }

    setItemList(results)
    setSearchValue(value)
  }

  const resetForm = e => {
    setItemList(items)
  }

  return (
    <div className="container-fluid">
      <div className="row">
        <div className="col-12 p-5">
          <div className="input-group">
            <input className={'form-control form-control-lg'} placeholder='Search...' name='search' value={searchValue} onChange={filterItems} />
            <div className="input-group-append">
            <button className="btn btn-lg btn-danger" onClick={resetForm} type="button"><i className='fa fa-times' /></button>
            </div>
          </div>
        </div>
      </div>
      <div className="row">
        <div className="col-2">
          <h3>Armor</h3>
          <div style={{maxHeight: '90vh', overflowY: 'auto'}}>
            {itemList
              .armor
              .map(item => <ItemCard
                key={`armor-${item.id}`}
                id={item.id}
                name={item.name}
                price={item.price}
                rarity={item.rarity}
                is_restricted={item.is_restricted}
                itemType={'armor'}
                addItem={addItem} />)}
          </div>
        </div>
        <div className="col-2">
          <h3>Gear</h3>
          <div style={{maxHeight: '90vh', overflowY: 'auto'}}>
            {itemList
              .gear
              .map(item => <ItemCard
                key={`gear-${item.id}`}
                id={item.id}
                name={item.name}
                price={item.price}
                rarity={item.rarity}
                is_restricted={item.is_restricted}
                itemType={'gear'}
                addItem={addItem} />)}
          </div>
        </div>
        <div className="col-2">
          <h3>Item Attachments</h3>
          <div style={{maxHeight: '90vh', overflowY: 'auto'}}>
            {itemList
              .item_attachments
              .map(item => <ItemCard
                key={`item_attachments-${item.id}`}
                id={item.id}
                name={item.name}
                price={item.price}
                rarity={item.rarity}
                is_restricted={item.is_restricted}
                itemType={'item_attachments'}
                addItem={addItem} />)}
          </div>
        </div>
        <div className="col-2">
          <h3>Weapons</h3>
          <div style={{maxHeight: '90vh', overflowY: 'auto'}}>
            {itemList
              .weapons
              .map(item => <ItemCard
                id={item.id}
                key={`weapons-${item.id}`}
                name={item.name}
                price={item.price}
                rarity={item.rarity}
                is_restricted={item.is_restricted}
                itemType={'weapons'}
                removeItem={removeItem}
                addItem={addItem} />
              )}
          </div>
        </div>
        <div className="col-3">
          <h3>In Store</h3>
          <div style={{maxHeight: '90vh', overflowY: 'auto'}}>
            {savedItems.items.map(item => <ItemCard key={item.id} {...item} removeItem={removeItem} isInStore />)}
          </div>
        </div>
      </div>
    </div>
  );
}

CustomShop.propTypes = {
  items: PropTypes.arrayOf(PropTypes.shape({
    id: PropTypes.number,
    is_restricted: PropTypes.bool,
    key: PropTypes.string,
    name: PropTypes.string,
    price: PropTypes.number,
    rarity: PropTypes.number
  }),),
}

export default React.memo(CustomShop);
