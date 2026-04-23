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

# Seed Warehouse Locations
locations = [
  { name: 'ZONE-A-01', zone: 'Dry', location_type: 'storage', capacity_volume: 100.0, capacity_weight: 1000.0 },
  { name: 'ZONE-A-02', zone: 'Dry', location_type: 'storage', capacity_volume: 100.0, capacity_weight: 1000.0 },
  { name: 'ZONE-B-01', zone: 'Bulk', location_type: 'storage', capacity_volume: 500.0, capacity_weight: 5000.0 },
  { name: 'COLD-01', zone: 'Cold Storage', location_type: 'storage', capacity_volume: 50.0, capacity_weight: 500.0 },
  { name: 'HAZ-01', zone: 'Dangerous Goods', location_type: 'storage', capacity_volume: 30.0, capacity_weight: 300.0 },
  { name: 'RECV-01', zone: 'Dry', location_type: 'receiving', capacity_volume: 200.0, capacity_weight: 2000.0 },
  { name: 'SHIP-01', zone: 'Dry', location_type: 'shipping', capacity_volume: 200.0, capacity_weight: 2000.0 },
  { name: 'DOCK-01', zone: 'Bulk', location_type: 'cross_dock', capacity_volume: 300.0, capacity_weight: 3000.0 }
]

locations.each do |loc_data|
  WarehouseLocation.find_or_create_by!(name: loc_data[:name]) do |loc|
    loc.zone = loc_data[:zone]
    loc.location_type = loc_data[:location_type]
    loc.capacity_volume = loc_data[:capacity_volume]
    loc.capacity_weight = loc_data[:capacity_weight]
    loc.current_volume = 0
    loc.current_weight = 0
    loc.is_full = false
  end
end
puts "Created #{WarehouseLocation.count} warehouse locations"

# Seed Inventory Items (Master Data)
items = [
  { name: 'Standard Euro Pallet', sku: 'PAL-EUR-01', category: 'General', unit_weight: 25.0, unit_volume: 1.5, reorder_level: 50 },
  { name: 'High-Density Battery Pack', sku: 'BAT-HD-XP', category: 'Electronics', unit_weight: 12.0, unit_volume: 0.2, reorder_level: 20 },
  { name: 'Industrial Lubricant (20L)', sku: 'LUB-IND-20', category: 'Chemicals', unit_weight: 18.5, unit_volume: 0.05, reorder_level: 100 },
  { name: 'Perishable Goods Box', sku: 'PER-BOX-S', category: 'Food', unit_weight: 5.0, unit_volume: 0.1, reorder_level: 200 },
  { name: 'Steel Coil 500kg', sku: 'STL-C500', category: 'Bulk', unit_weight: 500.0, unit_volume: 0.8, reorder_level: 5 },
  { name: 'Precision Sensors Case', sku: 'SNS-PRC-12', category: 'Electronics', unit_weight: 2.0, unit_volume: 0.02, reorder_level: 30 },
  { name: 'Safety PPE Set', sku: 'PPE-KIT-01', category: 'Safety', unit_weight: 1.5, unit_volume: 0.03, reorder_level: 150 }
]

items.each do |item_data|
  InventoryItem.find_or_create_by!(sku: item_data[:sku]) do |item|
    item.name = item_data[:name]
    item.category = item_data[:category]
    item.unit_weight = item_data[:unit_weight]
    item.unit_volume = item_data[:unit_volume]
    item.reorder_level = item_data[:reorder_level]
    item.description = "High quality #{item_data[:name]} for industrial logistics."
  end
end
puts "Created #{InventoryItem.count} inventory items"

# Seed Clients
clients = [
  { name: 'Global Tech Exporters', email: 'ops@gt-exporters.co.za', category: 'Exporter', kyc_status: 'verified', credit_score: 85, credit_limit: 500000, payment_terms: 'Net 30', risk_category: 'Low' },
  { name: 'Retail Solutions Ltd', email: 'finance@retailsol.com', category: 'Enterprise', kyc_status: 'verified', credit_score: 70, credit_limit: 1200000, payment_terms: 'Net 60', risk_category: 'Medium' },
  { name: 'Northern Cape Mining', email: 'logistics@nc-mining.org', category: 'Clearing client', kyc_status: 'in_progress', credit_score: 45, credit_limit: 250000, payment_terms: 'Net 15', risk_category: 'High' },
  { name: 'SA Department of Health', email: 'procurement@health.gov.za', category: 'Government client', kyc_status: 'verified', credit_score: 95, credit_limit: 5000000, payment_terms: 'Custom', risk_category: 'Low' },
  { name: 'Precision Parts SME', email: 'hello@pp-sme.co.za', category: 'SME', kyc_status: 'pending', credit_score: 55, credit_limit: 50000, payment_terms: 'Immediate', risk_category: 'Medium' },
  { name: 'Vortex Imports', email: 'shipping@vortex-imp.com', category: 'Importer', kyc_status: 'rejected', credit_score: 25, credit_limit: 0, payment_terms: 'Immediate', risk_category: 'Critical' }
]

clients.each do |client_data|
  Client.find_or_create_by!(email: client_data[:email]) do |client|
    client.name = client_data[:name]
    client.category = client_data[:category]
    client.kyc_status = client_data[:kyc_status]
    client.credit_score = client_data[:credit_score]
    client.credit_limit = client_data[:credit_limit]
    client.payment_terms = client_data[:payment_terms]
    client.risk_category = client_data[:risk_category]
    client.phone = "+27 11 #{rand(100..999)} #{rand(1000..9999)}"
    client.address = "#{rand(1..500)} Industrial Way, Business Park, Gauteng"
    client.registration_number = "REG-#{rand(1000..9999)}-#{rand(10..99)}"
    client.vat_number = "VAT#{rand(100000000..999999999)}"
    client.fica_compliant = [true, false].sample
    client.aml_checked = [true, false].sample
    client.bank_verified = [true, false].sample
    client.sanctions_screened = [true, false].sample
    client.fx_exposure = rand(0..client_data[:credit_limit] / 2)
  end
end
puts "Created #{Client.count} clients"

# Seed Invoices
vendors_for_invoices = Vendor.all
invoice_statuses = ['paid', 'pending', 'overdue', 'cancelled']

20.times do |i|
  vendor = vendors_for_invoices.sample
  status = invoice_statuses.sample
  amount = rand(5000.0..50000.0).round(2)
  created_at = rand(1..60).days.ago
  due_date = created_at + 30.days
  paid_date = status == 'paid' ? created_at + rand(1..15).days : nil
  
  # Adjust status based on dates if overdue
  if status == 'pending' && due_date < Date.today
    status = 'overdue'
  end

  Invoice.create!(
    invoice_number: "TFS-#{1000 + i}",
    vendor: vendor,
    amount: amount,
    status: status,
    due_date: due_date,
    paid_date: paid_date,
    created_at: created_at
  )
end
puts "Created #{Invoice.count} invoices"



