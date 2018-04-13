import React from 'react';

type RenderFieldProps = {
	input: Object,
	label: string,
	placeholder: string,
	type: string,
	meta: Object
};

const RenderField = (props: RenderFieldProps) => {
	const { input, placeholder, label, type, meta: { touched, error } } = props;

	return (
		<div className='add-form-input'>
			<label>{label}</label>
			<input
				className={touched && error ? 'pt-input pt-intent-danger' : 'pt-input'}
				{...input}
				placeholder={placeholder}
				type={type}
			/>
			{touched && error && <small>{error}</small>}
		</div>
	);
};

export default RenderField;
