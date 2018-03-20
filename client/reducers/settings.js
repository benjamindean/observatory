import { ADD_SETTING, REMOVE_SETTING, LIST_SETTINGS, UPDATE_SETTING } from '../actions/settings';

export default function setting(state = [], action) {
	switch (action.type) {
		case LIST_SETTINGS:
			return action.settings;
		case ADD_setting:
			return [...state, action.setting];
		case REMOVE_SETTING:
			return state.filter(settingItem => {
				return settingItem._id !== action.settingId;
			});
		case UPDATE_SETTING:
			return state.map(settingItem => {
				if (settingItem._id === action.setting._id) {
					return Object.assign({}, settingItem, action.setting);
				}

				return settingItem;
			});
		default:
			return state;
	}
}
