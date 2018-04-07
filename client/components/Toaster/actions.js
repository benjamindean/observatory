export const ADD_TOAST = 'ADD_TOAST';
export const REMOVE_TOAST = 'REMOVE_TOAST';

export function add (toast) {
	return {
		type: ADD_TOAST,
		toast: Object.assign({}, toast, {
			key: Math.random()
		})
	};
}

export function remove (toast) {
	return {
		type: REMOVE_TOAST,
		toast
	};
}
