export const ADD_WATCHER = 'ADD_WATCHER';
export const REMOVE_WATCHER = 'REMOVE_WATCHER';
export const LIST_WATCHERS = 'LIST_WATCHERS';
export const CHECK_WATCHER = 'CHECK_WATCHER';

export function list () {
	return async function (dispatch) {
		const response = await fetch('http://localhost:3000/watchers');
		const watchers = await response.json();

		return dispatch({
			type: LIST_WATCHERS,
			watchers
		});
	};
}

export function add (watcher) {
	return async function (dispatch) {
		await fetch('http://localhost:3000/watchers/', {
			method: 'POST',
			mode: 'cors',
			body: JSON.stringify(watcher),
			headers: {
				'content-type': 'application/json'
			}
		});

		return dispatch(list());
	};
}

export function check (id) {
	return async function (dispatch) {
		await fetch(`http://localhost:3000/watchers/check/${id}`, {
			method: 'GET',
			mode: 'cors'
		});

		return dispatch({
			type: LIST_WATCHERS
		});
	};
}

export function remove (id, rev) {
	return async function (dispatch) {
		await fetch(`http://localhost:3000/watchers/${id}/${rev}`, {
			method: 'DELETE',
			mode: 'cors'
		});

		return dispatch(list());
	};
}
