# Factory for project
Factory.define :valid_project, :class=>'Project' do |p|
  p.id 100
  p.name "PET 1.3"
  p.description  "NDSS project"
  p.lifecycle "Simplified WaterFall"
  p.user_id 2
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

# Testing Historical Data Gathering
Factory.define :archived_p1, :class => 'Project' do |p|
  p.id 1
  p.status 'archived'
  p.lifecycle 'XP'
  p.name 'Archived Project 1'
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

# valid user
Factory.define :valid_user, :class=> 'User' do |u|
  u.id 2
  u.username 'test'
  u.email 'test@test.com'
  u.password 'test'
end
end