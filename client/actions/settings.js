export const ADD_SETTING = 'ADD_SETTING';
export const REMOVE_SETTING = 'REMOVE_SETTING';
export const LIST_SETTINGS = 'LIST_SETTINGS';
export const UPDATE_SETTING = 'UPDATE_SETTING';

export function list () {
	return async (dispatch) => {
		const response = await fetch('http://localhost:3000/settings');
		const settings = await response.json();

		return dispatch({
			type: LIST_SETTINGS,
			settings
		});
	};
}

export function add (setting) {
	return async (dispatch) => {
		const response = await fetch('http://localhost:3000/settings', {
			method: 'POST',
			mode: 'cors',
			body: JSON.stringify(setting),
			headers: {
				'content-type': 'application/json'
			}
		});
		const addedSetting = await response.json();

		return dispatch({
			type: ADD_SETTING,
			setting: addedSetting
		});
	};
}

export function update (id, setting) {
	return async (dispatch) => {
		const response = await fetch(`http://localhost:3000/watchers/settings/${id}`, {
			method: 'POST',
			mode: 'cors',
			body: JSON.stringify(setting),
			headers: {
				'content-type': 'application/json'
			}
		});
		const updatedSetting = await response.json();

		return dispatch({
			type: UPDATE_SETTING,
			updatedSetting
		});
	};
}

export function remove (id, rev) {
	return async (dispatch) => {
		await fetch(`http://localhost:3000/settings/${id}/${rev}`, {
			method: 'DELETE',
			mode: 'cors'
		});

		return dispatch({
			type: REMOVE_SETTING,
			watcherId: id
		});
	};
}
