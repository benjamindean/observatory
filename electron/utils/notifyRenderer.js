const mainWindow = require('../main-window');

module.exports = (event, args, focus = false) => {
	const window = mainWindow.get();

	if (window) {
		window.webContents.send(event, args);

		if (focus) {
			window.focus();
		}
	}
};
