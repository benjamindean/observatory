import React from 'react';
import { Dialog, Button } from '@blueprintjs/core';
import { reduxForm, Field } from 'redux-form';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import * as WatcherActions from '../Watcher/actions';
import * as FormActions from './actions';
import RenderField from './RenderField';
import validation from './validation';

type AddFormProps = {
	submitting: boolean,
	actions: Object,
	handleSubmit: Function,
	isOpened: boolean
};

class AddForm extends React.Component<AddFormProps> {
	constructor (props) {
		super(props);

		this.handleAddWatcher = this.handleAddWatcher.bind(this);
	}

	async handleAddWatcher (values) {
		await this.props.actions.watcher.add(values);
		this.props.actions.addForm.handleToggleAddForm(false);
	}

	render () {
		const { handleSubmit, submitting } = this.props;
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
						label='URL *'
						name='url'
						placeholder='http://example.com'
						type='text'
					/>
					<Field
						component={RenderField}
						label='CSS Path *'
						name='element'
						placeholder='#id > .class'
						type='text'
					/>
					<Button className={buttonClass} loading={submitting} text='Add' type='submit' />
				</form>
			</Dialog>
		);
	}
}

function mapStateToProps (state) {
	return {
		isOpened: state.addForm.isOpened
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
