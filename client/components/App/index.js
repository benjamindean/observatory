import _ from 'lodash';
import { FocusStyleManager } from '@blueprintjs/core';
import 'babel-polyfill';
import React from 'react';
import Promise from 'bluebird';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import '../../assets/css/App.scss';
import Form from '../Form';
import TopBar from '../TopBar';
import Watcher, { WatcherItem } from '../Watcher';
import AppToaster from '../Toaster';
import * as WatcherActions from '../Watcher/actions';
import EventReaction from '../EventReaction';

type AppProps = {
	watchers: Array<WatcherItem>,
	actions: Object,
	theme: string
};

class App extends React.Component<AppProps> {
	static defaultProps = {
		watchers: []
	};

	constructor (props) {
		super(props);

		FocusStyleManager.onlyShowFocusOnTabs();

		this.observeAllWatchers = this.observeAllWatchers.bind(this);
	}

	async componentWillMount () {
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

	render () {
		const watchersList = this.props.watchers.map((watcher) => {
			return (
				<Watcher
					key={watcher._id}
					{...watcher}
				/>
			);
		});

		return (
			<div className={`main ${this.props.theme}`}>
				<EventReaction />
				<AppToaster />
				<Form />
				<TopBar />
				<div className='watchers-list'>{watchersList}</div>
			</div>
		);
	}
}

function mapStateToProps (state) {
	return {
		watchers: state.watchers,
		theme: state.theme
	};
}

function mapDispatchToProps (dispatch) {
	return {
		actions: {
			watcher: bindActionCreators(WatcherActions, dispatch)
		}
	};
}

export default connect(mapStateToProps, mapDispatchToProps)(App);
