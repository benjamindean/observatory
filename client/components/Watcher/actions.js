import fetchResponse from '../../utils/fetchResponse';

export const ADD_WATCHER = 'ADD_WATCHER';
export const REMOVE_WATCHER = 'REMOVE_WATCHER';
export const LIST_WATCHERS = 'LIST_WATCHERS';
export const UPDATE_WATCHER = 'UPDATE_WATCHER';
export const OBSERVE_WATCHER = 'OBSERVE_WATCHER';
export const ACKNOWLEDGE = 'ACKNOWLEDGE';
export const TOGGLE_LOADING_STATE = 'TOGGLE_LOADING_STATE';
export const OBSERVE_ALL_WATCHERS = 'OBSERVE_ALL_WATCHERS';

export function list () {
	return async (dispatch) => {
		const watchers = await fetchResponse('http://localhost:3000/watchers');

		return dispatch({
			type: LIST_WATCHERS,
			watchers
		});
	};
}

export function add (watcher) {
	return async (dispatch) => {
		const addedWatcher = await fetchResponse('http://localhost:3000/watchers', {
			method: 'POST',
			body: JSON.stringify(watcher)
		});

		return dispatch({
			type: ADD_WATCHER,
			watcher: addedWatcher
		});
	};
}

export function observe (id) {
	return async (dispatch) => {
		const watcher = await fetchResponse(`http://localhost:3000/watchers/observe/${id}`, {
			method: 'GET'
		});

		return dispatch({
			type: UPDATE_WATCHER,
			watcher
		});
	};
}

export function acknowledge (id) {
	return async (dispatch) => {
		const watcher = await fetchResponse(`http://localhost:3000/watchers/acknowledge/${id}`, {
			method: 'GET'
		});

		return dispatch({
			type: UPDATE_WATCHER,
			watcher
		});
	};
}

export function remove (id, rev) {
	return async (dispatch) => {
		await fetchResponse(`http://localhost:3000/watchers/${id}/${rev}`, {
			method: 'DELETE'
		});

		return dispatch({
			type: REMOVE_WATCHER,
			watcherId: id
		});
	};
}

export function toggleLoadingState (id) {
	return {
		type: TOGGLE_LOADING_STATE,
		watcherId: id
	};
}
