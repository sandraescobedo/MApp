airport1 = Airport.new
airport1.iata_code = 'VLC'
airport1.address = ''
airport1.save
airport2 = Airport.new
airport2.iata_code = 'BCN'
airport2.address = ''
airport2.save
airport3 = Airport.new
airport3.iata_code = 'ORY'
airport3.address = ''
airport3.save

flight1 = Flight.new
flight1.user = User.first
flight1.departured = airport1
flight1.arrived = airport2
flight1.save
flight2 = Flight.new
flight2.user = User.first
flight2.departured = airport2
flight2.arrived = airport3
flight2.save
flight3 = Flight.new
flight3.user = User.first
flight3.departured = airport3
flight3.arrived = airport2
flight3.save
flight4 = Flight.new
flight4.user = User.first
flight4.departured = airport1
flight4.arrived = airport3
flight4.save
