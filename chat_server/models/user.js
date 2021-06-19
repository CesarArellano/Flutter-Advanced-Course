const { Schema, model } = require('mongoose');

const UserSchema = Schema({
  name: {
    type: String,
    required: true
  },
  email: {
    type: String,
    require: true,
    unique: true,
  },
  password: {
    type: String,
    required: true,
  },
  online: {
    type: Boolean,
    default: false
  }
});

// Overwriting in the toJSON Method to display some properties
UserSchema.method('toJSON', function() {
  const { __v, _id, password, ...object } = this.toObject();
  object.uid = _id;
  return object;
});

module.exports = model('User', UserSchema);