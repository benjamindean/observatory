const { app } = require('electron');
const server = require('./server');
const window = require('./electron/main-window');
const tray = require('./electron/tray');
const menu = require('./electron/menu');

app.on('ready', async () => {
	window.create();
	await tray.create();
	menu.create();
});

app.on('window-all-closed', () => {
	if (process.platform !== 'darwin') {
		app.quit();
	}
});

app.on('activate', () => {
	if (window.get() === null) {
		window.create();
	}
});
