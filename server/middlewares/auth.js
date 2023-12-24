const jwt = require("jsonwebtoken");

const auth = async (req, res, next) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) {
      return res
        .status(401)
        .json({ msg: "Authentication Invalid, Access Denied!" });
    }

    const isVerified = jwt.verify(token, "5e884898");
    if (!isVerified) {
      return res
        .status(401)
        .json({ msg: "Authentication Invalid, Access Denied!" });
    }
    req.user = isVerified.id;
    req.token = token;
    next();
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
};

module.exports = auth;
