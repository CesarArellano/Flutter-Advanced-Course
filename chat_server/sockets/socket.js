const { io } = require('../index');
const { checkJWT } = require('../helpers/jwt');
const { userConnected, userDisconnected } = require('../controllers/socket');

// Socket Messages
io.on('connection', async (client) => {
  console.log('Client Connected');
  const [validated, uid] = checkJWT(client.handshake.headers['x-token']);

  if( !validated ) return client.disconnect();

  userConnected(uid);
  
  // Global Room
  client.join( uid );
  
  client.on('personal-message', ( payload ) => {
    console.log(payload);
  });
  
  client.on('disconnect', () => {
    userDisconnected(uid);
  });  
});