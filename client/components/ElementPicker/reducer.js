import { ELEMENT_SELECTED } from './actions';

export default function reducer (state = '', action) {
	switch (action.type) {
	case ELEMENT_SELECTED: {
		return action.payload.element;
	}
	default:
		return state;
	}
}
