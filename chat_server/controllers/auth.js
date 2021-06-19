const { response } = require('express');

const createUser = (req, res = response) => {
  res.json({
    ok: true,
    msg: 'Crear usuario'
  });
}

module.exports = {
  createUser
};