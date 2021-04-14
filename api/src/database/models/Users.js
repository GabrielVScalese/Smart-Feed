const { DataTypes } = require("sequelize");

const sequelize = require("../sequelize");

const User = sequelize.define("user", {
  id: {
    primaryKey: true,
    autoIncrement: true,
    type: DataTypes.INTEGER
  },
  name: DataTypes.STRING,
  email: DataTypes.STRING,
  password: DataTypes.STRING
});

const init = async () => {
  await User.sync();
};

init();

module.exports = User;