const { response } = require('express');
const { validateGoogleIdToken } = require('../helpers/google-verify-token');

const googleAuth = async ( req, res = response ) => {
  
  const token = req.body.token;

  if( !token ) {
    return res.json({
      ok: false,
      msg: 'Token not found'
    })
  }

  const googleUser = await validateGoogleIdToken(token);
  
  if( !googleUser ) {
    return res.status(400).json({
      ok: false,
    })
  }

  res.json({
    ok: true,
    googleUser
  })
}

module.exports = {
  googleAuth
};