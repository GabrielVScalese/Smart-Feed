const User = require("../database/models/Users");
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

const Users = {
  
  async findAll (req, res) {
    const results = await User.findAll()

    users = user_format(results)

    return res.json(users)
  },

  async findByEmail (req, res) { 
    const user_email = req.params.email
    const results = await User.findAll({where: {email: user_email}})

    users = user_format(results)

    return res.json(users[0])
  },

  async insertUser(req, res) {
    try {
      console.log(req.body)
      const { name, email, password } = req.body

      var crypto_password =  CryptoJS.AES.encrypt(password, "hex").toString()
  
      new_user = {name: name, email: email, password: crypto_password}
      
      const user = await User.create(new_user)
  
      return res.status(200).json(user)
    }
    catch (error){
      return res.status(406).json({message: 'Error for insert user'})
    }
  },

  async authenticateUser (req, res) {
    const { email, password } = req.body

    const results = await User.findAll({where: {
      email: email
    }})
    
    if (results.length == 0)
       return res.status(401).json({message: 'Invalid email!'})
    
    const user = results[0]['dataValues']

    const user_password = CryptoJS.AES.decrypt(user.password, "hex").toString(CryptoJS.enc.Utf8)

    if (user_password == password)
        return res.status(200).json({message: 'Valid password!'})
    else
        return res.status(401).json({message: 'Invalid password!'})
  },

  async deleteAll (req, res){
    await User.destroy({where: {}, truncate: true})

    return res.json({'message': 'All user was deleted!'})
  }
};

module.exports = Users;