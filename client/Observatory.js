import * as React from 'react';
import { Provider } from 'react-redux';
import './assets/css/App.scss';
import App from './components/App';
import configureStore from './configureStore';

const store = configureStore();

class Observatory extends React.PureComponent {
	render () {
		return (
			<Provider store={store}>
				<App />
			</Provider>
		);
	}
}

export default Observatory;
