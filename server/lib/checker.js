const _ = require('lodash');
const logger = require('winston');
const { Notification } = require('electron');
const db = require('./database');
const selector = require('./selector');

exports.check = async function () {
	const { rows } = await db.allDocs({
		include_docs: true
	});

	if (!rows.length) {
		return true;
	}

	logger.info('Running background check');

	_.forEach(rows, async watcher => {
		const currentWatcher = _.cloneDeep(watcher.doc);
		const updatedWatcher = await selector.getElements(watcher.doc);

		if (!_.isEqual(currentWatcher, updatedWatcher)) {
			await db.put(Object.assign({}, { _id: currentWatcher._id }, updatedWatcher));

			logger.info(`Watcher ${watcher.id} updated`);

			const notification = new Notification({
				title: `UPDATED: "${updatedWatcher.title}"`,
				subtitle: `From "${updatedWatcher.oldValue}" to "${updatedWatcher.newValue}"`
			});

			notification.show();
		}
	});
};
