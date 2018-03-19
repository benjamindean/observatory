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
				</header>
				<div className='card-content'>
					<div className='content'>
						<p>
							<time>
								<small>{'Updated: ' + this.props.checkTime}</small>
							</time>
						</p>
						<a href={this.props.url} target='_blank'>
							{this.props.url}
						</a>
						<p>
							<small>{this.props.element}</small>
						</p>
						{this.props.oldValue && <blockquote>{this.props.oldValue}</blockquote>}
						{this.props.newValue && <blockquote>{this.props.newValue}</blockquote>}
					</div>
				</div>
				<footer className='card-footer'>
					{this.props.newValue &&
						<a className='card-footer-item is-info' onClick={this.handleAcknowledge}>
							Acknowledge
						</a>
					}
					<a className='card-footer-item' onClick={this.handleRefresh}>
						Refresh
					</a>
					<a className='card-footer-item is-danger' onClick={this.handleDelete}>
						Delete
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
