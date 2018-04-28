import { TOGGLE_ADD_FORM, TOGGLE_MANUAL_INPUT } from './actions';

type formState = {
	isOpened: boolean,
	isManual: boolean
};

const defaultState: formState = {
	isOpened: false,
	isManual: false
};

export default function reducer (state = defaultState, action) {
	switch (action.type) {
	case TOGGLE_ADD_FORM:
		return Object.assign({}, state, {
			isOpened: action.isOpened
		});
	case TOGGLE_MANUAL_INPUT:
		return Object.assign({}, state, {
			isManual: action.isManual
		});
	default:
		return state;
	}
}
