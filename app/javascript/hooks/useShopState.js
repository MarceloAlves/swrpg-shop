import { useReducer } from 'react'
import findIndex from 'lodash/findIndex'

const INITIAL_STATE = { items: [], world_id: '1', specialized_shop_id: '1', name: '', shop_type: 'On The Level' }

export const TYPES = {
  ADD_ITEM: 'ADD_ITEM',
  REMOVE_ITEM: 'REMOVE_ITEM',
  UPDATE_PRICE: 'UPDATE_PRICE',
  UPDATE_SHOP_OPTIONS: 'UPDATE_SHOP_OPTIONS',
  SEED_LIST: 'SEED_LIST'
}

const reducer = (state, action) => {
  switch (action.type) {
    case TYPES.ADD_ITEM:
      state.items = state.items.concat(action.item)
      return { ...state }
    case TYPES.REMOVE_ITEM:
      state.items = state.items.filter(item => item.key !== action.key)
      return { ...state }
    case TYPES.UPDATE_PRICE:
      const arr = Array.from(state.items)
      const itemIndex = findIndex(arr, { key: action.item.key })
      arr.splice(itemIndex, 1, action.item)
      return { ...state, items: arr }
    case TYPES.UPDATE_SHOP_OPTIONS:
      const newState = Object.assign(state, { [action.name]: action.value })
      return { ...newState }
    case TYPES.SEED_LIST:
      state.items = action.items
      return { ...state }
    default:
      return state
  }
}

const useShopState = () => {
  const [state, dispatch] = useReducer(reducer, INITIAL_STATE)
  return [state, dispatch]
}

export default useShopState
