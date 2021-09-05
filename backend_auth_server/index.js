const express = require('express');
require('dotenv').config(); // Lee el archivo .env

const app = express();

// parsear params
app.use(express.json());

// Route
app.use( '/', require('./routes/auth') );

app.listen( process.env.PORT || 3000, () => {
  const port = process.env.PORT || 3000;
  console.log(`Servidor corriendo en el puerto ${ port }`);
});