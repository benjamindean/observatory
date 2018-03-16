const Watcher = require('../../../client/components/Watcher');

describe('Watcher', () => {
	test('Snapshot', () => {
		expect(Watcher).toMatchSnapshot();
	});
});