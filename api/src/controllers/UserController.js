const Student = require("../database/models/Users");
var CryptoJS = require("crypto-js")

const Students = {
  
  async findAll (req, res) {
    const results = await Student.findAll()

    users = []
    for (let i = 0; i < results.length; i++)
    {
      user = {name: results[i]['name'], email: results[i]['email'], password: results[i]['password']}
      users.push(user)
    }

    return res.json(users)
  },

  async insertUser(req, res) {
    const { name, email, password } = req.body;

    var crypto_password =  CryptoJS.AES.encrypt(password, "hex").toString();

    new_user = {name: name, email: email, password: crypto_password}
    
    const user = await Student.create(new_user);

    return res.json(user);
  },

  async deleteAll (req, res){
    await Student.destroy({where: {}, truncate: true})

    return res.json({'message': 'All user was deleted!'})
  }
};

module.exports = Students;