import _ from 'lodash';
import { TagInput } from '@blueprintjs/core';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import React from 'react';
import * as WatcherActions from '../actions';
import { WatcherItem } from '../../../types';

type TagsProps = {
	tags?: string[],
	actions: Object,
	watcher: WatcherItem
};

class Tags extends React.PureComponent<TagsProps> {
	static defaultProps = {
		tags: []
	};

	constructor (props) {
		super(props);

		this.handleChangeTags = this.handleChangeTags.bind(this);
	}

	async handleChangeTags (tags: string[]) {
		const watcher = _.omit(this.props.watcher, ['actions', 'isLoading']);
		const updatedWatcher = Object.assign({}, watcher, {
			tags
		});

		await this.props.actions.watcher.update(updatedWatcher);
	}

	render () {
		return (
			<div className='tag-input'>
				<TagInput
					addOnBlur={true}
					inputValue={''}
					onChange={(values: string[]) => {
						return this.handleChangeTags(values);
					}}
					placeholder='Add tags'
					values={this.props.tags}
				/>
			</div>
		);
	}
}

function mapDispatchToProps (dispatch) {
	return {
		actions: {
			watcher: bindActionCreators(WatcherActions, dispatch)
		}
	};
}

export default connect(null, mapDispatchToProps)(Tags);
