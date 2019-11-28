var config = require('config');

function deferBinding(repositoryName) {
    let implementation = require(`./${repositoryName}-repository`);
    return implementation;
}

module.exports = deferBinding;