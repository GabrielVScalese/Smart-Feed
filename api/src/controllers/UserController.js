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
      const { name, email, password } = req.body

      var crypto_password =  CryptoJS.AES.encrypt(password, "hex").toString()
  
      new_user = {name: name, email: email, password: crypto_password}
      
      const user = await Student.create(new_user)
  
      console.log(user)
  
      return res.json(user).status(200)
    }
    catch (error){
      return res.json({message: 'Error for insert user'}).status(500)
    }
  },

  async deleteAll (req, res){
    await Student.destroy({where: {}, truncate: true})

    return res.json({'message': 'All user was deleted!'})
  }
};

module.exports = Students;