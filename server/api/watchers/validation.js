exports.add = async (ctx, next) => {
	ctx.checkBody('url').isUrl('Wrong URL');
	ctx.checkBody('element').notEmpty('Element can\'t be empty');

	return await next();
};
