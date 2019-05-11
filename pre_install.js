var adminUsername = '###admin_username###'
var adminPassword = '###admin_password###'
var username = '###user###'
var password = '###password###'
var database = '###database###'

var db = connect('localhost:45788/admin')

var users = db.getUsers()

// Find admin user
var admin = users.find(function (user) {
  return user.user === adminUsername
})

// Create admin user if it doesn't exist
if (!admin) {
  db.createUser(
    {
      user: adminUsername,
      pwd: adminPassword,
      roles: [ { role: 'userAdminAnyDatabase', db: 'admin' }, 'readWriteAnyDatabase' ]
    }
  )
}

// Find normal user
var user = users.find(function (user) {
  return user.user === username
})

// Create normal user if it doesn't exist
if (!user) {
  db.createUser(
    {
      user: username,
      pwd: password,
      roles: [
        { role: 'readWrite', db: database }
      ]
    }
  )
}
