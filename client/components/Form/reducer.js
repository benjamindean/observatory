import { TOGGLE_ADD_FORM } from './actions';

const defaultState = {
	isOpened: false
};

export default function reducer (state = defaultState, action) {
	switch (action.type) {
	case TOGGLE_ADD_FORM:
		return Object.assign({}, state, {
			isOpened: action.isOpened
		});
	default:
		return state;
	}
}
