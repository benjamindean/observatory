import React from 'react';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import { OBSERVE_WATCHER, OPEN_ADD_FORM, REMOVE_WATCHER } from '../../../server/lib/eventmap';
import * as AddFormActions from '../Form/actions';
import * as WatcherActions from '../Watcher/actions';

const { ipcRenderer } = window.require('electron');

type EventReactionProps = {
	actions: Object
};

class EventReaction extends React.PureComponent<EventReactionProps> {
	componentDidMount () {
		return this.attachEvents();
	}

	attachEvents () {
		ipcRenderer.removeAllListeners(OBSERVE_WATCHER);
		ipcRenderer.on(OBSERVE_WATCHER, (event, watcher) => {
			this.props.actions.watcher.observe(watcher._id);
		});

		ipcRenderer.removeAllListeners(REMOVE_WATCHER);
		ipcRenderer.on(REMOVE_WATCHER, (event, watcher) => {
			this.props.actions.watcher.remove(watcher._id, watcher._rev);
		});

		ipcRenderer.removeAllListeners(OPEN_ADD_FORM);
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
