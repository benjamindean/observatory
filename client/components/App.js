import 'babel-polyfill';
import '../assets/css/App.scss';

import * as _ from 'lodash';
import React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import * as WatcherActions from '../actions/watcher';
import * as SettingsActions from '../actions/settings';
import Watcher from './Watcher';
import Form from './Form';

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

		this.observeWatchers();
		this.attachInterval();
	}

	attachInterval () {
		const timeout = localStorage.getItem('interval') || 60;

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
				<div className='control'>
					<div className='select'>
						<select
							onChange={this.handleOnSelectInterval}
							value={localStorage.getItem('interval') || 60}
						>
							<option value='60'>1 Minute</option>
							<option value='300'>5 Minutes</option>
							<option value='3600'>1 Hour</option>
							<option value='10800'>3 Hours</option>
						</select>
					</div>
				</div>
				<hr />
				{watchersList} <Form onSubmit={this.handleAddWatcher} />
			</div>
		);
	}
}

App.defaultProps = {
	watchers: []
};

App.propTypes = {
	watchers: PropTypes.array,
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
