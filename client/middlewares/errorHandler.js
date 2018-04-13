import { Intent } from '@blueprintjs/core';
import { ADD_TOAST } from '../components/Toaster/actions';

export default function errorHandler () {
	return (next) => {
		return (action) => {
			if (action.meta && action.meta.error) {
				next({
					type: ADD_TOAST,
					toast: {
						key: new Date().toLocaleString(),
						message: action.meta.error.message,
						intent: Intent.DANGER
					}
				});
			}

			return next(action);
		};
	};
}
