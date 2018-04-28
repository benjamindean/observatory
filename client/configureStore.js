import { applyMiddleware, createStore } from 'redux';
import { apiMiddleware } from 'redux-api-middleware';
import thunk from 'redux-thunk';
import errorHandler from './middlewares/errorHandler';
import rootReducer from './reducer';

export default function configureStore () {
	return createStore(rootReducer, applyMiddleware(thunk, apiMiddleware, errorHandler));
}
