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
