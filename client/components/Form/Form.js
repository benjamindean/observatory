import React from 'react';
import PropTypes from 'prop-types';
import { reduxForm, Field } from 'redux-form';
import RenderField from './RenderField';
import validation from './validation';

const { ipcRenderer } = window.require('electron');

class AddForm extends React.Component {
	constructor (props) {
		super(props);
		this.handlePickElement = this.handlePickElement.bind(this);

		ipcRenderer.on('element-selected', (event, args) => {
			console.log(args);
		});
	}

	async handlePickElement (params) {
		await fetch('http://localhost:3000/watchers/pick', {
			method: 'POST',
			mode: 'cors',
			body: JSON.stringify({
				url:
					'https://www.reddit.com/r/gatekeeping/comments/868t7d/rob_zombie_shooting_metal_gatekeeping_down/'
			}),
			headers: {
				'content-type': 'application/json'
			}
		});
	}

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
					<div className='field'>
						<p className='control'>
							<button
								className='button is-info'
								disabled={submitting}
								onClick={this.handlePickElement}
								type='button'
							>
								Pick Element
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
