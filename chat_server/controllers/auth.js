const { response } = require('express');
const { validationResult } = require('express-validator');

const createUser = (req, res = response) => {
  console.log(req);
  const errors = validationResult(req);

  if( !errors.isEmpty() ) {
    return res.status(400).json({
      ok: false,
      errors: errors.mapped()
    });
  }

  res.json({
    ok: true,
    msg: 'Crear usuario'
  });
}

module.exports = {
  createUser
};