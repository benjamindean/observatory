const Form = require('../../../client/components/Form');

describe('Form', () => {
	test('Snapshot', () => {
		expect(Form).toMatchSnapshot();
	});
});