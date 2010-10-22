# Project Table Tests
Factory.define :testproject, :class=>'Project' do |t|
  t.name nil
  t.description 'NDSS project'
  t.lifecycle 'XP'
end

Factory.define :project do |p|
  p.name 'PET 1.3'
  p.description  'NDSS project'
  p.lifecycle 'XP'
end

Factory.define :project_existed, :class=>'Project' do |p|
  p.name 'rails project'
  p.description 'rails project'
  p.lifecycle 'XP'
end

Factory.define :pet_project, :class=>'Project' do |t|
  t.name 'PET 1.0'
  t.description 'NDSS project'
  t.lifecycle nil
end

# Deliverable Table Tests
Factory.define :deliverable, :class=>'Deliverable' do |d|
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