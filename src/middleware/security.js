const response = require('../response');

const arrayKey = [
  'keynya',
  'kuncinya'
];

const inArray = (needle, haystack) => {
  var length = haystack.length;
  for (var i = 0; i < length; i++) {
    if (haystack[i] == needle) return true;
  }
  return false;
}

module.exports = (req, res, next) => {
  let isOk = false;
  if (req.headers['x-api-key']) {
    isOk = (inArray(req.headers['x-api-key'], arrayKey)) ? true : false;
  } else {
    return response.toJson(res, 'API key is required', {}, 401);
  }

  if (isOk === false) {
    response.toJson(res, 'Invalid API key', {}, 403);
  } else {
    next();
  }
}