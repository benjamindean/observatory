import 'babel-polyfill';
import '../assets/css/App.scss';

import React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import * as WatcherActions from '../actions/watcher';
import Watcher from './Watcher';
import Form from './Form';

class App extends React.Component {
	constructor (props) {
		super(props);
		this.handleAddWatcher = this.handleAddWatcher.bind(this);
	}

	async componentWillMount () {
		await this.props.actions.watcher.list();

		setInterval(async () => {
			await this.props.actions.watcher.list();
		}, 5 * 1000);
	}

	async handleAddWatcher (values) {
		await this.props.actions.watcher.add(values);
	}

	render () {
		const watchersList = this.props.watchers.map((watcher) => {
			const doc = watcher.doc;

			return (
				<Watcher
					element={doc.element}
					id={doc._id}
					key={doc._id}
					newValue={doc.newValue}
					oldValue={doc.oldValue}
					rev={doc._rev}
					title={doc.title}
					url={doc.url}
				/>
			);
		});

		return (
			<div>
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
		watchers: state.watchers
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
