# Factory for project
Factory.define :valid_project, :class=>'Project' do |p|
  p.id 100
  p.name "PET 1.3"
  p.description  "NDSS project"
  p.lifecycle "Simplified WaterFall"
end

# Factory for deliverable
Factory.define :valid_deliverable, :class=>'Deliverable' do |d|
  d.deliverable_type 4
  d.phase 'Testing'
  d.project_id 100
  d.name 'xyz11'
  d.deliverable_url '/deliverables/'
  d.complexity 'high'
  d.unit_measurement 'pages'
  d.estimated_size 3
  d.estimated_effort 12
  d.production_rate 4
end

# deliverable_controller_spec
Factory.define :del_project, :class => 'Project' do |t|
  t.name 'Temp'
  t.id 100
  t.lifecycle "Simplified WaterFall"
end

# valid user
Factory.define :valid_user, :class=> 'User' do |u|
  u.username 'test'
  u.email 'test@test.com'
  u.password 'test'
end