const { app } = require('electron');
const PouchDb = require('pouchdb');

const Store = PouchDb.defaults({
	prefix: `${app.getPath('userData')}/`
});

module.exports = new Store('watchers');
