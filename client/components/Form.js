import React from 'react';
import PropTypes from 'prop-types';
import { reduxForm, Field } from 'redux-form';
import FormField from './Form/FormField';
import validation from './Form/validation';

const renderField = ({ input, placeholder, type, meta: { touched, error, warning } }) => (
	<div className="field">
		<div className="control">
			<input
				className={touched && error ? 'input is-danger' : 'input'}
				{...input}
				placeholder={placeholder}
				type={type}
			/>
		</div>
		{touched && error && <p className="help is-danger">{error}</p>}
	</div>
);

class AddForm extends React.PureComponent {
	render() {
		const { pristine, submitting, handleSubmit } = this.props;
		const buttonClass = submitting ? 'button is-success is-loading' : 'button is-success';

		return (
			<div className="box">
				<form onSubmit={handleSubmit}>
					<Field component={renderField} name="title" placeholder="Title" type="text" />
					<Field component={renderField} name="url" placeholder="URL" type="text" />
					<Field
						component={renderField}
						name="element"
						placeholder="Element"
						type="text"
					/>
					<div className="field">
						<p className="control">
							<button className={buttonClass} type="submit" disabled={submitting}>
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
