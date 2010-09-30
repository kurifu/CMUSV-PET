class Deliverable < ActiveRecord::Base
  validates_presence_of :deliverable_type_id, :project_id, :name, :deliverable_url, :complexity, :unit_measurement
  validates_format_of :deliverable_url,
    # don't allow .exe
    :with     => %r{^/deliverables/}i,
    :message  => 'must be in /deliverables folder'
  validates_numericality_of :deliverable_type_id, :only_integer => true
  validates_numericality_of :project_id, :only_integer => true
  validates_numericality_of :estimated_size, :estimated_effort, :production_rate
end
