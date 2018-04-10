export const TOGGLE_ADD_FORM = 'TOGGLE_ADD_FORM';

export function handleToggleAddForm (isOpened = false) {
	return {
		type: TOGGLE_ADD_FORM,
		isOpened
	};
}
