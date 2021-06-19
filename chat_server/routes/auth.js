/*
  path: api/login
*/
const { Router } = require('express');
const { check } = require('express-validator');

const { createUser } = require('../controllers/auth');

const router = Router();
router.post('/new',[
  check('name', 'Name is required').not().isEmpty(),
], createUser);

module.exports = router;