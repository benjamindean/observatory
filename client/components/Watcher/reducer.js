import {
	ADD_WATCHER,
	REMOVE_WATCHER,
	LIST_WATCHERS,
	UPDATE_WATCHER,
	TOGGLE_LOADING_STATE
} from './actions';

export default function reducer (state: Array = [], action) {
	switch (action.type) {
	case LIST_WATCHERS:
		return action.payload;
	case ADD_WATCHER:
		return [...state, action.payload];
	case REMOVE_WATCHER:
		return state.filter((watcherItem) => {
			return watcherItem._id !== action.payload;
		});
	case UPDATE_WATCHER:
		return state.map((watcherItem) => {
			if (watcherItem._id === action.payload._id) {
				return Object.assign({}, watcherItem, action.payload);
			}

			return watcherItem;
		});
	case TOGGLE_LOADING_STATE:
		return state.map((watcherItem) => {
			if (watcherItem._id === action.payload.id) {
				return Object.assign({}, watcherItem, {
					isLoading: action.payload.isLoading
				});
			}

			return watcherItem;
		});
	default:
		return state;
	}
}
