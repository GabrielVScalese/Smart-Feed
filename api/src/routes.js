const express = require("express");
const router = express.Router();

const UserController = require('./controllers/UserController')

router.get('/', (req, res) =>{
    return res.json({message: 'Smart Feed API'})
})

router.get('/api/users', UserController.findAll)

router.post('/api/insertUser', UserController.insertUser)

router.delete('/api/deleteUsers', UserController.deleteAll)

module.exports = router
