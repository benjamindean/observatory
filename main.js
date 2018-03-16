const { app, BrowserWindow, Menu } = require('electron');
const path = require('path');
const url = require('url');
const server = require('./server');
const isDev = process.env.NODE_ENV === 'dev';

let mainWindow;

function createMenu() {
	const template = [
		{
			label: 'Application',
			submenu: [
				{ label: 'About Application', selector: 'orderFrontStandardAboutPanel:' },
				{ type: 'separator' },
				{
					label: 'Quit',
					accelerator: 'Command+Q',
					click: function() {
						app.quit();
					}
				}
			]
		},
		{
			label: 'Edit',
			submenu: [
				{ label: 'Undo', accelerator: 'CmdOrCtrl+Z', selector: 'undo:' },
				{ label: 'Redo', accelerator: 'Shift+CmdOrCtrl+Z', selector: 'redo:' },
				{ type: 'separator' },
				{ label: 'Cut', accelerator: 'CmdOrCtrl+X', selector: 'cut:' },
				{ label: 'Copy', accelerator: 'CmdOrCtrl+C', selector: 'copy:' },
				{ label: 'Paste', accelerator: 'CmdOrCtrl+V', selector: 'paste:' },
				{ label: 'Select All', accelerator: 'CmdOrCtrl+A', selector: 'selectAll:' }
			]
		}
	];

	Menu.setApplicationMenu(Menu.buildFromTemplate(template));
}

function createWindow() {
	mainWindow = new BrowserWindow({
		width: 1024,
		height: 768,
		show: false
	});

	let indexPath = url.format({
		protocol: isDev ? 'http:' : 'file:',
		host: isDev ? 'localhost:1234' : null,
		pathname: isDev ? null : path.join(__dirname, 'dist', 'index.html'),
		slashes: true
	});

	mainWindow.loadURL(indexPath);

	mainWindow.once('ready-to-show', () => {
		mainWindow.show();

		if (isDev) {
			mainWindow.webContents.openDevTools();
		}
	});

	mainWindow.on('closed', function() {
		mainWindow = null;
	});
}

app.on('ready', async () => {
	createWindow();
	createMenu();
});

app.on('window-all-closed', () => {
	if (process.platform !== 'darwin') {
		app.quit();
	}
});

app.on('activate', () => {
	if (mainWindow === null) {
		createWindow();
	}
});
