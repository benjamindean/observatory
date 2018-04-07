import _ from 'lodash';
import { FocusStyleManager, Intent } from '@blueprintjs/core';
import 'babel-polyfill';
import PropTypes from 'prop-types';
import React from 'react';
import Promise from 'bluebird';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import { DONE_OBSERVING, START_OBSERVING, FAILED_OBSERVING } from '../../../server/lib/eventmap';
import '../../assets/css/App.scss';
import Form from '../Form';
import TopBar from '../TopBar';
import Watcher from '../Watcher';
import AppToaster from '../Toaster';
import * as WatcherActions from '../Watcher/actions';
import * as ToasterActions from '../Toaster/actions';

const { ipcRenderer } = window.require('electron');

class App extends React.Component {
	constructor (props) {
		super(props);

		FocusStyleManager.onlyShowFocusOnTabs();
		this.attachEvents = this.attachEvents.bind(this);
		this.observeAllWatchers = this.observeAllWatchers.bind(this);
	}

	async componentWillMount () {
		this.attachEvents();
		await this.props.actions.watcher.list();
		await this.observeAllWatchers();
	}

	observeAllWatchers () {
		return new Promise((resolve) => {
			if (!this.props.watchers) {
				resolve();
			}

			_.forEach(this.props.watchers, async (watcher) => {
				await this.props.actions.watcher.observe(watcher._id);
			});

			resolve();
		});
	}

	attachEvents () {
		ipcRenderer.on(START_OBSERVING, (event, watcherId) => {
			this.props.actions.watcher.toggleLoadingState(watcherId);
		});

		ipcRenderer.on(DONE_OBSERVING, (event, watcherId) => {
			this.props.actions.watcher.toggleLoadingState(watcherId);
		});

		ipcRenderer.on(FAILED_OBSERVING, (event, message) => {
			this.props.actions.toaster.add({
				message,
				intent: Intent.DANGER
			});
		});
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
				<AppToaster />
				<Form />
				<TopBar />
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
	theme: PropTypes.string.isRequired
};

function mapStateToProps (state) {
	return {
		watchers: state.watchers,
		theme: state.theme
	};
}

function mapDispatchToProps (dispatch) {
	return {
		actions: {
			watcher: bindActionCreators(WatcherActions, dispatch),
			toaster: bindActionCreators(ToasterActions, dispatch)
		}
	};
}

export default connect(mapStateToProps, mapDispatchToProps)(App);
