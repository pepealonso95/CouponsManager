const config = require('config-yml')
const mongoose = require('mongoose')

mongoose.connect(config.database.address + config.database.db_name, {
  useNewUrlParser: true,
  useCreateIndex: true,
  useFindAndModify: false
}).then(() => {
  console.log('Successfuly Connected to Database.')
}).catch((error) => {
  console.log(error);
  console.log('Could not connect to database', config.database.address + config.database.db_name)
})
