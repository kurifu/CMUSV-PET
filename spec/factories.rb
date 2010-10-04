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
  d.deliverable_type "User Requirement Documnet"
  d.phase 'iteration1'
  d.project_id 1
  d.name 'user requirement document'
  d.deliverable_url '/deliverables/'
  d.complexity 'high'
  d.unit_measurement 'pages'
  d.estimated_size 23.4
  d.estimated_effort 43.4
  d.production_rate 32.3
end

