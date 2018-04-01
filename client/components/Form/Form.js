import React from 'react';
import PropTypes from 'prop-types';
import { Button, Card, Elevation } from '@blueprintjs/core';
import { reduxForm, Field } from 'redux-form';
import RenderField from './RenderField';
import validation from './validation';

class AddForm extends React.PureComponent {
	render () {
		const { submitting, handleSubmit } = this.props;
		const buttonClass = submitting ? 'pt-intent-success' : 'pt-intent-success';

		return (
			<Card elevation={Elevation.TWO} interactive={true}>
				<form onSubmit={handleSubmit}>
					<Field component={RenderField} name='title' placeholder='Title' type='text' />
					<Field component={RenderField} name='url' placeholder='URL' type='text' />
					<Field
						component={RenderField}
						name='element'
						placeholder='Element'
						type='text'
					/>
					<Button className={buttonClass} text='Add' type='submit' />
				</form>
			</Card>
		);
	}
}

AddForm.propTypes = {
	handleSubmit: PropTypes.func.isRequired,
	submitting: PropTypes.bool.isRequired
};

const Form = reduxForm({
	form: 'add',
	validate: validation
})(AddForm);

export default Form;
