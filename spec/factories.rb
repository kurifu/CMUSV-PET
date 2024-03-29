# Factory for project
#modified p.user_id of this factory to 4
#to get the project_controller_test to pass
Factory.define :valid_project, :class=>'Project' do |p|
  p.id 100
  p.name "PET 1.3"
  p.description  "NDSS project"
  p.lifecycle "Simplified Waterfall"
  p.user_id 4
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
  t.lifecycle "Simplified Waterfall"
end

# Testing Historical Data Gathering
Factory.define :archived_p1, :class => 'Project' do |p|
  p.id 1
  p.status 'archived'
  p.lifecycle 'Simplified Waterfall'
  p.name 'Archived Project 1'
  p.user_id 4
end

Factory.define :historical_d1, :class => 'Deliverable' do |d|
  d.complexity 'Low'
  d.deliverable_type 'UML'
  
  d.estimated_size 2.0
  d.estimated_effort 6.0
  d.production_rate 3.0

  d.project_id 1
  d.phase "System Design"
  d.name "f"
  d.unit_measurement "f"
end

Factory.define :historical_d3, :class => 'Deliverable' do |d|
  d.complexity 'Low'
  d.deliverable_type 'UML'

  d.estimated_size 4.0
  d.estimated_effort 12.0
  d.production_rate 3.0

  d.project_id 1
  d.phase "System Design"
  d.name "g"
  d.unit_measurement "g"
end

Factory.define :archived_p2, :class => 'Project' do |p|
  p.id 2
  p.status 'archived'
  p.lifecycle 'XP'
  p.name 'Archived Project 2'
end

Factory.define :historical_d2, :class => 'Deliverable' do |d|
  d.complexity 'Low'
  d.deliverable_type 'UML'

  d.estimated_size 1.0
  d.estimated_effort 8.0
  d.production_rate 8.0

  d.project_id 2
  d.phase "System Design"
  d.name "f"
  d.unit_measurement "f"
end

# valid user
# modified user id of this user to 4
# to get the project_controller_spec to pass
Factory.define :valid_user, :class=> 'User' do |u|
  u.id 4
  u.username 'valid'
  u.email 'valid@test.com'
  u.password 'test1234'
  u.password_confirmation 'test1234'
  u.user_class 'admin'
end

Factory.define :valid_regular_user, :class=> 'User' do |u|
  u.id 5
  u.username 'regularuser'
  u.email 'regular@tested.com'
  u.password 'test1234'
  u.password_confirmation 'test1234'
  u.user_class 'Regular'
end
