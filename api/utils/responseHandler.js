function sendResponse(res, data) {
	try {
		res.send({ success: true, data: data });
	} catch (error) {
		res.send({ success: false, data: 'An error occured!' });
	}
}

function sendError(res, errorData) {
	try {
		res.send({ success: true, data: 'An error Occured + ' + errorData });
	} catch (error) {
		console.log('Error Occured in util');
		res.send({ success: false, data: 'Error Occured while sending error' });
	}
}

module.exports = {
	sendError,
	sendResponse,
};
