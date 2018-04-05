import React from 'react';
import PropTypes from 'prop-types';
import { Callout, Intent } from '@blueprintjs/core';

class Content extends React.PureComponent {
	render () {
		return (
			<div>
				{this.props.value &&
					<Callout
						className='watcher-card-content'
						icon={this.props.icon}
						intent={this.props.intent}
					>
						{this.props.value}
					</Callout>
				}
			</div>
		);
	}
}

Content.defaultProps = {
	value: false,
	icon: null,
	intent: Intent.NONE,
	onClick: null
};

Content.propTypes = {
	icon: PropTypes.object,
	value: PropTypes.string,
	intent: PropTypes.string
};

export default Content;
