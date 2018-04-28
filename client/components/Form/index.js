import './style.scss';

import { Button, Dialog, Checkbox } from '@blueprintjs/core';
import React from 'react';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import { Field, reduxForm, getFormValues } from 'redux-form';
import * as WatcherActions from '../Watcher/actions';
import ElementPicker from '../ElementPicker';
import RenderField from './RenderField';
import * as FormActions from './actions';
import validation from './validation';

type AddFormProps = {
	submitting: boolean,
	actions: Object,
	handleSubmit: Function,
	isOpened: boolean,
	isManual: boolean,
	formValues?: Object,
	reset: Function,
	valid: boolean,
	pristine: boolean
};

class AddForm extends React.Component<AddFormProps> {
	constructor (props) {
		super(props);

		this.handleAddWatcher = this.handleAddWatcher.bind(this);
		this.handleManualInput = this.handleManualInput.bind(this);
	}

	async handleAddWatcher (values) {
		await this.props.actions.watcher.add(values);
		this.props.actions.addForm.handleToggleAddForm(false);
		this.props.reset();
	}

	handleManualInput () {
		this.props.actions.addForm.handleManualInput(!this.props.isManual);
	}

	render () {
		const { handleSubmit, submitting, valid, pristine } = this.props;
		const buttonClass = submitting ? 'pt-intent-success' : 'pt-intent-success';

		return (
			<Dialog
				icon='plus'
				isOpen={this.props.isOpened}
				onClose={() => {
					this.props.actions.addForm.handleToggleAddForm(false);
				}}
				title='Add new watcher'
			>
				<form className='add-form' onSubmit={handleSubmit(this.handleAddWatcher)}>
					<Field
						component={RenderField}
						label='Title'
						name='title'
						placeholder='Title'
						type='text'
					/>
					<Field
						component={RenderField}
						label='URL'
						name='url'
						placeholder='http://example.com'
						type='text'
					/>
					<Field
						component={RenderField}
						hidden={!this.props.isManual}
						label='CSS Path'
						name='element'
						placeholder='http://example.com'
						type='text'
					/>
					<Checkbox
						checked={this.props.isManual}
						label='Manual'
						onChange={this.handleManualInput}
					/>
					<ElementPicker url={this.props.formValues && this.props.formValues.url} />
					{!pristine &&
						valid &&
							<Button
								className={buttonClass}
								icon='plus'
								loading={submitting}
								text='Add'
								type='submit'
							/>
					}
				</form>
			</Dialog>
		);
	}
}

function mapStateToProps (state) {
	return {
		isOpened: state.addForm.isOpened,
		isManual: state.addForm.isManual,
		formValues: getFormValues('add')(state)
	};
}

function mapDispatchToProps (dispatch) {
	return {
		actions: {
			watcher: bindActionCreators(WatcherActions, dispatch),
			addForm: bindActionCreators(FormActions, dispatch)
		}
	};
}

export default connect(mapStateToProps, mapDispatchToProps)(
	reduxForm({
		form: 'add',
		validate: validation
	})(AddForm)
);
