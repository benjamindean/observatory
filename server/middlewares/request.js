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
		return await next();
	} catch (error) {
		ctx.body = {
			error
		};
	}
};
