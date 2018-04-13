export const TOGGLE_ADD_FORM = 'TOGGLE_ADD_FORM';

export function handleToggleAddForm (isOpened: boolean = false): Object {
	return {
		type: TOGGLE_ADD_FORM,
		isOpened
	};
}
