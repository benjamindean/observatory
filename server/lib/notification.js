const { Notification } = require('electron');

module.exports = item => {
	if (!Notification.isSupported()) {
		return;
	}

	const notification = new Notification({
		title: `UPDATED: "${item.title}"`,
		subtitle: `From "${item.oldValue}" to "${item.newValue}"`
	});

	notification.show();
};
