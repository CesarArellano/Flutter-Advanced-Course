const { Router } = require('express');
const { googleAuth } = require('../controllers/auth');

const router = Router()

router.post('/google', googleAuth) // TODO: Crear Google Controller

module.exports = router;