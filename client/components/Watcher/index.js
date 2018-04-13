import React from 'react';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import { Button, Card, Elevation, Popover, Intent, Tooltip, Position } from '@blueprintjs/core';
import * as WatcherActions from './actions';
import Content from './Content';

const { shell } = window.require('electron');

export type WatcherItem = {
	_id: string,
	_rev: string,
	title?: string,
	url?: string,
	oldValue?: string,
	newValue?: string,
	element: string,
	checkTime?: string,
	isLoading?: boolean
}

type WatcherProps = {
	actions: Object<Object>
}

class Watcher extends React.Component<WatcherItem & WatcherProps> {
	static defaultProps = {
		title: 'Test',
		url: 'URL',
		oldValue: null,
		newValue: null,
		checkTime: 'Unknown',
		isLoading: false
	};

	constructor (props) {
		super(props);
		this.handleDelete = this.handleDelete.bind(this);
		this.handleAcknowledge = this.handleAcknowledge.bind(this);
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
	async handleAcknowledge () {
		await this.props.actions.watcher.acknowledge(this.props._id);
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
				<Content intent={Intent.NONE} value={this.props.oldValue} />
				<Content
					icon={
						<Button
							icon='tick'
							intent={Intent.SUCCESS}
							onClick={this.handleAcknowledge}
						/>
					}
					intent={Intent.SUCCESS}
					value={this.props.newValue}
				/>
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
