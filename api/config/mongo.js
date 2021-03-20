const mongoose = require("mongoose");
const dbName = process.env.DB_NAME;
const dbPass = process.env.DB_PWD;
// const DB_URI = process.env.DB_URI;
try {
  function connectMongo() {
    var mongouri = `mongodb://localhost:27017/${dbName}:${dbPass}`;

    // var mongouri = DB_URI;
    mongoose.connect(
      mongouri,
      {
        useNewUrlParser: true,
        useUnifiedTopology: true,
      },
      (err) => {
        if (err) console.log(err);
        else console.log("Connected to MongoDB");
      }
    );
  }
} catch (e) {
  console.log(e);
}

module.exports = { connectMongo };
