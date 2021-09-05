const { response } = require('express');

const googleAuth = ( req, res = response ) => {
  
  const token = req.body.token;
  
  res.json({
    ok: true,
    token
  })
}

module.exports = {
  googleAuth
};