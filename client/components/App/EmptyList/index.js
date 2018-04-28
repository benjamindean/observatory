import { Button, NonIdealState } from '@blueprintjs/core';
import React from 'react';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import * as FormActions from '../../Form/actions';

type EmptyListProps = {
	actions: Object
};

class EmptyList extends React.PureComponent<EmptyListProps> {
	render () {
		return (
			<NonIdealState
				description={
					<Button
						icon='plus'
						onClick={() => {
							this.props.actions.form.handleToggleAddForm(true);
						}}
						text='Add'
					/>
				}
				title='No watchers'
			/>
		);
	}
}

function mapDispatchToProps (dispatch) {
	return {
		actions: {
			form: bindActionCreators(FormActions, dispatch)
		}
	};
}

export default connect(null, mapDispatchToProps)(EmptyList);
