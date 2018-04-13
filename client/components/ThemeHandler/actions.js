import { RSAA } from 'redux-api-middleware';

// Main Actions
export const SET_THEME = 'SET_THEME';
export const GET_THEME = 'GET_THEME';

// Errors
export const ERROR_SET_THEME = 'ERROR_SET_THEME';
export const ERROR_GET_THEME = 'ERROR_GET_THEME';

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
					payload: async (action, state, res): string => {
						const { value } = await res.json();

						return value;
					}
				},
				{
					type: ERROR_GET_THEME,
					payload: async (action, state, res): Object => {
						const { error } = await res.json();

						return error;
					},
					meta: {
						error: {
							message: 'Failed to get theme'
						}
					}
				}
			]
		}
	};
}

export function set (theme: string) {
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
					payload: async (action, state, res): string => {
						const { value } = await res.json();

						return value;
					}
				},
				{
					type: ERROR_SET_THEME,
					payload: async (action, state, res): Object => {
						const { error } = await res.json();

						return error;
					},
					meta: {
						error: {
							message: 'Failed to set theme'
						}
					}
				}
			]
		}
	};
}
