import validate from 'validate.js';

const constraints = {
	title: {
		presence: false
	},
	url: {
		url: {
			message: 'must be a valid URL'
		},
		presence: {
			message: 'is required'
		},
		length: {
			minimum: 6,
			message: 'must be at least 6 characters'
		}
	},
	element: {
		presence: {
			message: 'is required'
		}
	}
};

const validation = (values) => {
	return validate(values, constraints);
};

export default validation;
