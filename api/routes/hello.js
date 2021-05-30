async function hello(req, res) {
	try {
		return res.send({ data: 'hello' });
	} catch (error) {
		console.log(error);
		return res.send(error);
	}
}

module.exports = { hello };
