import { createStore, applyMiddleware } from 'redux';
import thunk from 'redux-thunk';
import { apiMiddleware } from 'redux-api-middleware';
import rootReducer from './reducer';
import errorHandler from './middlewares/errorHandler';

export default function configureStore () {
	return createStore(rootReducer, applyMiddleware(thunk, apiMiddleware, errorHandler));
}
