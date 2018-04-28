const _ = require('lodash');
const { dbWatchers } = require('../../lib/database');
const selector = require('../../lib/selector');
const observe = require('../../lib/observe');

class WatchersController {
	async list(ctx) {
		const { rows } = await dbWatchers.allDocs({
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
		ctx.body = await dbWatchers.get(ctx.params.id);
	}

	async add(ctx) {
		const watcher = await selector.getElements(ctx.request.body);
		const addedWatcher = await dbWatchers.post(watcher);

		ctx.body = await dbWatchers.get(addedWatcher.id);
	}

	async update(ctx) {
		const watcher = await dbWatchers.get(ctx.params.id);
		const updatedWatcher = ctx.request.body;

		await dbWatchers.put(Object.assign({}, { _id: watcher._id }, updatedWatcher));

		ctx.body = await dbWatchers.get(ctx.params.id);
	}

	async delete(ctx) {
		ctx.body = await dbWatchers.remove({
			_id: ctx.params.id,
			_rev: ctx.params.rev
		});
	}

	async acknowledge(ctx) {
		const watcher = await dbWatchers.get(ctx.params.id);
		const updatedWatcher = _.cloneDeep(watcher);

		updatedWatcher.oldValue = updatedWatcher.newValue;
		updatedWatcher.newValue = null;

		await dbWatchers.put(Object.assign({}, { _id: watcher._id }, updatedWatcher));

		ctx.body = await dbWatchers.get(ctx.params.id);
	}

	async observe(ctx) {
		const watcher = await dbWatchers.get(ctx.params.id);

		await observe(watcher);

		ctx.body = await dbWatchers.get(ctx.params.id);
	}

	async pickElement(ctx) {
		ctx.body = await selector.pickElement(ctx.request.body.url);
	}
}

module.exports = new WatchersController();
