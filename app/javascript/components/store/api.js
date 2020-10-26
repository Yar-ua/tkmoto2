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
  // PUT, DELETE /bikes/:bike_id/fuels/:id (update, destroy fuel)
  fuel: (bikeId, id) => ('/bikes/#{bike_id}' + '/fuels/#{id}').replace('#{bike_id}', bikeId).replace('#{id}', id),

  // GET, POST /bikes/:bike_id/fuels (index, create fuels)
  oils: (bikeId) => ('/bikes/#{bike_id}' + '/oils.json').replace('#{bike_id}', bikeId),
  // GET /bike/:bike_id/fuellast (show fuel item with the biggest odometer)
//   bikeFuel: (bikeId) => (process.env.apiUrl + '/bikes/#{id}/fuellast').replace('#{id}', bikeId),

  // GET /bike/:bike_id/oillast (show the distance, where oil was changed)
//   bikeOil: (bikeId) => (process.env.apiUrl + '/bikes/#{id}/oillast').replace('#{id}', bikeId),
  // POST /bike/:bike_id/oils (create new oil for bike
//   bikeOilCreate: (bikeId) => (process.env.apiUrl + '/bikes/#{bike_id}/oils').replace('#{bike_id}', bikeId),

  // GET, POST /bikes/:bike_id/repairs (index, create repairs)
//   repairs: (bikeId) => (process.env.apiUrl + '/bikes/#{bike_id}' + '/repairs').replace('#{bike_id}', bikeId),
  // PUT, DELETE /bikes/:bike_id/repairs/:id (update, destroy repairs)
//   repair: (bikeId, id) => (process.env.apiUrl + '/bikes/#{bike_id}' + '/repairs/#{id}')
    // .replace('#{bike_id}', bikeId).replace('#{id}', id),

  // GET, PUT /bikes/:bike_id/config (show, update bike config)
//   bikeConfig: (bikeId) => (process.env.apiUrl + '/bikes/#{bike_id}' + '/config').replace('#{bike_id}', bikeId)
}