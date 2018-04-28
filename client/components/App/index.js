import { FocusStyleManager } from '@blueprintjs/core';
import Promise from 'bluebird';
import _ from 'lodash';
import React from 'react';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import EventReaction from '../EventReaction';
import Form from '../Form';
import AppToaster from '../Toaster';
import TopBar from '../TopBar';
import Watcher from '../Watcher';
import { WatcherItem } from '../../types';
import * as WatcherActions from '../Watcher/actions';
import EmptyList from './EmptyList';

type AppProps = {
	watchers: WatcherItem[],
	filteredWatchers?: WatcherItem[],
	actions: Object,
	theme: string
};

class App extends React.Component<AppProps> {
	static defaultProps = {
		watchers: [],
		filteredWatchers: null
	};

	constructor (props) {
		super(props);

		FocusStyleManager.onlyShowFocusOnTabs();

		this.observeAllWatchers = this.observeAllWatchers.bind(this);
	}

	async componentDidMount () {
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
			return <Watcher key={watcher._id} {...watcher} />;
		});

		const filteredWatchers = this.props.filteredWatchers.map((watcher) => {
			return <Watcher key={watcher._id} {...watcher} />;
		});

		return (
			<div className={`main ${this.props.theme}`}>
				<EventReaction />
				<AppToaster />
				<Form />
				<TopBar />
				{!watchersList.length && <EmptyList />}
				{watchersList.length &&
					!filteredWatchers.length && <div className='watchers-list'>{watchersList}</div>}
				{filteredWatchers.length && <div className='watchers-list'>{filteredWatchers}</div>}
			</div>
		);
	}
}

function mapStateToProps (state) {
	return {
		watchers: state.watchers,
		filteredWatchers: state.search,
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
