const Koa = require('koa');
const cors = require('@koa/cors');
const logger = require('winston');
const bodyParser = require('koa-bodyparser');
const app = new Koa();
const validate = require('koa-validate');
const watchersRoutes = require('./api/watchers/routes');
const settingsRoutes = require('./api/settings/routes');
const requestMiddleware = require('./middlewares/request');

validate(app);
app.use(cors());
app.use(bodyParser());
app.use(watchersRoutes.routes());
app.use(watchersRoutes.allowedMethods());
app.use(settingsRoutes.routes());
app.use(settingsRoutes.allowedMethods());
app.use(requestMiddleware);

const server = app.listen(3000, async () => {
	logger.info(`Started app on port ${server.address().port}`);
});

module.exports = server;
