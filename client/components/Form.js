import React from 'react';
import PropTypes from 'prop-types';
import { reduxForm, Field } from 'redux-form';
import RenderField from './Form/RenderField';
import validation from './Form/validation';

class AddForm extends React.PureComponent {
	render () {
		const { submitting, handleSubmit } = this.props;
		const buttonClass = submitting ? 'button is-success is-loading' : 'button is-success';

		return (
			<div className='box'>
				<form onSubmit={handleSubmit}>
					<Field component={RenderField} name='title' placeholder='Title' type='text' />
					<Field component={RenderField} name='url' placeholder='URL' type='text' />
					<Field
						component={RenderField}
						name='element'
						placeholder='Element'
						type='text'
					/>
					<div className='field'>
						<p className='control'>
							<button className={buttonClass} disabled={submitting} type='submit'>
								Save
							</button>
						</p>
					</div>
				</form>
			</div>
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
