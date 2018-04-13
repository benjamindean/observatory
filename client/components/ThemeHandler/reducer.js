import { SET_THEME, GET_THEME } from './actions';

export default function reducer (state: string = 'pt-light', action) {
	switch (action.type) {
	case SET_THEME:
	case GET_THEME:
		return action.payload || state;
	default:
		return state;
	}
}
