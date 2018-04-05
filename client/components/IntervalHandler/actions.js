export const SET_INTERVAL = 'SET_INTERVAL';
export const GET_INTERVAL = 'GET_INTERVAL';

export function set (interval) {
	return async (dispatch) => {
		const response = await fetch('http://localhost:3000/settings', {
			method: 'POST',
			mode: 'cors',
			body: JSON.stringify({
				key: 'interval',
				value: interval
			}),
			headers: {
				'content-type': 'application/json'
			}
		});

		const { value } = await response.json();

		return dispatch({
			type: SET_INTERVAL,
			interval: value
		});
	};
}

export function get () {
	return async (dispatch) => {
		const response = await fetch('http://localhost:3000/settings/interval', {
			method: 'GET',
			mode: 'cors',
			headers: {
				'content-type': 'application/json'
			}
		});

		const { value } = await response.json();

		return dispatch({
			type: GET_INTERVAL,
			interval: value
		});
	};
}
