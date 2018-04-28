import { GET_INTERVAL, SET_INTERVAL } from './actions';

export default function reducer (state: number = 60, action) {
	switch (action.type) {
	case SET_INTERVAL:
	case GET_INTERVAL:
		return action.payload || state;
	default:
		return state;
	}
}
