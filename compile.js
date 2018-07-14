// can't require Lottery.sol because it's not a JS file
const path = require('path');
const fs = require('fs');
const solc = require('solc');

const lotteryPath = path.resolve(__dirname, 'contracts', 'Lottery.sol');
const source = fs.readFileSync(lotteryPath, 'utf8');

// can handle multiple contracts, but we only have 1
module.exports = solc.compile(source, 1).contracts[':Lottery'];