const { BrowserWindow, ipcMain } = require('electron');

const getElemetnText = element => `
	const observatoryElement = document.querySelector(\'${element}\');

	if (observatoryElement) {
		observatoryElement.textContent;
	} else {
		'No such element';
	}
`;

const insertJs = `
	const { ipcRenderer } = window.require('electron');

	const observatoryCssPath = function (el) {
		if (!(el instanceof Element)) {
			return;
		}

		let path = [];

		while (el.nodeType === Node.ELEMENT_NODE) {
			let selector = el.nodeName.toLowerCase();

			if (el.id) {
				selector += '#' + el.id;
				path.unshift(selector);
				break;
			} else {
				let sib = el;
				let nth = 1;

				while ((sib = sib.previousElementSibling)) {
					if (sib.nodeName.toLowerCase() == selector) {
						nth++;
					}
				}
				if (nth != 1) {
					selector += ":nth-of-type("+nth+")";
				}
			}
			path.unshift(selector);
			el = el.parentNode;
		}
		return path.join(' > ');
	};

	document.addEventListener('click', (e) => {
		e.stopPropagation();
		e.preventDefault();
		e.stopImmediatePropagation();

		ipcRenderer.send('element-selected', observatoryCssPath(e.target));

		window.close();
	});
`;

const insertCSS = `
	body :hover :last-child {
		background: #0000000f;
	}
`;

class Selector {
	async getTitle(webContents) {
		return await webContents.executeJavaScript('document.title');
	}

	async getElement(webContents, element) {
		return await webContents.executeJavaScript(getElemetnText(element));
	}

	async getElements(watcher) {
		return new Promise((accept, reject) => {
			let window = new BrowserWindow({
				show: false
			});

			window.loadURL(watcher.url);

			window.webContents.on('did-finish-load', async () => {
				try {
					window.webContents.session.clearCache(() => {});

					const title = await this.getTitle(window.webContents);
					const element = await this.getElement(window.webContents, watcher.element);

					if (element === 'No such element') {
						reject(new Error('No such element'));
					}

					if (watcher.oldValue && watcher.oldValue !== element) {
						watcher.newValue = element;
					} else {
						watcher.oldValue = element;
					}

					if (!watcher.title) {
						watcher.title = title;
					}

					window.close();

					accept(watcher);
				} catch (error) {
					window.close();

					reject(error);
				}
			});

			window.on('closed', () => {
				window = null;
			});
		});
	}

	async pickElement(url) {
		return new Promise(accept => {
			let window = new BrowserWindow({
				show: true,
				width: 1024,
				height: 768
			});

			window.loadURL(url);

			window.webContents.on('dom-ready', () => {
				window.webContents.insertCSS(insertCSS);
			});

			window.webContents.on('did-finish-load', () => {
				window.webContents.executeJavaScript(insertJs);
			});

			window.on('closed', () => {
				window = null;
			});

			ipcMain.on('element-selected', async (event, element) => {
				accept({
					element
				});
			});
		});
	}
}

module.exports = new Selector();
