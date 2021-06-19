const { response } = require('express');
const bcrypt = require('bcryptjs');

const User = require('../models/user');
const { generateJWT } = require('../helpers/jwt');

const createUser = async (req, res = response) => {
  
  try{
    const { email, password } = req.body;
    const emailExists = await User.findOne({ email });
    if(emailExists) {
      return res.status(400).json({
        ok: false,
        msg: 'Invalid credentials'
      });
    }
    const user = new User(req.body);
    
    // Encrypting password
    const salt = bcrypt.genSaltSync();
    user.password = bcrypt.hashSync(password, salt);

    await user.save();
    
    // Generate my JWT
    const token = await generateJWT(user.id);

    res.json({
      ok: true,
      user,
      token
    });

  } catch(error) {
    console.log(error);
    res.status(500).json({
      ok: false,
      msg: 'Talk to the administrator'
    });
  }
}

module.exports = {
  createUser
};