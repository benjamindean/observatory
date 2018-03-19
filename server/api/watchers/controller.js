const _ = require('lodash');
const db = require('../../lib/database');
const selector = require('../../lib/selector');
const observe = require('../../lib/observe');

class WatchersController {
	async list(ctx) {
		const { rows } = await db.allDocs({
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
		ctx.body = await db.get(ctx.params.id);
	}

	async add(ctx) {
		const watcher = await selector.getElements(ctx.request.body);
		const addedWatcher = await db.post(watcher);

		ctx.body = await db.get(addedWatcher.id);
	}

	async delete(ctx) {
		ctx.body = await db.remove({
			_id: ctx.params.id,
			_rev: ctx.params.rev
		});
	}

	async acknowledge(ctx) {
		const watcher = await db.get(ctx.params.id);
		const updatedWatcher = _.cloneDeep(watcher);

		updatedWatcher.oldValue = updatedWatcher.newValue;
		updatedWatcher.newValue = null;

		await db.put(Object.assign({}, { _id: watcher._id }, updatedWatcher));

		ctx.body = await db.get(ctx.params.id);
	}

	async observe(ctx) {
		const watcher = await db.get(ctx.params.id);

		await observe(watcher);

		ctx.body = await db.get(ctx.params.id);
	}
}

module.exports = new WatchersController();
