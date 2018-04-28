export const TOGGLE_ADD_FORM = 'TOGGLE_ADD_FORM';
export const TOGGLE_MANUAL_INPUT = 'TOGGLE_MANUAL_INPUT';

export function handleToggleAddForm (isOpened: boolean = false): Object {
	return {
		type: TOGGLE_ADD_FORM,
		isOpened
	};
}

export function handleManualInput (isManual: boolean = false): Object {
	return {
		type: TOGGLE_MANUAL_INPUT,
		isManual
	};
}
