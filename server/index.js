const express = require("express");
const mongoose = require("mongoose");
const PORT = 3000;

const uri = `mongodb+srv://REDACTED:REDACTED@cluster0.REDACTED.mongodb.net/?retryWrites=true&w=majority`;

const app = express();

const authRouter = require("./routes/auth");

mongoose
  .connect(uri)
  .then((_) => console.log("connected"))
  .catch((err) => console.log(err));
// API -> GET, PUT, POST, DELETE, UPDATE aka CRUD

app.use(express.json());
app.use(authRouter);

app.listen(PORT, "LOCAL PVT IP", () => {
  console.log(`Connected at port : ${PORT}`);
});
