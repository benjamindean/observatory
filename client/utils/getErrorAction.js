export default function (message = 'Generic Error', meta = {}) {
	return {
		type: 'ERROR',
		payload: async (action, state, res) => {
			const { error } = await res.json();

			return error;
		},
		meta: Object.assign(meta, {
			message
		})
	};
}
