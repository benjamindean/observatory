const _ = require('lodash');
const logger = require('winston');
const notification = require('./notification');
const { dbWatchers } = require('./database');
const selector = require('./selector');
const { BrowserWindow } = require('electron');
const { START_OBSERVING, DONE_OBSERVING, FAILED_OBSERVING } = require('./eventmap');

function notifyRenderer(event, args) {
	const window = BrowserWindow.getFocusedWindow();

	if (window) {
		window.webContents.send(event, args);
	}
}

module.exports = async watcher => {
	notifyRenderer(START_OBSERVING, watcher._id);

	logger.info(`Checking: ${watcher._id}`);

	const currentWatcher = _.cloneDeep(watcher);

	try {
		const updatedWatcher = await selector.getElements(watcher);

		updatedWatcher.checkTime = new Date().toLocaleString();

		await dbWatchers.put(Object.assign({}, { _id: currentWatcher._id }, updatedWatcher));

		if (currentWatcher.newValue !== updatedWatcher.newValue) {
			logger.info(`Updated: ${watcher._id}`);

			notification(updatedWatcher);
		}

		notifyRenderer(DONE_OBSERVING, watcher._id);
	} catch (error) {
		notifyRenderer(FAILED_OBSERVING, error);
		notifyRenderer(DONE_OBSERVING, watcher._id);
	}
};
