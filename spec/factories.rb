Factory.define :testproject, :class=>'Project' do |t|
  t.name nil
  t.description 'NDSS project'
  t.lifecycle 'Waterfall'
end

Factory.define :project do |p|
  p.name 'PET 1.3'
  p.description  'NDSS project'
  p.lifecycle 'Waterfall'
end


