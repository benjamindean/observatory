import './style.scss';

import { Button, Card, Elevation, Intent, Popover, Position, Tooltip } from '@blueprintjs/core';
import _ from 'lodash';
import React from 'react';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import { WatcherItem } from '../../types';
import Content from './Content';
import * as WatcherActions from './actions';
import Tags from './Tags';

const { shell } = window.require('electron');

type WatcherProps = {
	actions: Object,
	isLoading?: boolean
};

class Watcher extends React.Component<WatcherItem & WatcherProps> {
	static defaultProps = {
		title: 'Test',
		url: 'URL',
		oldValue: null,
		newValue: null,
		checkTime: 'Unknown',
		isLoading: false,
		tags: []
	};

	constructor (props) {
		super(props);
		this.handleDelete = this.handleDelete.bind(this);
		this.handleUpdate = this.handleUpdate.bind(this);
		this.handleRefresh = this.handleRefresh.bind(this);
		this.handleOpenUrl = this.handleOpenUrl.bind(this);
	}

	/**
	 * Remove item from list and DB.
	 */
	async handleDelete () {
		await this.props.actions.watcher.remove(this.props._id, this.props._rev);
	}

	/**
	 * Refresh item manually.
	 */
	async handleRefresh () {
		await this.props.actions.watcher.observe(this.props._id);
	}

	/**
	 * Acknowledge change and set is as Old Value.
	 */
	async handleUpdate (values: Object) {
		const watcher = _.omit(this.props, ['actions', 'isLoading']);
		const updatedWatcher = Object.assign({}, watcher, values);

		await this.props.actions.watcher.update(updatedWatcher);
	}

	handleOpenUrl () {
		shell.openExternal(this.props.url);
	}

	render () {
		return (
			<Card className='watcher-card' elevation={Elevation.THREE} interactive={false}>
				<div className='watcher-card-heading'>
					<div className='watcher-card-heading-title'>
						<h5>{this.props.title}</h5>
						&nbsp;
						<Button
							className='pt-minimal'
							icon='document-open'
							intent={Intent.NONE}
							onClick={this.handleOpenUrl}
						/>
						&nbsp;
						<Tooltip content={this.props.element} position={Position.BOTTOM}>
							<Button className='pt-minimal' icon='code' />
						</Tooltip>
					</div>
					<div className='watcher-card-heading-delete'>
						<Button
							icon='refresh'
							intent={Intent.SUCCESS}
							loading={this.props.isLoading}
							onClick={this.handleRefresh}
						/>
						&nbsp;
						<Popover className='button-delete'>
							<Button icon='delete' intent={Intent.DANGER} />
							<div className='pt-popover-content'>
								<h5>Confirm deletion</h5>
								<Button intent={Intent.DANGER} onClick={this.handleDelete}>
									Delete
								</Button>
							</div>
						</Popover>
					</div>
				</div>
				<small>
					Updated:{' '}
					<span className={this.props.isLoading ? 'pt-skeleton' : ''}>
						{this.props.checkTime}
					</span>
				</small>
				<Tags tags={this.props.tags} watcher={this.props} />
				<Content value={this.props.oldValue} />
				{this.props.newValue &&
					<Popover className='fill'>
						<Content interactive={true} value={this.props.newValue} />
						<div className='pt-popover-content'>
							<h5>Acknowledge change?</h5>
							<Button
								intent={Intent.DANGER}
								onClick={() => {
									this.handleUpdate({
										oldValue: this.props.newValue,
										newValue: null
									});
								}}
							>
								Yes
							</Button>
						</div>
					</Popover>
				}
			</Card>
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

export default connect(null, mapDispatchToProps)(Watcher);
