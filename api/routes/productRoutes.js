const express = require('express');
const router = express.Router();

const db = require('../config/db');

/// GET PRODUCTS
router.get('/', (req, res) => {

  db.query(
    'SELECT * FROM products',

    (err, result) => {

      if (err) {
        res.status(500).json(err);
      } else {
        res.json(result);
      }
    }
  );
});

/// ADD PRODUCT
router.post('/', (req, res) => {

  const {
    name,
    description,
    price,
    imageUrl,
    category,
    stock
  } = req.body;

  const sql = `
    INSERT INTO products
    (name, description, price, imageUrl, category, stock)
    VALUES (?, ?, ?, ?, ?, ?)
  `;

  db.query(
    sql,
    [
      name,
      description,
      price,
      imageUrl,
      category,
      stock
    ],

    (err, result) => {

      if (err) {
        res.status(500).json(err);
      } else {
        res.status(201).json({
          message: 'Thêm sản phẩm thành công'
        });
      }
    }
  );
});

/// UPDATE PRODUCT
router.put('/:id', (req, res) => {

  const id = req.params.id;

  const {
    name,
    description,
    price,
    imageUrl,
    category,
    stock
  } = req.body;

  const sql = `
    UPDATE products
    SET
      name = ?,
      description = ?,
      price = ?,
      imageUrl = ?,
      category = ?,
      stock = ?
    WHERE id = ?
  `;

  db.query(
    sql,
    [
      name,
      description,
      price,
      imageUrl,
      category,
      stock,
      id
    ],

    (err, result) => {

      if (err) {
        res.status(500).json(err);
      } else {
        res.json({
          message: 'Cập nhật thành công'
        });
      }
    }
  );
});

/// DELETE PRODUCT
router.delete('/:id', (req, res) => {

  const id = req.params.id;

  db.query(
    'DELETE FROM products WHERE id = ?',
    [id],

    (err, result) => {

      if (err) {
        res.status(500).json(err);
      } else {
        res.json({
          message: 'Xóa thành công'
        });
      }
    }
  );
});

module.exports = router;
