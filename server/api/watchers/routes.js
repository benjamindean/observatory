const Router = require('koa-router');
const controller = require('./controller');
const validation = require('./validation');

const routes = new Router({
	prefix: '/watchers'
});

routes.get('/', controller.list);

routes.get('/:id', controller.get);

routes.post('/', validation.add, controller.add);

routes.delete('/:id/:rev', controller.delete);

module.exports = routes;
