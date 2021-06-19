const jwt = require('jsonwebtoken');

const generateJWT = ( uid ) => {
  return new Promise( (resolve, reject) => {
    const payload = { uid };
  
    jwt.sign(payload, process.env.JWT_KEY, {
      expiresIn: '24h',
    }, (err, token) => {
      if (err) {
        // It couldn't be generated
        reject('Could not be generated JWT');
      } else {
        // TOKEN
        resolve(token);
      }
    });
  });
};

module.exports = {
  generateJWT
}