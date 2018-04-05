import 'babel-polyfill';
import '../../assets/css/App.scss';

import React from 'react';
import PropTypes from 'prop-types';
import {
	Navbar,
	Alignment,
	NavbarGroup,
	Button,
	FocusStyleManager,
	Dialog
} from '@blueprintjs/core';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import { START_OBSERVING, DONE_OBSERVING } from '../../../server/lib/eventmap';
import * as WatcherActions from '../Watcher/actions';
import ThemeHandler from '../ThemeHandler';
import IntervalHandler from '../IntervalHandler';
import Watcher from '../Watcher';
import Form from '../Form';
import * as AppActions from './actions';

const { ipcRenderer } = window.require('electron');

class App extends React.Component {
	constructor (props) {
		super(props);

		FocusStyleManager.onlyShowFocusOnTabs();

		this.handleAddWatcher = this.handleAddWatcher.bind(this);
		this.handleToggleAddForm = this.handleToggleAddForm.bind(this);
	}

	async componentWillMount () {
		this.attachEvents();
		await this.props.actions.watcher.list();
	}

	attachEvents () {
		ipcRenderer.on(START_OBSERVING, (event, watcherId) => {
			this.props.actions.watcher.toggleLoadingState(watcherId);
		});

		ipcRenderer.on(DONE_OBSERVING, (event, watcherId) => {
			this.props.actions.watcher.toggleLoadingState(watcherId);
		});
	}

	async handleAddWatcher (values) {
		await this.props.actions.watcher.add(values);
		this.props.actions.app.toggleAddForm();
	}

	handleToggleAddForm () {
		return this.props.actions.app.toggleAddForm();
	}

	render () {
		const watchersList = this.props.watchers.map((watcher) => {
			return (
				<Watcher
					checkTime={watcher.checkTime}
					element={watcher.element}
					id={watcher._id}
					isLoading={watcher.isLoading}
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
			<div className={`main ${this.props.theme}`}>
				<Dialog
					icon='plus'
					isOpen={this.props.app.isAddFormOpened}
					onClose={this.handleToggleAddForm}
					title='Add new watcher'
				>
					<Form onSubmit={this.handleAddWatcher} />
				</Dialog>
				<Navbar className='navbar'>
					<NavbarGroup align={Alignment.LEFT}>
						<Button icon='plus' onClick={this.handleToggleAddForm} text='Add' />
						<IntervalHandler />
						<ThemeHandler />
					</NavbarGroup>
				</Navbar>
				<div className='watchers-list'>{watchersList}</div>
			</div>
		);
	}
}

App.defaultProps = {
	watchers: []
};

App.propTypes = {
	watchers: PropTypes.array,
	actions: PropTypes.object.isRequired,
	app: PropTypes.object.isRequired,
	theme: PropTypes.string.isRequired
};

function mapStateToProps (state) {
	return {
		watchers: state.watchers,
		settings: state.settings,
		theme: state.theme,
		app: state.app
	};
}

function mapDispatchToProps (dispatch) {
	return {
		actions: {
			watcher: bindActionCreators(WatcherActions, dispatch),
			app: bindActionCreators(AppActions, dispatch)
		}
	};
}

export default connect(mapStateToProps, mapDispatchToProps)(App);
