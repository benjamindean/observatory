import fetchResponse from '../../utils/fetchResponse';

export const SET_THEME = 'SET_THEME';
export const GET_THEME = 'GET_THEME';

export function set (theme) {
	return async (dispatch) => {
		const { value } = await fetchResponse('http://localhost:3000/settings', {
			method: 'POST',
			body: JSON.stringify({
				key: 'theme',
				value: theme
			})
		});

		return dispatch({
			type: SET_THEME,
			theme: value
		});
	};
}

export function get () {
	return async (dispatch) => {
		const { value } = await fetchResponse('http://localhost:3000/settings/theme', {
			method: 'GET'
		});

		return dispatch({
			type: GET_THEME,
			theme: value
		});
	};
}
