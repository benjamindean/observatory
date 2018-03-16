const Koa = require('koa');
const cors = require('@koa/cors');
const logger = require('winston');
const bodyParser = require('koa-bodyparser');
const app = new Koa();
const validate = require('koa-validate');
const watchersRoutes = require('./api/watchers/routes');
const { check } = require('./lib/checker');

validate(app);
app.use(cors());
app.use(bodyParser());
app.use(watchersRoutes.routes());
app.use(watchersRoutes.allowedMethods());

const server = app.listen(3000, async () => {
	logger.info(`Started app on port ${server.address().port}`);

	// Start initial check
	// await check();

	setInterval(async () => {
		await check();
	}, 5 * 1000);
});

module.exports = server;
