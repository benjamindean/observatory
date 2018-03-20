const Router = require('koa-router');
const controller = require('./controller');

const routes = new Router({
	prefix: '/settings'
});

routes.get('/', controller.list);

routes.get('/:id', controller.get);

routes.post('/', controller.add);

routes.post('/:id', controller.update);

routes.delete('/:id/:rev', controller.delete);

module.exports = routes;
