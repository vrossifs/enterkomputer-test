const express = require('express');
const morgan = require('morgan');
const bodyParser = require('body-parser');
const compression = require('compression');
const helmet = require('helmet');
const cors = require('cors');

const middlewareCheckKey = require('./middleware/security');
const response = require('./response');

const app = express();

app.use(morgan('dev'));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.use(compression());
app.use(helmet());
app.use(cors());

app.use(middlewareCheckKey);

app.use('/orders', require('./routes/orders'));

app.use((req, res, next) => {
  const error = new Error('Path did not found!');
  error.status = 404;

  next(error);
})

app.use((error, req, res, next) => {
  response.toJson(res, error.message || 'Internal server error', {}, error.status || 500);
});

module.exports = app;