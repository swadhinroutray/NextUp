const path = require('path');
require('dotenv').config({ path: path.resolve('../.env') });
const express = require('express');
const app = express();
const port = process.env.PORT || 8000;
const db = require('./config/mongo');
const cookieParser = require('cookie-parser');
const session = require('express-session');
const redisStore = require('./config/redis')(session);
const routes = require('./routes/routes');
const cors = require('cors');
const AWS = require('aws-sdk');
AWS.config.update({
	Bucket: process.env.BUCKET_NAME,
	accessKeyId: process.env.AWS_KEY,
	secretAccessKey: process.env.AWS_SECRET,
	region: process.env.AWS_REGION,
});

s3 = new AWS.S3({ apiVersion: '2006-03-01' });
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
// app.use((req, res, next) => {
// 	const allowedOrigins = ['http://localhost:3000', 'http://localhost:34152'];
// 	const origin = req.headers.origin;
// 	console.log(origin);
// 	if (allowedOrigins.indexOf(origin) > -1)
// 		res.setHeader('Access-Control-Allow-Origin', origin);
// 	else if (process.env.NODE_ENV !== 'production')
// 		res.setHeader('Access-Control-Allow-Origin', '*');
// 	res.header('Access-Control-Allow-Methods', 'OPTIONS,GET,PUT,POST,DELETE');
// 	res.header('Access-Control-Allow-Headers', 'Content-Type, Authorization');
// 	res.header('Access-Control-Allow-Credentials', true);
// 	return next();
// });
app.use(cors());
db.connectMongo();

const sec_sess = session({
	resave: false,
	saveUninitialized: true,
	secret: process.env.SESSION_SECRET_KEY,
	store: redisStore,
	cookie: { maxAge: 6048000000 },
});
app.use(sec_sess);
app.use(cookieParser('session'));
app.use('/api', routes);

app.listen(port, () => {
	console.log(`Listening on ${port}`);
});
