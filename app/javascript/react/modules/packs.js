import { displayAlertMessage } from './alertMessage.js'

const initialState = {
  returnedCards: null,
  isFetching: false
}

const packs = (state = initialState, action) => {
  switch(action.type) {
    case POST_IMAGE_REQUEST:
      return {
        ...state,
        isFetching: true
      }
    case POST_IMAGE_REQUEST_SUCCESS:
      return {
        ...state,
        returnedCards: action.returnedCards,
        isFetching: false
      }
    case POST_IMAGE_REQUEST_FAILURE:
      return {
        ...state,
        isFetching: false
      }
    default:
      return state
  }
}

const POST_IMAGE_REQUEST = "POST_IMAGE_REQUEST"
const postImageRequest = () => {
  return {
    type: POST_IMAGE_REQUEST
  }
}

const POST_IMAGE_REQUEST_SUCCESS = 'POST_IMAGE_REQUEST_SUCCESS'
const postImageRequestSuccess = returnedCards => {
  return {
    type: POST_IMAGE_REQUEST_SUCCESS,
    returnedCards
  }
}

const POST_IMAGE_REQUEST_FAILURE = 'POST_IMAGE_REQUEST_FAILURE'
const postImageRequestFailure = () => {
  return {
    type: POST_IMAGE_REQUEST_FAILURE
  }
}

const postImage = image => {
  return (dispatch) => {
    dispatch(postImageRequest())
    
    return fetch('/api/v1/screenshots', {
      method: "POST",
      body: image,
      credentials: 'same-origin'
    })
    .then(response => {
      if (response.ok) {
        return response
      } else {
        dispatch(postImageRequestFailure()),
        dispatch(displayAlertMessage("Something went wrong"))
        return { error: 'Something went wrong' }
      }
    })
    .then(response => response.json())
    .then(response => {
      if (!response.error) {
        dispatch(postImageRequestSuccess(response.returned_cards))
      }
    })
  }
}

export {
  packs,
  postImage
}
