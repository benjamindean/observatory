const _ = require('lodash');
const logger = require('winston');
const notification = require('./notification');
const { dbWatchers } = require('./database');
const selector = require('./selector');

module.exports = async watcher => {
	logger.info(`Checking: ${watcher._id}`);

	try {
		const currentWatcher = _.cloneDeep(watcher);
		const updatedWatcher = await selector.getElements(watcher);

		updatedWatcher.checkTime = new Date().toLocaleString();

		await dbWatchers.put(Object.assign({}, { _id: currentWatcher._id }, updatedWatcher));

		if (currentWatcher.newValue !== updatedWatcher.newValue) {
			logger.info(`Updated: ${watcher._id}`);

			notification(updatedWatcher);
		}
	} catch (error) {
		throw new Error(`Failed to observe ${watcher.title} with error: ${error.message}`);
	}
};
