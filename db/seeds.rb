User.find_or_create_by!(email: 'felender7@gmail.com') do |user|
  user.password = 'Tlang126920.!!'
  user.password_confirmation = 'Tlang126920.!!'
  user.first_name = 'Felender'
  user.last_name = 'Nukeri'
  user.role = 'admin'
  user.must_update_password = true
end

vendors = [
  { name: 'Maersk Line', email: 'contact@maersk.com', phone: '+27 21 555 1000', category: 'Shipping lines', status: 'active', kyc_status: 'verified', risk_score: 15 },
  { name: 'South African Airways', email: 'cargo@saa.com', phone: '+27 11 978 1111', category: 'Airlines', status: 'active', kyc_status: 'verified', risk_score: 20 },
  { name: 'Transnet Freight Rail', email: 'info@transnet.net', phone: '+27 11 308 1000', category: 'Road transporters', status: 'active', kyc_status: 'verified', risk_score: 10 },
  { name: 'DB Schenker', email: 'south.africa@dbschenker.com', phone: '+27 11 570 9000', category: 'Road transporters', status: 'active', kyc_status: 'verified', risk_score: 25 },
  { name: 'Europlaz Warehouse', email: 'operations@europlaz.co.za', phone: '+27 21 534 2000', category: 'Warehouse operators', status: 'active', kyc_status: 'in_progress', risk_score: 35 },
  { name: 'SARS Customs Brokers', email: 'enquiries@sarscustoms.co.za', phone: '+27 12 422 4000', category: 'Customs brokers', status: 'active', kyc_status: 'verified', risk_score: 12 },
  { name: 'Old Mutual Insurance', email: 'corporate@oldmutual.co.za', phone: '+27 21 509 9111', category: 'Insurance providers', status: 'active', kyc_status: 'verified', risk_score: 18 },
  { name: 'Bureau Veritas', email: 'johannesburg@bureauveritas.com', phone: '+27 11 845 2000', category: 'Inspection agencies', status: 'pending', kyc_status: 'pending', risk_score: 45 },
  { name: 'DHL Global Forwarding', email: 'info.dgf@dhgl.com', phone: '+27 11 961 1000', category: 'Shipping lines', status: 'active', kyc_status: 'verified', risk_score: 22 },
  { name: 'Toll Group', email: 'africa@tollgroup.com', phone: '+27 21 386 1500', category: 'Road transporters', status: 'inactive', kyc_status: 'rejected', risk_score: 75 }
]

vendors.each do |vendor_data|
  Vendor.find_or_create_by!(email: vendor_data[:email]) do |vendor|
    vendor.name = vendor_data[:name]
    vendor.phone = vendor_data[:phone]
    vendor.category = vendor_data[:category]
    vendor.status = vendor_data[:status]
    vendor.kyc_status = vendor_data[:kyc_status]
    vendor.risk_score = vendor_data[:risk_score]
    vendor.bank_reference = "BANK-#{vendor_data[:name].first(3).upcase}-#{rand(10000..99999)}"
    vendor.address = '123 Business Street, Johannesburg, South Africa'
  end
end

puts "Created #{Vendor.count} vendors"
