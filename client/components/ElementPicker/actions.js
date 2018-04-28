import { change } from 'redux-form';
import { RSAA } from 'redux-api-middleware';

export const ELEMENT_SELECTED = 'ELEMENT_SELECTED';

export function openPicker (url) {
	return (dispatch) => {
		return dispatch({
			[RSAA]: {
				endpoint: 'http://localhost:3000/watchers/pick',
				method: 'POST',
				body: JSON.stringify({
					url
				}),
				headers: {
					'content-type': 'application/json'
				},
				types: [
					'ELEMENT_SELECTED_REQUEST',
					{
						type: ELEMENT_SELECTED,
						payload: async (action, state, res): Object => {
							const response = await res.json();

							dispatch(change('add', 'element', response.element));

							return response;
						}
					},
					{
						type: 'ERROR',
						payload: async (action, state, res): Object => {
							const { error } = await res.json();

							return error;
						},
						meta: {
							error: {
								message: 'Failed to pick element'
							}
						}
					}
				]
			}
		});
	};
}
