const jwt = require('jsonwebtoken');

const errorNotAuthorized = ( res ) => {
  return res.status(401).json({
    ok: false,
    msg: 'There is no token in the request'
  });
}
const validateJWT = (req, res, next) => {
  
  //Read token
  const token = req.header('x-token');
  
  if(!token) {
    errorNotAuthorized(res);
  }

  try {
    const { uid } = jwt.verify( token, process.env.JWT_KEY );
    req.uid = uid;
    
    next();
  } catch (error) {
    errorNotAuthorized(res);
  }
}

module.exports = {
  validateJWT
}