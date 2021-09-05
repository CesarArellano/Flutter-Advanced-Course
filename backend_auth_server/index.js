const express = require('express');
const bodyParser = require('body-parser');
require('dotenv').config(); // Lee el archivo .env

const app = express();

app.listen( process.env.PORT || 3000, () => {
  const port = process.env.PORT || 3000;
  console.log(`Servidor corriendo en el puerto ${ port }`);
});