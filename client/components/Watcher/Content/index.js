import { Card } from '@blueprintjs/core';
import React from 'react';

type ContentProps = {
	value?: string,
	interactive?: boolean,
	onClick?: Function
};

class Content extends React.PureComponent<ContentProps> {
	static defaultProps = {
		value: false,
		interactive: false,
		onClick: () => {}
	};

	render () {
		return (
			<div>
				{this.props.value &&
					<Card
						className='watcher-card-content'
						interactive={this.props.interactive}
						onClick={this.props.onClick}
					>
						{this.props.value}
					</Card>
				}
			</div>
		);
	}
}

export default Content;
