import React from 'react';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import * as SearchActions from './actions';

type SearchProps = {
	actions: Object,
	watchers: Array
};

class Search extends React.PureComponent<SearchProps> {
	constructor (props) {
		super(props);

		this.handleWatcherFilter = this.handleWatcherFilter.bind(this);
	}

	handleWatcherFilter (event) {
		const term = event.target.value;

		this.props.actions.search.filterWatchers(this.props.watchers, term);
	}

	render () {
		return (
			<div className='pt-input-group'>
				<input
					className='pt-input'
					dir='auto'
					onChange={this.handleWatcherFilter}
					placeholder='Search by tags'
					type='search'
				/>
			</div>
		);
	}
}

function mapStateToProps (state) {
	return {
		watchers: state.watchers
	};
}

function mapDispatchToProps (dispatch) {
	return {
		actions: {
			search: bindActionCreators(SearchActions, dispatch)
		}
	};
}

export default connect(mapStateToProps, mapDispatchToProps)(Search);
