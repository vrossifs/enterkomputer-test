const OrdersModel = require('../models/orders');
const AllModel = require('../models/all_model');
const response = require('../response');
const moment = require('moment');

const getBills = async (req, res) => {
  if ((!req.query?.id || req.query?.id == '') && (!req.query?.id_meja || req.query?.id_meja == '')) {
    return response.toJson(res, 'id or id_meja is required', {}, 400);
  }

  try {
    const [rows] = await OrdersModel.getData(null, null, 'id', 'asc', req.query);
    const row = rows[0] ?? {};

    const param = {
      where: [
        {
          id_orders: row.id
        }
      ]
    };

    const [resDataDetail] = await AllModel.get_all('v_orders_detail', null, null, 'id', 'asc', param);
    if (!resDataDetail[0]) {
      return response.toJson(res, 'Data does not exist', {}, 404);
    }

    var orders_detail = [];
    var total_sum = 0;
    for (let i = 0; i < resDataDetail.length; i++) {
      const element = resDataDetail[i];

      orders_detail[i] = {
        id_menu: parseInt(element.id_menu),
        name_menu: element.name_menu,
        price: element.price,
        quantity: parseInt(element.quantity),
        notes: element.notes,
        total: (element.price * parseInt(element.quantity))
      }

      total_sum += (element.price * parseInt(element.quantity));
    }

    const resData = {
      id_orders: row.id,
      id_meja: row.id_meja,
      name_meja: row.name,
      order_date: row.created_at,
      sum_total: total_sum,
      items: orders_detail
    }
    response.toJson(res, 'Success!', resData, 200, req.method);
  } catch (error) {
    response.toJson(res, error.message || 'getBills Catch error', {}, 500)
  }
}

const createOrders = async (req, res) => {
  if (!req.body.id_meja || req.body.id_meja == '') {
    return response.toJson(res, 'id_meja is required', {}, 400);
  }

  if (!req.body.menu || req.body.menu == '') {
    return response.toJson(res, 'menu is required', {}, 400);
  }

  if (!req.body.menu[0].quantity || req.body.menu[0].quantity == '') {
    return response.toJson(res, 'quantity is required', {}, 400);
  }

  if (!req.body.menu[0].id_menu || req.body.menu[0].id_menu == '') {
    return response.toJson(res, 'id_menu is required', {}, 400);
  }

  try {
    const db = require('../config/database');
    const date = new Date();

    const dataInsert = {
      id_meja: req.body.id_meja,
      status: 'ON GOING',
      created_at: moment(date).format('YYYY-MM-DD HH:mm:ss')
    }

    await AllModel.update_data('orders', 'id_meja', req.body.id_meja, { status: 'COMPLETE' });
    const [data] = await OrdersModel.insertOrders(dataInsert);

    var arr = [];
    for (let i = 0; i < req.body.menu.length; i++) {
      const element = req.body.menu[i];

      arr[i] = {
        id_orders: data.insertId,
        id_menu: element.id_menu,
        quantity: element.quantity,
        notes: element.notes
      };
    }

    const query = 'INSERT INTO orders_detail (id_orders, id_menu, quantity, notes) VALUES ?';
    await db.query(query, [arr.map(item => [item.id_orders, item.id_menu, item.quantity, item.notes])]);

    const param = {
      where: [
        {
          id_orders: data.insertId
        }
      ]
    };
    const [resDataDetail] = await AllModel.get_all('v_orders_detail', null, null, 'id', 'asc', param);
    var orders_detail = [];
    var id_menus = [];
    for (let i = 0; i < resDataDetail.length; i++) {
      const element = resDataDetail[i];

      orders_detail[i] = {
        id_menu: parseInt(element.id_menu),
        name_menu: element.name_menu,
        price: element.price,
        quantity: parseInt(element.quantity),
        notes: element.notes,
      }

      id_menus.push(element.id_menu);
    }

    const qMenu = 'SELECT * FROM v_menu_detail WHERE id_menu IN (?)';
    const [resDataMenu] = await db.query(qMenu, [id_menus]);

    var printers = {};
    printers.bar = [], printers.dapur = [];
    var menus = [];
    for (let i = 0; i < resDataMenu.length; i++) {
      const element = resDataMenu[i];

      menus[i] = {
        name_menu: element.name,
        type_menu: element.type,
        name_product: element.name_product,
        variant: element.variant,
        category: element.category,
        quantity: orders_detail.find(order => {
          if (order.id_menu === element.id_menu) {
            return order;
          }
        }).quantity,
      }

      if (element.station == 'B') {
        printers.dapur.push(menus[i]);
      } else if (element.station == 'C') {
        printers.bar.push(menus[i]);
      }
    }

    const dataRes = {
      id_orders: data.insertId,
      id_meja: dataInsert.id_meja,
      status: dataInsert.status,
      created_at: dataInsert.created_at,
      orders_detail: orders_detail,
      printers: printers
    }
    response.toJson(res, 'Success!', dataRes, 201, req.method)
  } catch (error) {
    response.toJson(res, error.message || 'createOrders Catch error', {}, 500)
  }
}

module.exports = {
  getBills,
  createOrders
}