import fetchResponse from '../../utils/fetchResponse';

export const SET_INTERVAL = 'SET_INTERVAL';
export const GET_INTERVAL = 'GET_INTERVAL';

export function set (interval) {
	return async (dispatch) => {
		const { value } = await fetchResponse('http://localhost:3000/settings', {
			method: 'POST',
			body: JSON.stringify({
				key: 'interval',
				value: interval
			})
		});

		return dispatch({
			type: SET_INTERVAL,
			interval: value
		});
	};
}

export function get () {
	return async (dispatch) => {
		const { value } = await fetchResponse('http://localhost:3000/settings/interval', {
			method: 'GET'
		});

		return dispatch({
			type: GET_INTERVAL,
			interval: value
		});
	};
}
