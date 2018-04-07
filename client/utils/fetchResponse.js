export default async function fetchResponse (url, params) {
	const response = await fetch(
		url,
		Object.assign({}, params, {
			mode: 'cors',
			headers: {
				'content-type': 'application/json'
			}
		})
	);

	return await response.json();
}
