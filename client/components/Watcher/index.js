import React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import { Button, Card, Elevation, Popover, Intent } from '@blueprintjs/core';
import * as WatcherActions from './actions';
import Label from './Label';
import Content from './Content';

class Watcher extends React.Component {
	constructor (props) {
		super(props);
		this.handleDelete = this.handleDelete.bind(this);
		this.handleAcknowledge = this.handleAcknowledge.bind(this);
		this.handleRefresh = this.handleRefresh.bind(this);
	}

	/**
	 * Remove item from list and DB.
	 */
	async handleDelete () {
		await this.props.actions.watcher.remove(this.props.id, this.props.rev);
	}

	/**
	 * Refresh item manually.
	 */
	async handleRefresh () {
		await this.props.actions.watcher.observe(this.props.id);
	}

	/**
	 * Acknowledge change and set is as Old Value.
	 */
	async handleAcknowledge () {
		await this.props.actions.watcher.acknowledge(this.props.id);
	}

	render () {
		return (
			<Card className='watcher-card' elevation={Elevation.THREE} interactive={false}>
				<div className='watcher-card-heading'>
					<div className='watcher-card-heading-title'>
						<h5>{this.props.title}</h5>
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
				<Label
					content={'Updated: ' + this.props.checkTime}
					isLoading={this.props.isLoading}
					title='Meta'
				/>
				<Label
					content={
						<a href={this.props.url} target='_blank'>
							{this.props.url}
						</a>
					}
					title='URL'
				/>
				<Label content={this.props.element} title='Selector' />
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

Watcher.defaultProps = {
	title: 'Test',
	url: 'URL',
	oldValue: null,
	newValue: null,
	checkTime: 'Unknown',
	isLoading: false
};

Watcher.propTypes = {
	id: PropTypes.string.isRequired,
	rev: PropTypes.string.isRequired,
	title: PropTypes.string,
	url: PropTypes.string,
	oldValue: PropTypes.string,
	newValue: PropTypes.string,
	element: PropTypes.string.isRequired,
	actions: PropTypes.object.isRequired,
	checkTime: PropTypes.string,
	isLoading: PropTypes.bool
};

function mapDispatchToProps (dispatch) {
	return {
		actions: {
			watcher: bindActionCreators(WatcherActions, dispatch)
		}
	};
}

export default connect(null, mapDispatchToProps)(Watcher);
