const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true,
  },
  email: {
    type: String,
    required: true,
    trim: true,
    validate: {
      validator: (email) => {
        return String(email)
          .toLowerCase()
          .match(
            /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
          );
      },
      message: "Please enter a valid email address!",
    },
  },
  password: {
    required: true,
    type: String,
    validate: [
      {
        validator: (pswd) => {
          return pswd.length >= 8;
        },
        message: "Please enter a password with length > 8",
      },
      {
        validator: (pswd) => {
          return /[A-Z]/.test(pswd); 
        },
        message: "Please include at least one uppercase letter in the password",
      },
      {
        validator: (pswd) => {
          return /\d/.test(pswd); 
        },
        message: "Please include at least one number in the password",
      },
    ],
  },

  address: {
    type: String,
    default: "",
  },
  type: {
    type: String,
    default: "user",
  },
  // cart
});

module.exports = mongoose.model("User", userSchema);
