const { DataTypes } = require("sequelize");

const sequelize = require("../sequelize");

const User = sequelize.define("user", {
  name: DataTypes.STRING,
  email: DataTypes.STRING,
  password: DataTypes.STRING
});

const init = async () => {
  await Student.sync();
};

init();

module.exports = Student;