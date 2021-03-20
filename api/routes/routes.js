const router = require("express").Router();
const multer = require("multer");
var storage = multer.memoryStorage();
var upload = multer({ storage: storage });
const hello = require("./hello");

function isLoggedin(req, res, next) {
    if (req.session) {
      if (req.session.logged_in == true) {
        next();
      } else {
        return res.send({ success: true, data: "User Not Logged in" });
      }
    } else {
      return res.send({ success: true, data: "User Not Logged in" });
    }
  }

  //*Test routes
router.get("/hello",isLoggedin, hello.hello);




module.exports = router;
