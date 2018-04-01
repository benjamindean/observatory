import 'babel-polyfill';
import '../assets/css/App.scss';

import * as _ from 'lodash';
import React from 'react';
import PropTypes from 'prop-types';
import {
	Navbar,
	Alignment,
	NavbarHeading,
	NavbarGroup,
	NavbarDivider,
	Button,
	Menu,
	MenuItem,
	Position,
	Popover,
	FocusStyleManager
} from '@blueprintjs/core';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import * as WatcherActions from '../actions/watcher';
import * as SettingsActions from '../actions/settings';
import Watcher from './Watcher';
import Form from './Form/Form';

FocusStyleManager.onlyShowFocusOnTabs();

const { ipcRenderer } = window.require('electron');

ipcRenderer.send('started', 1);

class App extends React.Component {
	constructor (props) {
		super(props);
		this.handleAddWatcher = this.handleAddWatcher.bind(this);
		this.observeWatchers = this.observeWatchers.bind(this);
		this.handleOnSelectInterval = this.handleOnSelectInterval.bind(this);
		this.interval = null;
	}

	async componentWillMount () {
		await this.props.actions.watcher.list();
		await this.props.actions.settings.list();

		this.observeWatchers();
		this.attachInterval();
	}

	attachInterval () {
		const timeout = 60;

		this.interval = setInterval(() => {
			this.observeWatchers();
		}, timeout * 1000);
	}

	handleOnSelectInterval (event) {
		clearInterval(this.interval);
		localStorage.setItem('interval', event.target.value);
		this.attachInterval();
	}

	async handleAddWatcher (values) {
		await this.props.actions.watcher.add(values);
	}

	observeWatchers () {
		if (_.isEmpty(this.props.watchers)) {
			return;
		}

		_.forEach(this.props.watchers, async (watcher) => {
			await this.props.actions.watcher.observe(watcher._id);
		});
	}

	render () {
		const watchersList = this.props.watchers.map((watcher) => {
			return (
				<Watcher
					checkTime={watcher.checkTime}
					element={watcher.element}
					id={watcher._id}
					key={watcher._id}
					newValue={watcher.newValue}
					oldValue={watcher.oldValue}
					rev={watcher._rev}
					title={watcher.title}
					url={watcher.url}
				/>
			);
		});

		return (
			<div>
				<Navbar className='row'>
					<NavbarGroup align={Alignment.LEFT}>
						<NavbarHeading>Observatory</NavbarHeading>
						<NavbarDivider />
						<Popover
							content={
								<Menu>
									<MenuItem
										onClick={this.handleOnSelectInterval}
										text='1 minute'
									/>
									<MenuItem
										onClick={this.handleOnSelectInterval}
										text='5 minutes'
									/>
								</Menu>
							}
							position={Position.BOTTOM}
						>
							<Button icon='time' text='Interval' />
						</Popover>
					</NavbarGroup>
				</Navbar>
				<hr />
				{watchersList}
				<div className='row'>
					<Form onSubmit={this.handleAddWatcher} />
				</div>
			</div>
		);
	}
}

App.defaultProps = {
	watchers: [],
	settings: []
};

App.propTypes = {
	watchers: PropTypes.array,
	settings: PropTypes.array,
	actions: PropTypes.object.isRequired
};

function mapStateToProps (state) {
	return {
		watchers: state.watchers,
		settings: state.settings
	};
}

function mapDispatchToProps (dispatch) {
	return {
		actions: {
			watcher: bindActionCreators(WatcherActions, dispatch),
			settings: bindActionCreators(SettingsActions, dispatch)
		}
	};
}

export default connect(mapStateToProps, mapDispatchToProps)(App);
