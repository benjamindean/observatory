import React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import * as WatcherActions from '../actions/watcher';

class Watcher extends React.Component {
	constructor (props) {
		super(props);
		this.handleDelete = this.handleDelete.bind(this);
	}

	async handleDelete () {
		await this.props.actions.watcher.remove(this.props.id, this.props.rev);
	}

	render () {
		return (
			<div className='box'>
				<article className='media'>
					<div className='media-content'>
						<div className='content'>
							<p>
								<strong>{this.props.title}</strong>
							</p>
							<p>
								<a href={this.props.url} target='_blank'>
									{this.props.url}
								</a>
							</p>
							<p>
								<small>{this.props.element}</small>
							</p>
							{this.props.oldValue && <blockquote>{this.props.oldValue}</blockquote>}
							{this.props.newValue && <blockquote>{this.props.newValue}</blockquote>}
						</div>
					</div>
					<div className='media-right'>
						<button className='delete' onClick={this.handleDelete} />
					</div>
				</article>
			</div>
		);
	}
}

Watcher.defaultProps = {
	title: 'Test',
	url: 'URL',
	oldValue: null,
	newValue: null
};

Watcher.propTypes = {
	id: PropTypes.string.isRequired,
	rev: PropTypes.string.isRequired,
	title: PropTypes.string,
	url: PropTypes.string,
	oldValue: PropTypes.string,
	newValue: PropTypes.string,
	element: PropTypes.string.isRequired,
	actions: PropTypes.object.isRequired
};

function mapDispatchToProps (dispatch) {
	return {
		actions: {
			watcher: bindActionCreators(WatcherActions, dispatch)
		}
	};
}

export default connect(null, mapDispatchToProps)(Watcher);
