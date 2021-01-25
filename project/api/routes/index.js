const express = require('express');
const router = express.Router();

// home endpoint renders index html
router.get('/', (req, res) => {
	res.render('index')
})

module.exports = router;
