import { TOGGLE_ADD_FORM, SET_INTERVAL_ID } from './actions';

const defaultState = {
	isAddFormOpened: false,
	intervalId: null
};

export default function reducer (state = defaultState, action) {
	switch (action.type) {
	case TOGGLE_ADD_FORM:
		return Object.assign({}, state, {
			isAddFormOpened: !state.isAddFormOpened
		});
	case SET_INTERVAL_ID: {
		if (state.intervalId) {
			clearInterval(state.intervalId);
		}

		return Object.assign({}, state, {
			intervalId: action.intervalId
		});
	}
	default:
		return state;
	}
}
