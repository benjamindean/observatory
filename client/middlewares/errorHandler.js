import { Intent } from '@blueprintjs/core';
import { ADD_TOAST } from '../components/Toaster/actions';
import { TOGGLE_LOADING_STATE } from '../components/Watcher/actions';

export default function errorHandler () {
	return (next) => {
		return (action) => {
			if (action.type === 'ERROR') {
				if (action.meta.watcherId) {
					next({
						type: TOGGLE_LOADING_STATE,
						payload: {
							id: action.meta.watcherId,
							isLoading: false
						}
					});
				}

				return next({
					type: ADD_TOAST,
					toast: {
						key: new Date().toLocaleString(),
						message: action.meta.message,
						intent: Intent.DANGER
					}
				});
			}

			return next(action);
		};
	};
}
