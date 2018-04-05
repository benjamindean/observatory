const Router = require('koa-router');
const controller = require('./controller');

const routes = new Router({
	prefix: '/settings'
});

routes.get('/', controller.list);

routes.get('/:key', controller.get);

routes.post('/', controller.set);

module.exports = routes;
