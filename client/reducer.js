import { combineReducers } from 'redux';
import { reducer as form } from 'redux-form';
import watchers from './components/Watcher/reducer';
import theme from './components/ThemeHandler/reducer';
import interval from './components/IntervalHandler/reducer';
import addForm from './components/Form/reducer';
import toaster from './components/Toaster/reducer';
import app from './components/App/reducer';
import elementPicker from './components/ElementPicker/reducer';
import search from './components/Search/reducer';

export default combineReducers({
	app,
	theme,
	form,
	addForm,
	watchers,
	interval,
	toaster,
	elementPicker,
	search
});
