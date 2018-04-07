import { ADD_TOAST, REMOVE_TOAST } from './actions';

export default function reducer (state = [], action) {
	switch (action.type) {
	case ADD_TOAST:
		return [...state, action.toast];
	case REMOVE_TOAST:
		return state.filter((toast) => {
			return toast.key !== action.toast.key;
		});
	default:
		return state;
	}
}
