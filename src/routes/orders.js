const express = require('express');
const router = express.Router();

const OrdersControllers = require('../controllers/orders');

router.get('/bills', OrdersControllers.getBills);
router.post('/', OrdersControllers.createOrders);

module.exports = router;