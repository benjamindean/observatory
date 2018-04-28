import { Alignment, Button, Navbar, NavbarGroup } from '@blueprintjs/core';
import React from 'react';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import * as FormActions from '../Form/actions';
import IntervalHandler from '../IntervalHandler';
import ThemeHandler from '../ThemeHandler';
import Search from '../Search';

type TopBarProps = {
	actions: Object
};

class TopBar extends React.PureComponent<TopBarProps> {
	render () {
		return (
			<Navbar className='navbar'>
				<NavbarGroup align={Alignment.LEFT}>
					<Button
						icon='plus'
						onClick={() => {
							this.props.actions.form.handleToggleAddForm(true);
						}}
						text='Add'
					/>
					<IntervalHandler />
					<ThemeHandler />
					<Search />
				</NavbarGroup>
			</Navbar>
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

export default connect(null, mapDispatchToProps)(TopBar);
