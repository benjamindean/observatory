const _ = require('lodash');
const { dbSettings } = require('../../lib/database');

class SettingsController {
	async list(ctx) {
		const { rows } = await dbSettings.allDocs({
			include_docs: true
		});

		ctx.body = _.reduce(
			rows,
			(result, value) => {
				result.push(value.doc);

				return result;
			},
			[]
		);
	}

	async get(ctx) {
		ctx.body = await dbSettings.get(ctx.params.key);
	}

	async set(ctx) {
		const { key, value } = ctx.request.body;

		try {
			const setting = await dbSettings.get(key);

			await dbSettings.put(
				Object.assign({}, setting, {
					_id: key,
					value
				})
			);
		} catch (error) {
			await dbSettings.put({
				_id: key,
				value
			});
		}

		ctx.body = await dbSettings.get(key);
	}
}

module.exports = new SettingsController();
