Factory.define :testproject, :class=>'Project' do |t|
  t.name nil
  t.description 'NDSS project'
  t.lifecycle_id 1
end

Factory.define :project do |p|
  p.name 'PET 1.3'
  p.description  'NDSS project'
  p.lifecycle_id 2
end

Factory.define :project_existed, :class=>'Project' do |p|
  p.name 'rails project'
  p.description 'rails project'
  p.lifecycle_id 3
end

Factory.define :pet_project, :class=>'Project' do |t|
  t.name 'PET 1.0'
  t.description 'NDSS project'
  t.lifecycle_id nil
end


