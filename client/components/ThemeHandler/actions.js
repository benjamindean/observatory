import { RSAA } from 'redux-api-middleware';
import getErrorAction from '../../utils/getErrorAction';

export const SET_THEME = 'SET_THEME';
export const GET_THEME = 'GET_THEME';

export function get () {
	return {
		[RSAA]: {
			endpoint: 'http://localhost:3000/settings/theme',
			method: 'GET',
			headers: {
				'content-type': 'application/json'
			},
			types: [
				'REQUEST',
				{
					type: GET_THEME,
					payload: async (action, state, res) => {
						const response = await res.json();

						return response.value;
					}
				},
				getErrorAction('Failed to get theme')
			]
		}
	};
}

export function set (theme) {
	return {
		[RSAA]: {
			endpoint: 'http://localhost:3000/settings',
			method: 'POST',
			body: JSON.stringify({
				key: 'theme',
				value: theme
			}),
			headers: {
				'content-type': 'application/json'
			},
			types: [
				'REQUEST',
				{
					type: SET_THEME,
					payload: async (action, state, res) => {
						const response = await res.json();

						return response.value;
					}
				},
				getErrorAction('Failed to set theme')
			]
		}
	};
}
