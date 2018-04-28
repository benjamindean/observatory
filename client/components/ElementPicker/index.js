import { Button, Intent } from '@blueprintjs/core';
import React from 'react';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import * as ElementPickerActions from './actions';

type ElementPickerProps = {
	actions: Object,
	url?: string
};

class ElementPicker extends React.PureComponent<ElementPickerProps> {
	constructor (props) {
		super(props);
		this.handleOpenPicker = this.handleOpenPicker.bind(this);
	}

	handleOpenPicker () {
		if (!this.props.url) {
			return;
		}

		this.props.actions.openPicker(this.props.url);
	}

	render () {
		return (
			<Button
				icon='selection'
				intent={Intent.PRIMARY}
				onClick={this.handleOpenPicker}
				text='Pick Element'
			/>
		);
	}
}

function mapDispatchToProps (dispatch) {
	return {
		actions: bindActionCreators(ElementPickerActions, dispatch)
	};
}

export default connect(null, mapDispatchToProps)(ElementPicker);
