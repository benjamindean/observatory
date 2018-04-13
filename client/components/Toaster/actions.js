import { IToastProps } from '@blueprintjs/core';

export const ADD_TOAST = 'ADD_TOAST';
export const REMOVE_TOAST = 'REMOVE_TOAST';

export function add (toast: IToastProps) {
	return {
		type: ADD_TOAST,
		toast: Object.assign({}, toast, {
			key: Math.random()
		})
	};
}

export function remove (toast: IToastProps) {
	return {
		type: REMOVE_TOAST,
		toast
	};
}
