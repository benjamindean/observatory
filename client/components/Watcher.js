import React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import * as WatcherActions from '../actions/watcher';

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
			<div className='card'>
				<header className='card-header'>
					<p className='card-header-title'>{this.props.title}</p>
					<button className='delete' onClick={this.handleDelete} />
				</header>
				<div className='card-content'>
					<div className='content'>
						<p>
							<small>
								<strong>Meta</strong>
							</small>
							<br />
							<time>
								<small>{'Updated: ' + this.props.checkTime}</small>
							</time>
						</p>
						<p>
							<small>
								<strong>URL</strong>
							</small>
							<br />
							<small>
								<a href={this.props.url} target='_blank'>
									{this.props.url}
								</a>
							</small>
						</p>
						<p>
							<small>
								<strong>Selector</strong>
							</small>
							<br />
							<small>{this.props.element}</small>
						</p>
						<p>
							<small>
								<strong>Content</strong>
							</small>
							<br />
							<br />
							{this.props.oldValue &&
								<div className='notification'>{this.props.oldValue}</div>
							}
							{this.props.newValue &&
								<div className='notification is-primary'>
									<button className='delete' onClick={this.handleAcknowledge} />
									{this.props.newValue}
								</div>
							}
						</p>
					</div>
				</div>
				<footer className='card-footer'>
					<a className='card-footer-item' onClick={this.handleRefresh}>
						Refresh
					</a>
				</footer>
			</div>
		);
	}
}

Watcher.defaultProps = {
	title: 'Test',
	url: 'URL',
	oldValue: null,
	newValue: null,
	checkTime: 'Unknown'
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
	checkTime: PropTypes.string
};

function mapDispatchToProps (dispatch) {
	return {
		actions: {
			watcher: bindActionCreators(WatcherActions, dispatch)
		}
	};
}

export default connect(null, mapDispatchToProps)(Watcher);
