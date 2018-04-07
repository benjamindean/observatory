import React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import { Position, Toast, Toaster } from '@blueprintjs/core';
import * as ToasterActions from './actions';

class AppToaster extends React.PureComponent {
	constructor (props) {
		super(props);

		this.handleDismiss = this.handleDismiss.bind(this);
	}

	handleDismiss (toast) {
		this.props.actions.toaster.remove(toast);
	}

	render () {
		return (
			<div>
				<Toaster position={Position.TOP}>
					{this.props.toasts.map((toast) => {
						return (
							<Toast
								{...toast}
								key={toast.key}
								onDismiss={() => {
									return this.handleDismiss(toast);
								}}
							/>
						);
					})}
				</Toaster>
			</div>
		);
	}
}

AppToaster.propTypes = {
	toasts: PropTypes.array.isRequired,
	actions: PropTypes.object.isRequired
};

function mapStateToProps (state) {
	return {
		toasts: state.toaster
	};
}

function mapDispatchToProps (dispatch) {
	return {
		actions: {
			toaster: bindActionCreators(ToasterActions, dispatch)
		}
	};
}

export default connect(mapStateToProps, mapDispatchToProps)(AppToaster);
