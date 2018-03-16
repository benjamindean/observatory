import React from 'react';
import PropTypes from 'prop-types';
import { reduxForm } from 'redux-form';
import FormField from './Form/FormField';

const AddForm = (props) => {
	const { submitting, handleSubmit } = props;
	const buttonClass = submitting ? 'button is-success is-loading' : 'button is-success';

	return (
		<div className='box'>
			<form onSubmit={handleSubmit}>
				<FormField name='title' placeholder='Title' type='text' />
				<FormField name='url' placeholder='URL' type='text' />
				<FormField name='element' placeholder='Element' type='text' />
				<div className='field'>
					<p className='control'>
						<button className={buttonClass} type='submit'>
							Save
						</button>
					</p>
				</div>
			</form>
		</div>
	);
};

AddForm.propTypes = {
	handleSubmit: PropTypes.func.isRequired,
	submitting: PropTypes.bool.isRequired
};

const Form = reduxForm({
	form: 'add'
})(AddForm);

export default Form;
