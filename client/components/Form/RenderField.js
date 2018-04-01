import React from 'react';
import PropTypes from 'prop-types';

const RenderField = ({ input, placeholder, type, meta: { touched, error } }) => {
	return <div>
		<input
			className={touched && error ? 'pt-input pt-intent-danger' : 'pt-input'}
			{...input}
			placeholder={placeholder}
			type={type}
		/>
		{touched && error && <p className='help is-danger'>{error}</p>}
	</div>;
};

RenderField.propTypes = {
	input: PropTypes.object.isRequired,
	placeholder: PropTypes.string.isRequired,
	type: PropTypes.string.isRequired,
	meta: PropTypes.object.isRequired
};

export default RenderField;
