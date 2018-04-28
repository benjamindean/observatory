import { FILTER_WATCHERS } from './actions';

export default function reducer (state = [], action) {
	switch (action.type) {
	case FILTER_WATCHERS: {
		return action.watchers.filter((watcherItem) => {
			return watcherItem.tags.includes(action.term);
		});
	}
	default:
		return state;
	}
}
