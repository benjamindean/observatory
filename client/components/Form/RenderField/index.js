import React from 'react';

type RenderFieldProps = {
	input: Object,
	label: string,
	placeholder: string,
	type: string,
	meta: Object,
	hidden?: boolean
};

class RenderField extends React.PureComponent<RenderFieldProps> {
	static defaultProps = {
		hidden: false
	};

	render () {
		const {
			input,
			placeholder,
			label,
			type,
			hidden,
			meta: { touched, error }
		} = this.props;

		return (
			<div className={'add-form-input' + (hidden ? ' hidden' : '')}>
				<label><strong>{label}</strong></label>
				<input
					className={touched && error ? 'pt-input pt-intent-danger' : 'pt-input'}
					{...input}
					placeholder={placeholder}
					type={type}
				/>
				{touched && error && <small>{error}</small>}
			</div>
		);
	}
}

export default RenderField;
