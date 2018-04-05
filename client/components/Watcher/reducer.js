import {
	ADD_WATCHER,
	REMOVE_WATCHER,
	LIST_WATCHERS,
	UPDATE_WATCHER,
	TOGGLE_LOADING_STATE
} from './actions';

export default function reducer (state = [], action) {
	switch (action.type) {
	case LIST_WATCHERS:
		return action.watchers;
	case ADD_WATCHER:
		return [...state, action.watcher];
	case REMOVE_WATCHER:
		return state.filter((watcherItem) => {
			return watcherItem._id !== action.watcherId;
		});
	case UPDATE_WATCHER:
		return state.map((watcherItem) => {
			if (watcherItem._id === action.watcher._id) {
				return Object.assign({}, watcherItem, action.watcher);
			}

			return watcherItem;
		});
	case TOGGLE_LOADING_STATE:
		return state.map((watcherItem) => {
			if (watcherItem._id === action.watcherId) {
				return Object.assign({}, watcherItem, {
					isLoading: !watcherItem.isLoading
				});
			}

			return watcherItem;
		});
	default:
		return state;
	}
}
