export const SET_THEME = 'SET_THEME';
export const GET_THEME = 'GET_THEME';

export function set (theme) {
	return async (dispatch) => {
		const response = await fetch('http://localhost:3000/settings', {
			method: 'POST',
			mode: 'cors',
			body: JSON.stringify({
				key: 'theme',
				value: theme
			}),
			headers: {
				'content-type': 'application/json'
			}
		});

		const { value } = await response.json();

		return dispatch({
			type: SET_THEME,
			theme: value
		});
	};
}

export function get () {
	return async (dispatch) => {
		const response = await fetch('http://localhost:3000/settings/theme', {
			method: 'GET',
			mode: 'cors',
			headers: {
				'content-type': 'application/json'
			}
		});

		const { value } = await response.json();

		return dispatch({
			type: GET_THEME,
			theme: value
		});
	};
}
