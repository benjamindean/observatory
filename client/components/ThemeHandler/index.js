import React from 'react';
import PropTypes from 'prop-types';
import * as _ from 'lodash';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import { Button, Radio, RadioGroup } from '@blueprintjs/core';
import { Select } from '@blueprintjs/select';
import * as ThemeActions from './actions';

class ThemeHandler extends React.Component {
	constructor (props) {
		super(props);
		this.themesMap = [
			{
				title: 'Dark',
				value: 'pt-dark'
			},
			{
				title: 'Light',
				value: 'pt-light'
			}
		];

		this.handleOnSelectTheme = this.handleOnSelectTheme.bind(this);
		this.renderOption = this.renderOption.bind(this);
		this.renderMenu = this.renderMenu.bind(this);
		this.getSelectLabel = this.getSelectLabel.bind(this);
	}

	async componentWillMount () {
		await this.props.actions.theme.get();
		await this.props.actions.theme.set(this.props.theme);

		this.handleOnSelectTheme(null, this.props.theme);
	}

	async handleOnSelectTheme (item, value = null) {
		const themeValue = item ? item.target.value : value;

		await this.props.actions.theme.set(themeValue);
	}

	renderOption (item) {
		return (
			<Radio
				checked={item.value === this.props.theme}
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
			<RadioGroup onChange={this.handleOnSelectTheme} selectedValue={this.props.theme}>
				{renderedItems}
			</RadioGroup>
		);
	}

	getSelectLabel () {
		const object = _.find(this.themesMap, (theme) => {
			return theme.value === this.props.theme;
		});

		return object.title;
	}

	render () {
		return (
			<Select
				filterable={false}
				itemListRenderer={this.renderMenu}
				itemRenderer={this.renderOption}
				items={this.themesMap}
			>
				<Button icon='lightbulb' text={this.getSelectLabel()} />
			</Select>
		);
	}
}

ThemeHandler.propTypes = {
	actions: PropTypes.object.isRequired,
	theme: PropTypes.string.isRequired
};

function mapStateToProps (state) {
	return {
		theme: state.theme
	};
}

function mapDispatchToProps (dispatch) {
	return {
		actions: {
			theme: bindActionCreators(ThemeActions, dispatch)
		}
	};
}

export default connect(mapStateToProps, mapDispatchToProps)(ThemeHandler);
