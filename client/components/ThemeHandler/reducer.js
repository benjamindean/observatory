import { SET_THEME, GET_THEME } from './actions';

export default function reducer (state = 'pt-light', action) {
	switch (action.type) {
	case SET_THEME:
	case GET_THEME:
		return action.theme;
	default:
		return state;
	}
}
