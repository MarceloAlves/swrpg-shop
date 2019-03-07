import { useReducer } from 'react'
import findIndex from 'lodash/findIndex'

const INITIAL_STATE = { items: [], world_id: '1', specialized_shop_id: '1', name: '', shop_type: 'On The Level' }

export const TYPES = {
  ADD_ITEM: 'ADD_ITEM',
  REMOVE_ITEM: 'REMOVE_ITEM',
  UPDATE_SHOP_ITEM: 'UPDATE_SHOP_ITEM',
  UPDATE_SHOP_OPTIONS: 'UPDATE_SHOP_OPTIONS',
  SEED_LIST: 'SEED_LIST'
}

const reducer = (state, action) => {
  let newState = { ...state }
  switch (action.type) {
    case TYPES.ADD_ITEM:
      newState.items = newState.items.concat(action.item)
      return { ...newState }
    case TYPES.REMOVE_ITEM:
      newState.items = newState.items.filter(item => item.key !== action.key)
      return { ...newState }
    case TYPES.UPDATE_SHOP_ITEM:
      const itemIndex = findIndex(newState.items, { key: action.item.key })
      newState.items.splice(itemIndex, 1, action.item)
      return { ...newState }
    case TYPES.UPDATE_SHOP_OPTIONS:
      return { ...newState, [action.name]: action.value }
    case TYPES.SEED_LIST:
      return { ...newState, items: action.items }
    default:
      throw new Error('Missing Type')
  }
}

const useShopState = () => {
  const [state, dispatch] = useReducer(reducer, INITIAL_STATE)
  return [state, dispatch]
}

export default useShopState
