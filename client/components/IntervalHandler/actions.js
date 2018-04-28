import { RSAA } from 'redux-api-middleware';

// Main Actions
export const SET_INTERVAL = 'SET_INTERVAL';
export const GET_INTERVAL = 'GET_INTERVAL';

// Errors
export const ERROR_SET_INTERVAL = 'ERROR_SET_INTERVAL';
export const ERROR_GET_INTERVAL = 'ERROR_GET_INTERVAL';

export function get () {
	return {
		[RSAA]: {
			endpoint: 'http://localhost:3000/settings/interval',
			method: 'GET',
			headers: {
				'content-type': 'application/json'
			},
			types: [
				'GET_INTERVAL_REQUEST',
				{
					type: GET_INTERVAL,
					payload: async (action, state, res): number => {
						const { value } = await res.json();

						return value;
					}
				},
				{
					type: ERROR_GET_INTERVAL,
					payload: async (action, state, res): Object => {
						const { error } = await res.json();

						return error;
					},
					meta: {
						error: {
							message: 'Failed to get interval'
						}
					}
				}
			]
		}
	};
}

export function set (interval: number) {
	return {
		[RSAA]: {
			endpoint: 'http://localhost:3000/settings',
			method: 'POST',
			body: JSON.stringify({
				key: 'interval',
				value: interval
			}),
			headers: {
				'content-type': 'application/json'
			},
			types: [
				'SET_INTERVAL_REQUEST',
				{
					type: SET_INTERVAL,
					payload: async (action, state, res): number => {
						const { value } = await res.json();

						return value;
					}
				},
				{
					type: ERROR_SET_INTERVAL,
					payload: async (action, state, res): Object => {
						const { error } = await res.json();

						return error;
					},
					meta: {
						error: {
							message: 'Failed to set interval'
						}
					}
				}
			]
		}
	};
}
