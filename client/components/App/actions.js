export const SET_INTERVAL_ID = 'SET_INTERVAL_ID';

export function setRefreshIntervalId (intervalId: number): Object {
	return {
		type: SET_INTERVAL_ID,
		intervalId
	};
}
