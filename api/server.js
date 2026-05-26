const express = require('express');
const cors = require('cors');

const app = express();

app.use(cors());

app.use(express.json());

// =========================
// SAMPLE PRODUCTS
// =========================

let products = [

  {
    id: 1,
    name: 'Xe điều khiển',
    description: 'Xe đồ chơi điều khiển từ xa',
    price: 250000,
    imageUrl:
      'https://images.unsplash.com/photo-1542291026-7eec264c27ff',
    category: 'Xe đồ chơi',
    stock: 10,
  },

  {
    id: 2,
    name: 'Robot biến hình',
    description: 'Robot cho trẻ em',
    price: 350000,
    imageUrl:
      'https://images.unsplash.com/photo-1526035436495-ec5c2f4a1b1f',
    category: 'Robot',
    stock: 5,
  },
];

// =========================
// GET PRODUCTS
// =========================

app.get('/products', (req, res) => {

  res.json(products);
});

// =========================
// GET PRODUCT DETAIL
// =========================

app.get('/products/:id', (req, res) => {

  const id = parseInt(req.params.id);

  const product = products.find(
    (p) => p.id === id,
  );

  if (!product) {

    return res
        .status(404)
        .json({
          message:
              'Không tìm thấy sản phẩm',
        });
  }

  res.json(product);
});

// =========================
// ADD PRODUCT
// =========================

app.post('/products', (req, res) => {

  const product = req.body;

  products.push(product);

  res.status(201).json(product);
});

// =========================
// UPDATE PRODUCT
// =========================

app.put('/products/:id', (req, res) => {

  const id = parseInt(req.params.id);

  const index = products.findIndex(
    (p) => p.id === id,
  );

  if (index === -1) {

    return res
        .status(404)
        .json({
          message:
              'Không tìm thấy sản phẩm',
        });
  }

  products[index] = req.body;

  res.json(products[index]);
});

// =========================
// DELETE PRODUCT
// =========================

app.delete('/products/:id', (req, res) => {

  const id = parseInt(req.params.id);

  products = products.filter(
    (p) => p.id !== id,
  );

  res.json({
    message:
        'Xóa thành công',
  });
});

// =========================
// START SERVER
// =========================

const PORT = 3000;

app.listen(PORT, () => {

  console.log(
    `Server running on port ${PORT}`,
  );
});