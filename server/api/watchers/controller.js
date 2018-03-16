const db = require('../../lib/database');
const selector = require('../../lib/selector');

class WatchersController {
	async list(ctx) {
		const { rows } = await db.allDocs({
			include_docs: true
		});

		ctx.body = rows;
	}

	async get(ctx) {
		ctx.body = await db.get(ctx.params.id);
	}

	async add(ctx) {
		const watcher = await selector.getElements(ctx.request.body);

		ctx.body = await db.post(watcher);
	}

	async delete(ctx) {
		ctx.body = await db.remove({
			_id: ctx.params.id,
			_rev: ctx.params.rev
		});
	}
}

module.exports = new WatchersController();
