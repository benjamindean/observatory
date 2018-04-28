import { RSAA } from 'redux-api-middleware';
import { WatcherItem } from '../../types';

// Main Actions
export const ADD_WATCHER = 'ADD_WATCHER';
export const REMOVE_WATCHER = 'REMOVE_WATCHER';
export const LIST_WATCHERS = 'LIST_WATCHERS';
export const UPDATE_WATCHER = 'UPDATE_WATCHER';
export const OBSERVE_WATCHER = 'OBSERVE_WATCHER';
export const ACKNOWLEDGE = 'ACKNOWLEDGE';
export const TOGGLE_LOADING_STATE = 'TOGGLE_LOADING_STATE';
export const OBSERVE_ALL_WATCHERS = 'OBSERVE_ALL_WATCHERS';

// Errors
export const ERROR_LIST_WATCHERS = 'ERROR_LIST_WATCHERS';
export const ERROR_UPDATE_WATCHER = 'ERROR_UPDATE_WATCHER';
export const ERROR_ADD_WATCHER = 'ERROR_ADD_WATCHER';
export const ERROR_OBSERVE_WATCHER = 'ERROR_OBSERVE_WATCHER';
export const ERROR_REMOVE_WATCHER = 'ERROR_REMOVE_WATCHER';

export function toggleLoadingState (id, isLoading = false) {
	return {
		type: TOGGLE_LOADING_STATE,
		payload: {
			id,
			isLoading
		}
	};
}

export function list () {
	return (dispatch) => {
		return dispatch({
			[RSAA]: {
				endpoint: 'http://localhost:3000/watchers',
				method: 'GET',
				headers: {
					'content-type': 'application/json'
				},
				types: [
					'LIST_WATCHERS_REQUEST',
					{
						type: LIST_WATCHERS,
						payload: async (action, state, res): Object => {
							return await res.json();
						}
					},
					{
						type: ERROR_LIST_WATCHERS,
						payload: async (action, state, res): Object => {
							const { error } = await res.json();

							return error;
						},
						meta: {
							error: {
								message: 'Failed to list watchers'
							}
						}
					}
				]
			}
		});
	};
}

export function add (watcher: WatcherItem) {
	return (dispatch) => {
		return dispatch({
			[RSAA]: {
				endpoint: 'http://localhost:3000/watchers',
				method: 'POST',
				body: JSON.stringify(watcher),
				headers: {
					'content-type': 'application/json'
				},
				types: [
					'ADD_WATCHER_REQUEST',
					{
						type: ADD_WATCHER,
						payload: async (action, state, res): Object => {
							return await res.json();
						}
					},
					{
						type: ERROR_ADD_WATCHER,
						payload: async (action, state, res): Object => {
							const { error } = await res.json();

							return error;
						},
						meta: {
							error: {
								message: 'Failed to add watcher'
							}
						}
					}
				]
			}
		});
	};
}

export function observe (id: string) {
	return (dispatch) => {
		return dispatch({
			[RSAA]: {
				endpoint: `http://localhost:3000/watchers/observe/${id}`,
				method: 'GET',
				headers: {
					'content-type': 'application/json'
				},
				types: [
					toggleLoadingState(id, true),
					{
						type: UPDATE_WATCHER,
						payload: async (action, state, res): Object => {
							await dispatch(toggleLoadingState(id, false));

							return await res.json();
						}
					},
					{
						type: ERROR_OBSERVE_WATCHER,
						payload: async (action, state, res): Object => {
							const { error } = await res.json();

							await dispatch(toggleLoadingState(id, false));

							return error;
						},
						meta: {
							error: {
								message: `Failed to observe watcher ${id}`
							}
						}
					}
				]
			}
		});
	};
}

export function update (watcher: WatcherItem) {
	return (dispatch) => {
		return dispatch({
			[RSAA]: {
				endpoint: `http://localhost:3000/watchers/update/${watcher._id}`,
				method: 'POST',
				body: JSON.stringify(watcher),
				headers: {
					'content-type': 'application/json'
				},
				types: [
					toggleLoadingState(watcher._id, true),
					{
						type: UPDATE_WATCHER,
						payload: async (action, state, res): Object => {
							await dispatch(toggleLoadingState(watcher._id, false));

							return await res.json();
						}
					},
					{
						type: ERROR_UPDATE_WATCHER,
						payload: async (action, state, res): Object => {
							const { error } = await res.json();

							await dispatch(toggleLoadingState(watcher._id, false));

							return error;
						},
						meta: {
							error: {
								message: `Failed to update for watcher ${watcher._id}`
							}
						}
					}
				]
			}
		});
	};
}

export function remove (id: string, rev: string) {
	return (dispatch) => {
		return dispatch({
			[RSAA]: {
				endpoint: `http://localhost:3000/watchers/${id}/${rev}`,
				method: 'DELETE',
				headers: {
					'content-type': 'application/json'
				},
				types: [
					'REMOVE_WATCHER_REQUEST',
					{
						type: REMOVE_WATCHER,
						payload: id
					},
					{
						type: ERROR_REMOVE_WATCHER,
						payload: async (action, state, res): Object => {
							const { error } = await res.json();

							await dispatch(toggleLoadingState(id, false));

							return error;
						},
						meta: {
							error: {
								message: `Failed to remove watcher ${id}`
							}
						}
					}
				]
			}
		});
	};
}
