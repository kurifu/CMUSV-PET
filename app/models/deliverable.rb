class Deliverable < ActiveRecord::Base
  validates_presence_of :deliverable_type,:phase, :project_id, :name,
    :complexity, :unit_measurement, :estimated_size, :estimated_effort, :production_rate
  validates_format_of :deliverable_url,
    # don't allow .exe
    :with     => %r{^/deliverables/}i,
    :message  => 'must be in /deliverables folder',
    :unless => Proc.new { |u| u.deliverable_url.blank?}
  validates_numericality_of :project_id, :only_integer => true
end
