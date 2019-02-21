import { useState, useCallback } from 'react'
import groupBy from 'lodash/groupBy'

const INITIAL_STATE = {
  armor: [],
  gear: [],
  item_attachments: [],
  weapons: []
}

const parseData = items => {
  let data = INITIAL_STATE

  if (items.length > 0) {
    data = groupBy(items, 'item_type')
    data = { ...INITIAL_STATE, ...data }
  }

  return data
}

export const useItemList = (items = []) => {
  const [parsedItems, setParsedItems] = useState(parseData(items))
  return [parsedItems, useCallback((items) => setParsedItems(parseData(items)))]
}
