const { io } = require('../index');
const { checkJWT } = require('../helpers/jwt');
const { userConnected, userDisconnected, saveMessage } = require('../controllers/socket');

// Socket Messages
io.on('connection', async (client) => {
  console.log('Client Connected');
  const [validated, uid] = checkJWT(client.handshake.headers['x-token']);

  if( !validated ) return client.disconnect();

  userConnected(uid);
  
  // Global Room
  client.join( uid );
  
  client.on('personal-message', async ( payload ) => {
    await saveMessage( payload );
    io.to(payload.to).emit('personal-message', payload)
  });

  client.on('disconnect', () => {
    userDisconnected(uid);
  });  
});