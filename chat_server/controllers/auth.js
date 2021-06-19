const { response } = require('express');
const User = require('../models/user');

const createUser = async (req, res = response) => {
  
  const user = new User(req.body);
  await user.save();

  res.json({
    ok: true,
    body: req.body
  });
}

module.exports = {
  createUser
};