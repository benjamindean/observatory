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
		ctx.body = await dbSettings.get(ctx.params.id);
	}

	async add(ctx) {
		const { key, val } = ctx.request.body;
		const addedWatcher = await dbSettings.post({
			key,
			val
		});

		ctx.body = await dbSettings.get(addedWatcher.id);
	}

	async update(ctx) {
		const setting = await dbSettings.get(ctx.params.id);
		const updatedSetting = _.cloneDeep(setting);

		updatedSetting.val = ctx.body.val;

		await dbSettings.put(Object.assign({}, { _id: setting._id }, updatedSetting));

		ctx.body = await dbSettings.get(ctx.params.id);
	}

	async delete(ctx) {
		ctx.body = await dbSettings.remove({
			_id: ctx.params.id,
			_rev: ctx.params.rev
		});
	}
}

module.exports = new SettingsController();
