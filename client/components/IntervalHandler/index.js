import React from 'react';
import PropTypes from 'prop-types';
import * as _ from 'lodash';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import { Button, Radio, RadioGroup } from '@blueprintjs/core';
import { Select } from '@blueprintjs/select';
import * as AppActions from '../App/actions';
import * as WatcherActions from '../Watcher/actions';
import * as IntervalActions from './actions';

class IntervalHandler extends React.Component {
	constructor (props) {
		super(props);
		this.intervalsMap = [
			{
				title: '10 seconds',
				value: 10
			},
			{
				title: '1 minute',
				value: 60
			},
			{
				title: '5 minutes',
				value: 60 * 5
			},
			{
				title: '30 minutes',
				value: 60 * 30
			},
			{
				title: '1 hour',
				value: 60 * 60
			},
			{
				title: '3 hours',
				value: 60 * 60 * 3
			}
		];

		this.handleOnSelectInterval = this.handleOnSelectInterval.bind(this);
		this.attachInterval = this.attachInterval.bind(this);
		this.renderOption = this.renderOption.bind(this);
		this.renderMenu = this.renderMenu.bind(this);
		this.getSelectLabel = this.getSelectLabel.bind(this);
	}

	async componentWillMount () {
		await this.props.actions.interval.get('interval');
		await this.props.actions.interval.set(this.props.interval);

		this.handleOnSelectInterval(null, this.props.interval);
	}

	async handleOnSelectInterval (item, value = null) {
		const intervalValue = item ? item.target.value : value;
		const interval = this.attachInterval(intervalValue);

		await this.props.actions.interval.set(intervalValue);

		this.props.actions.app.setRefreshIntervalId(interval);
	}

	attachInterval (intervalValue) {
		return setInterval(async () => {
			await this.observeAllWatchers();
		}, intervalValue * 1000);
	}

	observeAllWatchers () {
		if (!this.props.watchers) {
			return;
		}

		_.forEach(this.props.watchers, async (watcher) => {
			await this.props.actions.watcher.observe(watcher._id);
		});
	}

	renderOption (item) {
		return (
			<Radio
				checked={item.value === this.props.interval}
				key={item.value}
				label={item.title}
				value={item.value}
			/>
		);
	}

	renderMenu ({ items, renderItem }) {
		const renderedItems = items.map(renderItem).filter((item) => {
			return item !== null;
		});

		return (
			<RadioGroup
				onChange={this.handleOnSelectInterval}
				selectedValue={this.props.interval}
			>
				{renderedItems}
			</RadioGroup>
		);
	}

	getSelectLabel () {
		const object = _.find(this.intervalsMap, (interval) => {
			return interval.value === this.props.interval;
		});

		return object.title;
	}

	render () {
		return (
			<Select
				filterable={false}
				itemListRenderer={this.renderMenu}
				itemRenderer={this.renderOption}
				items={this.intervalsMap}
			>
				<Button icon='time' text={this.getSelectLabel()} />
			</Select>
		);
	}
}

IntervalHandler.propTypes = {
	actions: PropTypes.object.isRequired,
	watchers: PropTypes.array.isRequired,
	app: PropTypes.object.isRequired,
	interval: PropTypes.number.isRequired
};

function mapStateToProps (state) {
	return {
		watchers: state.watchers,
		app: state.app,
		interval: parseInt(state.interval, 10)
	};
}

function mapDispatchToProps (dispatch) {
	return {
		actions: {
			watcher: bindActionCreators(WatcherActions, dispatch),
			app: bindActionCreators(AppActions, dispatch),
			interval: bindActionCreators(IntervalActions, dispatch)
		}
	};
}

export default connect(mapStateToProps, mapDispatchToProps)(IntervalHandler);
