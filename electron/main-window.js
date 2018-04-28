const { BrowserWindow } = require('electron');
const path = require('path');
const url = require('url');

class MainWindow {
	constructor() {
		this.window = null;
		this.isDev = process.env.NODE_ENV === 'dev';
		this.config = {
			width: 1024,
			height: 768,
			show: false,
			icon: path.join(__dirname, '../client/assets/icons/main.png')
		};
		this.indexPath = url.format({
			protocol: this.isDev ? 'http:' : 'file:',
			host: this.isDev ? 'localhost:1234' : null,
			pathname: this.isDev ? null : path.join(__dirname, '../dist/index.html'),
			slashes: true
		});
	}

	get() {
		return this.window;
	}

	create() {
		this.window = new BrowserWindow(this.config);
		this.window.loadURL(this.indexPath);
		this.attachEvents();
	}

	attachEvents() {
		this.window.once('ready-to-show', async () => {
			this.window.show();

			if (this.isDev) {
				this.window.webContents.openDevTools();
			}
		});

		this.window.on('closed', () => {
			this.window = null;
		});
	}
}

module.exports = new MainWindow();
