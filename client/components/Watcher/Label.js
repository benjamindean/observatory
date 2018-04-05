import React from 'react';
import PropTypes from 'prop-types';

class Label extends React.PureComponent {
	render () {
		return (
			<p>
				<small>
					<strong>{this.props.title}</strong>
				</small>
				<br />
				<small className={this.props.isLoading ? 'pt-skeleton' : ''}>
					{this.props.content}
				</small>
			</p>
		);
	}
}

Label.defaultProps = {
	isLoading: false
};

Label.propTypes = {
	title: PropTypes.string.isRequired,
	content: PropTypes.any.isRequired,
	isLoading: PropTypes.bool
};

export default Label;
