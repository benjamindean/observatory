export const TOGGLE_ADD_FORM = 'TOGGLE_ADD_FORM';
export const SET_INTERVAL_ID = 'SET_INTERVAL_ID';

export function toggleAddForm () {
	return {
		type: TOGGLE_ADD_FORM
	};
}

export function setRefreshIntervalId (intervalId) {
	return {
		type: SET_INTERVAL_ID,
		intervalId
	};
}
