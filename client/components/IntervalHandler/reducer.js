import { SET_INTERVAL, GET_INTERVAL } from './actions';

export default function reducer (state = 60, action) {
	switch (action.type) {
	case SET_INTERVAL:
	case GET_INTERVAL:
		return action.payload || state;
	default:
		return state;
	}
}
