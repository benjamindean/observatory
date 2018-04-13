const _ = require('lodash');
const fetch = require('node-fetch');
const { app, Menu, Tray, shell, nativeImage } = require('electron');
const notifyRenderer = require('./utils/notifyRenderer');
const path = require('path');
const { OBSERVE_WATCHER, REMOVE_WATCHER, OPEN_ADD_FORM } = require('../server/lib/eventmap');

class ObservatoryTray {
	constructor() {
		this.tray = null;
		this.menuItems = [];
		this.defaultMenuItems = [
			{
				label: 'Add Watcher',
				click: () => {
					notifyRenderer(OPEN_ADD_FORM, true, true);
				}
			},
			{
				type: 'separator'
			}
		];
	}

	async initContextMenu() {
		const response = await fetch('http://localhost:3000/watchers');
		const watchers = await response.json();

		this.setMenuItems(watchers);
		this.attachItems();
	}

	getMenuItems() {
		return this.menuItems;
	}

	setMenuItems(watchers) {
		if (!watchers) {
			return this.attachItems();
		}

		_.forEach(watchers, watcher => {
			this.menuItems.push({
				id: watcher._id,
				label: _.truncate(watcher.title),
				submenu: [
					{
						label: 'Refresh',
						click: () => {
							notifyRenderer(OBSERVE_WATCHER, watcher);
						}
					},
					{
						label: 'Open',
						click: () => {
							shell.openExternal(watcher.url);
						}
					},
					{
						type: 'separator'
					},
					{
						label: 'Delete',
						click: () => {
							notifyRenderer(REMOVE_WATCHER, watcher);
						}
					}
				]
			});
		});
	}

	async create() {
		const image = nativeImage.createFromPath(
			path.join(__dirname, '../client/assets/icons/main.icns')
		);

		this.tray = new Tray(image);
		this.tray.setToolTip(app.getName());
		await this.initContextMenu();
	}

	attachItems() {
		this.tray.setContextMenu(
			Menu.buildFromTemplate([...this.defaultMenuItems, ...this.getMenuItems()])
		);
	}
}

module.exports = new ObservatoryTray();
