import React from 'react';
import PropTypes from 'prop-types';
import { Navbar, Alignment, NavbarGroup, Button } from '@blueprintjs/core';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import * as FormActions from '../Form/actions';
import ThemeHandler from '../ThemeHandler';
import IntervalHandler from '../IntervalHandler';

class TopBar extends React.PureComponent {
	render () {
		return (
			<Navbar className='navbar'>
				<NavbarGroup align={Alignment.LEFT}>
					<Button
						icon='plus'
						onClick={this.props.actions.form.handleToggleAddForm}
						text='Add'
					/>
					<IntervalHandler />
					<ThemeHandler />
				</NavbarGroup>
			</Navbar>
		);
	}
}

TopBar.propTypes = {
	actions: PropTypes.object.isRequired
};

function mapDispatchToProps (dispatch) {
	return {
		actions: {
			form: bindActionCreators(FormActions, dispatch)
		}
	};
}

export default connect(null, mapDispatchToProps)(TopBar);
