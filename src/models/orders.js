const all_model = require('./all_model');

const getData = (offset = null, limit = null, order = 'id', sort = 'asc', params) => {
  let il = 0, iw = 0;
  let param = {}
  param.where = [], param.like = [];

  if (params.id && params.id != '') {
    param.where[iw] = { id: params.id }
    iw += 1;
  }

  if (params.id_meja && params.id_meja != '') {
    param.where[iw] = { id_meja: params.id_meja }
    iw += 1;
  }

  if (params.status && (params.status != '' || params.status != 'all')) {
    param.where[iw] = { status: params.status }
    iw += 1;
  } else {
    param.where[iw] = { status: 'ON GOING' }
    iw += 1;
  }

  if (params.name_meja && params.name_meja != '') {
    param.like[il] = { name_meja: params.name_meja }
    il += 1;
  }

  return all_model.get_all('v_orders', null, null, 'id', 'asc', param);
}

const insertOrders = (data) => {
  return all_model.insert_data('orders', data);
}
module.exports = {
  getData,
  insertOrders,
}