const { app } = require('electron');
const PouchDb = require('pouchdb');

const Store = PouchDb.defaults({
	prefix: `${app.getPath('userData')}/`
});

exports.dbWatchers = new Store('watchers');
exports.dbSettings = new Store('settings');
