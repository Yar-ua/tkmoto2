export default {

  // POST sign up user
  // sign_up: process.env.apiUrl + '/auth',
  sign_up: '/auth',
  
  // POST sign in user
  // sign_in: process.env.apiUrl + '/auth/sign_in'
  sign_in: '/auth/sign_in',
  
  // DELETE sign uot user
  sign_out: '/auth/sign_out',

  // GET about page
  about: '/about',

  // GET /bikes (index bikes)
  // POST /bikes (create bike)
  bikes: '/bikes.json',
  // GET, PUT, DELETE /bike/:id (show, update, delete bike)
  bike: (bikeId) => ('/bikes/#{id}.json').replace('#{id}', bikeId),

  // GET, POST /bikes/:bike_id/fuels (index, create fuels)
  fuels: (bikeId) => ('/bikes/#{bike_id}' + '/fuels.json').replace('#{bike_id}', bikeId),
  // GET, PUT, DELETE /bikes/:bike_id/fuels/:id (show, update, destroy fuel)
  fuel: (bikeId, id) => ('/bikes/#{bike_id}' + '/fuels/#{id}.json').replace('#{bike_id}', bikeId).replace('#{id}', id),

  // GET, POST /bikes/:bike_id/fuels (index, create fuels)
  oils: (bikeId) => ('/bikes/#{bike_id}' + '/oils.json').replace('#{bike_id}', bikeId),
  // GET, PUT, DELETE /bikes/:bike_id/oils/:id (show, update, destroy oil)
  oil: (bikeId, id) => ('/bikes/#{bike_id}' + '/oils/#{id}.json').replace('#{bike_id}', bikeId).replace('#{id}', id),
  
  // GET, PUT /bikes/:bike_id/bike_configs(.:format) (to show, update config)
  bikeConfig: (bikeId) => ('/bikes/#{bike_id}' + '/bike_configs.json').replace('#{bike_id}', bikeId)

}