const Router = require('koa-router');
const controller = require('./controller');

const routes = new Router({
	prefix: '/watchers'
});

routes.get('/', controller.list);

routes.get('/:id', controller.get);

routes.get('/observe/:id', controller.observe);

routes.post('/update/:id', controller.update);

routes.get('/acknowledge/:id', controller.acknowledge);

routes.post('/', controller.add);

routes.post('/pick', controller.pickElement);

routes.delete('/:id/:rev', controller.delete);

module.exports = routes;
