import { RSAA } from 'redux-api-middleware';
import getErrorAction from '../../utils/getErrorAction';

export const SET_INTERVAL = 'SET_INTERVAL';
export const GET_INTERVAL = 'GET_INTERVAL';

export function get () {
	return {
		[RSAA]: {
			endpoint: 'http://localhost:3000/settings/interval',
			method: 'GET',
			headers: {
				'content-type': 'application/json'
			},
			types: [
				'REQUEST',
				{
					type: GET_INTERVAL,
					payload: async (action, state, res) => {
						const response = await res.json();

						return response.value;
					}
				},
				getErrorAction('Failed to get interval')
			]
		}
	};
}

export function set (interval) {
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
				'REQUEST',
				{
					type: SET_INTERVAL,
					payload: async (action, state, res) => {
						const response = await res.json();

						return response.value;
					}
				},
				getErrorAction('Failed to set interval')
			]
		}
	};
}
