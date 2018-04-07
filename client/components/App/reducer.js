import { SET_INTERVAL_ID } from './actions';

const defaultState = {
	intervalId: null
};

export default function reducer (state = defaultState, action) {
	switch (action.type) {
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
