const { app, BrowserWindow, Menu, Tray } = require('electron');
const path = require('path');
const url = require('url');
const server = require('./server');
const isDev = process.env.NODE_ENV === 'dev';

let mainWindow;
let tray;

function createTray() {
	const contextMenu = Menu.buildFromTemplate([
		{ label: 'Item1', type: 'radio' },
		{ label: 'Item2', type: 'radio' },
		{ label: 'Item3', type: 'radio', checked: true },
		{ label: 'Item4', type: 'radio' }
	]);

	tray = new Tray(__dirname + '/client/assets/icons/16x16.png');
	tray.setToolTip(app.getName());
	tray.setContextMenu(contextMenu);
}

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
		show: false,
		icon: __dirname + '/client/assets/icons/256x256.png'
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
	// createTray();
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
