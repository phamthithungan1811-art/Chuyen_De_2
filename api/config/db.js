const mysql = require('mysql2');

const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'toy_shop',
});

db.connect((err) => {
  if (err) {
    console.log('Kết nối DB thất bại');
  } else {
    console.log('Kết nối DB thành công');
  }
});

module.exports = db;