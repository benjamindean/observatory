import { ADD_WATCHER, REMOVE_WATCHER, LIST_WATCHERS, CHECK_WATCHER } from '../actions/watcher';

export default function watcher (state = [], action) {
	switch (action.type) {
	case LIST_WATCHERS:
		return action.watchers;
	case ADD_WATCHER:
		return [...state, action.watcher];
	case REMOVE_WATCHER:
		return [...state, action.watcher];
	case CHECK_WATCHER:
		return state;
	default:
		return state;
	}
}
