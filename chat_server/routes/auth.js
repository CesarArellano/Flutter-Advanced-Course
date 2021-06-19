/*
  path: api/login
*/
const { Router } = require('express');
const { createUser } = require('../controllers/auth');

const router = Router();
router.post('/new', createUser);

module.exports = router;