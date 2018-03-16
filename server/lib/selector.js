const { BrowserWindow } = require('electron');

class Selector {
	async getTitle(webContents) {
		return await webContents.executeJavaScript('document.title');
	}

	async getElement(webContents, element) {
		return await webContents.executeJavaScript(
			`document.querySelector(\'${element}\').innerHTML`
		);
	}

	async getElements(watcher) {
		return new Promise((accept, reject) => {
			const window = new BrowserWindow({
				show: false
			});

			window.loadURL(watcher.url);

			window.webContents.on('did-finish-load', async () => {
				try {
					window.webContents.session.clearCache(() => {});
					const title = await this.getTitle(window.webContents);
					const element = await this.getElement(window.webContents, watcher.element);

					if (watcher.oldValue && watcher.oldValue !== element) {
						watcher.newValue = element;
					} else {
						watcher.oldValue = element;
					}

					if (!watcher.title) {
						watcher.title = title;
					}

					accept(watcher);
				} catch (error) {
					reject(error);
				}
			});
		});
	}
}

module.exports = new Selector();
