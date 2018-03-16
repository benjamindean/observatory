const App = require('../../../client/components/App');

describe('App', () => {
	test('Snapshot', () => {
		expect(App).toMatchSnapshot();
	});
});