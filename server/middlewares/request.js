/**
 * The main request handler.
 * Catch all the errors that might happen up the middleware chain.
 *
 * @param {Object} ctx
 * @param {Function} next
 * @returns {Promise.<*>}
 */
module.exports = async (ctx, next) => {
	try {
		await next();
	} catch (error) {
		ctx.status = 500;
		ctx.body = {
			error: {
				message: error.message
			}
		};
	}
};
