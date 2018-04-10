const logger = require('winston');
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
		const setting = await dbSettings.get(key);

		if (setting) {
			await dbSettings.put(
				Object.assign({}, setting, {
					_id: key,
					value
				})
			);
		} else {
			logger.info(`Setting ${key} doesn't exist. Creating...`);

			await dbSettings.put({
				_id: key,
				value
			});
		}

		ctx.body = await dbSettings.get(key);
	}
}

module.exports = new SettingsController();
