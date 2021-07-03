/*
  path: api/message
*/
const { Router } = require('express');
const { validateJWT } = require('../middlewares/validate-jwt');
const { getMessages } = require('../controllers/messages');
const router = Router();

router.get('/:from', validateJWT, getMessages);

module.exports = router;