export const FILTER_WATCHERS = 'FILTER_WATCHERS';

export function filterWatchers (watchers: Array, term: string): Object {
	return {
		type: FILTER_WATCHERS,
		watchers,
		term
	};
}
