export const ADD_WATCHER = 'ADD_WATCHER';
export const REMOVE_WATCHER = 'REMOVE_WATCHER';
export const LIST_WATCHERS = 'LIST_WATCHERS';
export const UPDATE_WATCHER = 'UPDATE_WATCHER';
export const OBSERVE_WATCHER = 'OBSERVE_WATCHER';
export const ACKNOWLEDGE = 'ACKNOWLEDGE';

export function list () {
	return async (dispatch) => {
		const response = await fetch('http://localhost:3000/watchers');
		const watchers = await response.json();

		return dispatch({
			type: LIST_WATCHERS,
			watchers
		});
	};
}

export function add (watcher) {
	return async (dispatch) => {
		const response = await fetch('http://localhost:3000/watchers/', {
			method: 'POST',
			mode: 'cors',
			body: JSON.stringify(watcher),
			headers: {
				'content-type': 'application/json'
			}
		});
		const addedWatcher = await response.json();

		return dispatch({
			type: ADD_WATCHER,
			watcher: addedWatcher
		});
	};
}

export function observe (id) {
	return async (dispatch) => {
		try {
			const response = await fetch(`http://localhost:3000/watchers/observe/${id}`, {
				method: 'GET',
				mode: 'cors'
			});
			const watcher = await response.json();

			return dispatch({
				type: UPDATE_WATCHER,
				watcher
			});
		} catch (error) {
			throw error;
		}
	};
}

export function acknowledge (id) {
	return async (dispatch) => {
		const response = await fetch(`http://localhost:3000/watchers/acknowledge/${id}`, {
			method: 'GET',
			mode: 'cors'
		});
		const watcher = await response.json();

		return dispatch({
			type: UPDATE_WATCHER,
			watcher
		});
	};
}

export function remove (id, rev) {
	return async (dispatch) => {
		await fetch(`http://localhost:3000/watchers/${id}/${rev}`, {
			method: 'DELETE',
			mode: 'cors'
		});

		return dispatch({
			type: REMOVE_WATCHER,
			watcherId: id
		});
	};
}
