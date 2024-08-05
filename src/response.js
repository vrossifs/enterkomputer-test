const toJson = (res, message, data = {}, code = 200, method = 'ERROR') => {
  if (method == 'GET') {
    if ('data' in data) {
      if (Object.keys(data.data).length) {
        responseGet(res, message, data, code);
      } else {
        response(res, 'Data does not exist', {}, 404);
      }
    } else {
      if (Object.keys(data).length) {
        response(res, message, data, code, 1);
      } else {
        response(res, 'Data does not exist', {}, 404);
      }
    }
  } else if (method == 'POST' || method == 'PUT' || method == 'PATCH' || method == 'DELETE') {
    if (Object.keys(data).length) {
      response(res, message, data, code, 1);
    } else {
      response(res, 'Data does not exist', {}, 404);
    }
  } else {
    response(res, message, {}, code);
  }
}

const responseGet = (res, message, data, code) => {
  const page = data.page ? data.page : 1;
  const total_page = Math.ceil((data.totalData / data.limit));
  res.status(code).json({
    status: true,
    message: message,
    data: data.data,
    meta: {
      status_code: code,
      total: Number(data.totalData),
      per_page: Number(data.limit),
      current_page: Number(page),
      prev_page: ((Number(page) - 1) != 0) ? Number((page - 1)) : null,
      next_page: ((Number(page)) != total_page) ? Number((page + 1)) : null,
      total_page: Number(total_page),
    }
  })
}

const response = (res, message, data, code, status = 0) => {
  res.status(code).json({
    status: Boolean(status),
    message: message,
    data: data,
    meta: {
      status_code: code
    }
  })
}

module.exports = {
  toJson
}