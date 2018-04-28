export type WatcherItem = {
	_id: string,
	_rev: string,
	title?: string,
	url?: string,
	oldValue?: string,
	newValue?: string,
	element: string,
	checkTime?: string,
	tags?: string[]
};
