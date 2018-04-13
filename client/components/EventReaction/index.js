import React from 'react';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import { OBSERVE_WATCHER, REMOVE_WATCHER, OPEN_ADD_FORM } from '../../../server/lib/eventmap';
import * as WatcherActions from '../Watcher/actions';
import * as AddFormActions from '../Form/actions';

const { ipcRenderer } = window.require('electron');

type EventReactionProps = {
	actions: Object
};

class EventReaction extends React.PureComponent<EventReactionProps> {
	componentWillMount () {
		return this.attachEvents();
	}

	attachEvents () {
		ipcRenderer.on(OBSERVE_WATCHER, (event, watcher) => {
			this.props.actions.watcher.observe(watcher._id);
		});

		ipcRenderer.on(REMOVE_WATCHER, (event, watcher) => {
			this.props.actions.watcher.remove(watcher._id, watcher._rev);
		});

		ipcRenderer.on(OPEN_ADD_FORM, () => {
			this.props.actions.addForm.handleToggleAddForm(true);
		});
	}

	render () {
		return null;
	}
}

function mapDispatchToProps (dispatch) {
	return {
		actions: {
			watcher: bindActionCreators(WatcherActions, dispatch),
			addForm: bindActionCreators(AddFormActions, dispatch)
		}
	};
}

export default connect(null, mapDispatchToProps)(EventReaction);
