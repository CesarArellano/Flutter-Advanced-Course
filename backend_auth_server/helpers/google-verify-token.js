const { OAuth2Client } = require('google-auth-library');

const CLIENT_ID = '41568276934-4i8oelkatdo6e3tc7qd8a5nvp63qjhc7.apps.googleusercontent.com';

const client = new OAuth2Client(CLIENT_ID);

const validateGoogleIdToken = async ( token ) => {
  try {
    console.log('Try');
    const ticket = await client.verifyIdToken({
      idToken: token,
      audience: [
        CLIENT_ID, // Web
        '41568276934-016cpra08r2o1qg1vdf90da905md30ad.apps.googleusercontent.com', // Android
        '41568276934-rj954pkdtls91jh7n0vg7l601518ov26.apps.googleusercontent.com',
        '41568276934-40i0oavfn6kphn1ia0fkh983d3g76gjo.apps.googleusercontent.com' // iOS
      ]
    });

    const payload = ticket.getPayload();
    
    console.log(payload);

    return {
      name: payload['name'],
      picture: payload['picture'],
      email: payload['email']
    };
  } catch (error) {
    return null;
  }
};

module.exports = {
  validateGoogleIdToken
}