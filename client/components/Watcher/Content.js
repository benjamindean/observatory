import React from 'react';
import { Callout, Intent } from '@blueprintjs/core';

type ContentProps = {
	icon?: Object,
	value?: string,
	intent?: string
};

class Content extends React.PureComponent<ContentProps> {
	static defaultProps = {
		value: false,
		icon: null,
		intent: Intent.NONE
	};

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

export default Content;
