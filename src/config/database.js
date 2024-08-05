const mysql = require('mysql2');

var db = mysql.createPool({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_DATABASE,
  dateStrings: ['DATE', 'DATETIME', 'TIMESTAMP'],
  timezone: "+07:00",
  typeCast: function (field, next) {
    if (field.type == 'VAR_STRING') {
      return (field.string());
    }
    return next();
  }
});

db.getConnection((err, conn) => {
  if (err) {
    console.error('DB_err', err.message);
  }
})

module.exports = db.promise();