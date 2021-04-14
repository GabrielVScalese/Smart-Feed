const Student = require("../database/models/Users");

const Students = {
  findAll(req, res, next) {
    Student.findAll()
      .then((result) => {
        res.json(result);
      })
      .catch(next);
  },

  async insertUser(req, res) {
    const { name, email, password } = req.body;

    const user = await Student.create({ name, email, password});

    return res.json(user);
  }
};

module.exports = Students;