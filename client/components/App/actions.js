export const SET_INTERVAL_ID = 'SET_INTERVAL_ID';

export function setRefreshIntervalId (intervalId) {
	return {
		type: SET_INTERVAL_ID,
		intervalId
	};
}
