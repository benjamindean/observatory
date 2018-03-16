const selector = require('../../lib/selector');

exports.add = async (ctx, next) => {
	ctx.watcher = await selector.getElements(ctx.request.body);

	await next();
};
