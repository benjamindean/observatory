import { combineReducers } from 'redux';
import { reducer as form } from 'redux-form';
import watchers from './reducers/watcher';

const reducers = combineReducers({
	watchers,
	form
});

export default reducers;
