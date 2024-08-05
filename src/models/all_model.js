const db = require('../config/database');

const get_all = async (table, offset = null, limit = null, order, sort, param = []) => {
  var select = (param.select) ? param.select : '*';
  var where_clause = (param.where) ? param.where : '';
  var having_clause = (param.having) ? param.having : '';
  var like_clause = (param.like) ? param.like : '';
  var group_clause = (param.group) ? `GROUP BY ${param.group}` : '';
  var limit_clause = (limit) ? `LIMIT ${limit}` : '';
  var offset_clause = (offset) ? `OFFSET ${offset}` : '';

  var where = "";
  if (where_clause != '') {
    where_clause.forEach(element => {

      Object.entries(element).map(([key, val]) => {
        where += " AND " + key + " = '" + val + "'";
      });
    });
  }

  var like = "";
  if (like_clause != '') {
    like_clause.forEach(element => {
      Object.entries(element).map(([key, val]) => {
        like += " AND " + key + " LIKE '%" + val + "%'";
      });
    });
  }

  var having = "";
  var i_having = 0;
  if (having_clause != '') {
    having_clause.forEach(element => {
      Object.entries(element).map(([key, val]) => {
        if (i_having == 0) {
          having += "HAVING " + key + " = '" + val + "'";
        } else {
          having += " AND " + key + " = '" + val + "'";
        }
        i_having++;
      });
    });
  }

  try {
    var querySql = `SELECT ${select} FROM ${table} WHERE 1=1${where + like} ${having} ${group_clause} ORDER BY ${order} ${sort} ${limit_clause} ${offset_clause}`;
    const result = await db.execute(querySql);
    return result;
  } catch (error) {
    return false
  }
}

const count_all = async (table, offset = 0, limit = 1, order, sort, param = []) => {
  var where_clause = (param.where) ? param.where : '';
  var having_clause = (param.having) ? param.having : '';
  var like_clause = (param.like) ? param.like : '';
  var group_clause = (param.group) ? `GROUP BY ${param.group}` : '';

  var where = "";
  if (where_clause != '') {
    where_clause.forEach(element => {
      Object.entries(element).map(([key, val]) => {
        where += " AND " + key + " = '" + val + "'";
      });
    });
  }

  var like = "";
  if (like_clause != '') {
    like_clause.forEach(element => {
      Object.entries(element).map(([key, val]) => {
        like += " AND " + key + " LIKE '%" + val + "%'";
      });
    });
  }

  var having = "";
  var i_having = 0;
  if (having_clause != '') {
    having_clause.forEach(element => {
      Object.entries(element).map(([key, val]) => {
        if (i_having == 0) {
          having += "HAVING " + key + " = '" + val + "'";
        } else {
          having += " AND " + key + " = '" + val + "'";
        }
        i_having++;
      });
    });
  }

  try {
    var querySql = `SELECT COUNT(*) AS total_results FROM ${table} WHERE 1=1${where + like} ${having} ${group_clause}`;
    const result = await db.execute(querySql);
    return result;
  } catch (error) {
    return false
  }
}

const insert_data = async (table, data) => {
  try {
    var sql = `INSERT INTO ${table} SET ?`;
    const result = await db.query(sql, [data]);
    return result;
  } catch (error) {
    return false;
  }
}

const update_data = async (table, where_by, where_value, data) => {
  try {
    var sql = `UPDATE ${table} SET ? WHERE ${where_by} = ${where_value}`;
    const result = await db.query(sql, [data]);
    return result;
  } catch (error) {
    return false;
  }
}

const delete_data = async (table, where_by, where_value) => {
  try {
    var sql = `DELETE FROM ${table} WHERE ${where_by} = ${where_value}`;
    const result = await db.execute(sql)
    return result;
  } catch (error) {
    return false;
  }
}

const manual_query = async (query) => {
  try {
    return await db.execute(query)
  } catch (error) {
    return false;
  }
}

module.exports = {
  get_all,
  count_all,
  insert_data,
  update_data,
  delete_data,
  manual_query
}