const Student = require("../database/models/Users");
var CryptoJS = require("crypto-js");

function user_format (results) {
  users = []
  for (let i = 0; i < results.length; i++)
  {
    user = {name: results[i]['name'], email: results[i]['email'], password: results[i]['password']}
    users.push(user)
  }

  return users
}

const Students = {
  
  async findAll (req, res) {
    const results = await Student.findAll()

    users = user_format(results)

    return res.json(users)
  },

  async findByEmail (req, res) { 
    const user_email = req.params.email
    const results = await Student.findAll({where: {email: user_email}})

    users = user_format(results)

    return res.json(users[0])
  },

  async insertUser(req, res) {
    try {
      console.log(req.body)
      const { name, email, password } = req.body

      var crypto_password =  CryptoJS.AES.encrypt(password, "hex").toString()
  
      new_user = {name: name, email: email, password: crypto_password}
      
      const user = await Student.create(new_user)
  
      return res.status(200).json(user)
    }
    catch (error){
      return res.status(406).json({message: 'Error for insert user'})
    }
  },

  async deleteAll (req, res){
    await Student.destroy({where: {}, truncate: true})

    return res.json({'message': 'All user was deleted!'})
  }
};

module.exports = Students;