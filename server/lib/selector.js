const { BrowserWindow } = require('electron');

const insertJs = `
	const { ipcRenderer } = window.require('electron');
	let observatoryCssPath = function (el) {
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
		e.preventDefault();
		ipcRenderer.send('element-selected', observatoryCssPath(e.target));
		ipcRenderer.on('element-selected', (event, agrs) => {
			console.log(args);
		});
		console.log(observatoryCssPath(e.target));
	});
`;

class Selector {
	async getTitle(webContents) {
		return await webContents.executeJavaScript('document.title');
	}

	async getElement(webContents, element) {
		return await webContents.executeJavaScript(
			`
			const observatoryElement = document.querySelector(\'${element}\');

			if (observatoryElement) {
				observatoryElement.innerHTML;
			} else {
				'No such element';
			}`
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

					accept(watcher);
				} catch (error) {
					reject(error);
				}
			});
		});
	}

	async pickElement(url) {
		const window = new BrowserWindow({
			show: true
		});

		window.loadURL(url);

		window.webContents.on('did-finish-load', async () => {
			window.webContents.executeJavaScript(insertJs);
		});
	}
}

module.exports = new Selector();
