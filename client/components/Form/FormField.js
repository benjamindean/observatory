import React from 'react';
import PropTypes from 'prop-types';
import { Field } from 'redux-form';

class FormField extends React.PureComponent {
	render () {
		return (
			<div className='field'>
				<div className='control'>
					<Field
						className='input'
						component='input'
						name={this.props.name}
						placeholder={this.props.placeholder}
						type={this.props.type}
					/>
				</div>
			</div>
		);
	}
}

FormField.propTypes = {
	name: PropTypes.string.isRequired,
	placeholder: PropTypes.string.isRequired,
	type: PropTypes.string.isRequired
};

export default FormField;
