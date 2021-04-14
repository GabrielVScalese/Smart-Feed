const express = require("express");
const router = express.Router();

router.get('/', (req, res) =>{
    return res.json({message: 'Smart Feed API'})
})

module.exports = router
