import { RSAA } from 'redux-api-middleware';
import getErrorAction from '../../utils/getErrorAction';

export const ADD_WATCHER = 'ADD_WATCHER';
export const REMOVE_WATCHER = 'REMOVE_WATCHER';
export const LIST_WATCHERS = 'LIST_WATCHERS';
export const UPDATE_WATCHER = 'UPDATE_WATCHER';
export const OBSERVE_WATCHER = 'OBSERVE_WATCHER';
export const ACKNOWLEDGE = 'ACKNOWLEDGE';
export const TOGGLE_LOADING_STATE = 'TOGGLE_LOADING_STATE';
export const OBSERVE_ALL_WATCHERS = 'OBSERVE_ALL_WATCHERS';

export function list () {
	return {
		[RSAA]: {
			endpoint: 'http://localhost:3000/watchers',
			method: 'GET',
			headers: {
				'content-type': 'application/json'
			},
			types: [
				'REQUEST',
				{
					type: LIST_WATCHERS,
					payload: async (action, state, res) => {
						return await res.json();
					}
				},
				getErrorAction('Failed to list watchers')
			]
		}
	};
}

export function add (watcher) {
	return {
		[RSAA]: {
			endpoint: 'http://localhost:3000/watchers',
			method: 'POST',
			body: JSON.stringify(watcher),
			headers: {
				'content-type': 'application/json'
			},
			types: [
				'REQUEST',
				{
					type: ADD_WATCHER,
					payload: async (action, state, res) => {
						return await res.json();
					}
				},
				getErrorAction('Failed to add watcher')
			]
		}
	};
}

export function observe (id) {
	return {
		[RSAA]: {
			endpoint: `http://localhost:3000/watchers/observe/${id}`,
			method: 'GET',
			headers: {
				'content-type': 'application/json'
			},
			types: [
				{
					type: TOGGLE_LOADING_STATE,
					payload: {
						id,
						isLoading: true
					}
				},
				{
					type: UPDATE_WATCHER,
					payload: async (action, state, res) => {
						const watcher = await res.json();

						return Object.assign(watcher, {
							isLoading: false
						});
					}
				},
				getErrorAction(`Failed to observe watcher ${id}`, {
					watcherId: id
				})
			]
		}
	};
}

export function acknowledge (id) {
	return {
		[RSAA]: {
			endpoint: `http://localhost:3000/watchers/acknowledge/${id}`,
			method: 'GET',
			headers: {
				'content-type': 'application/json'
			},
			types: [
				{
					type: TOGGLE_LOADING_STATE,
					payload: {
						id,
						isLoading: true
					}
				},
				{
					type: UPDATE_WATCHER,
					payload: async (action, state, res) => {
						return await res.json();
					}
				},
				getErrorAction(`Failed to acknowledge change for watcher ${id}`)
			]
		}
	};
}

export function remove (id, rev) {
	return {
		[RSAA]: {
			endpoint: `http://localhost:3000/watchers/${id}/${rev}`,
			method: 'DELETE',
			headers: {
				'content-type': 'application/json'
			},
			types: [
				'REQUEST',
				{
					type: REMOVE_WATCHER,
					payload: id
				},
				getErrorAction(`Failed remove watcher ${id}`)
			]
		}
	};
}

export function toggleLoadingState (id, isLoading = false) {
	return {
		type: TOGGLE_LOADING_STATE,
		payload: {
			id,
			isLoading
		}
	};
}
