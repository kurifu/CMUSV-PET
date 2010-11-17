# The deliverables table contains the following column
#   id                integer
#   project_id        integer
#   name              varchar(255)
#   deliverable_url   varchar(255)
#   complexity        varchar(255)
#   unit_measurement  varchar(255)
#   estimated_size    varchar(255)
#   estimated_effort  varchar(255)
#   production_rate   varchar(255)
#   deliverable_type  varchar(255)
#   phase             varchar(255)
#   description       text
#
# In the deliverable model class, it will validate the presence of deliverable_type,
# phase, project_id, name, complexity, unit_measurement, estimated_size,
# estimated_effort, production_rate.
# It will also check the format of deliverable_url and the numericality of project_id
#
#

class Deliverable < ActiveRecord::Base

  validates_presence_of :deliverable_type,:phase, :project_id, :name,
    :complexity, :unit_measurement, :estimated_size, :estimated_effort, :production_rate
  validates_format_of :deliverable_url,
    
    :with     => %r{^/deliverables/}i,
    :message  => 'must be in /deliverables folder',
    :unless => Proc.new { |u| u.deliverable_url.blank?}
  validates_numericality_of :project_id, :only_integer => true

  #Customized validation
  validate :valid_calculation_result?

  belongs_to :project

  has_attached_file :attachment,
    :path => "attachments/:id/:attachment_file_name",
    :url => "attachments/:id/:attachment_file_name"
  #validates_attachment_presence :attachment
  

  private

  def valid_calculation_result?

    unless estimated_size * production_rate == estimated_effort
       errors.add(:estimated_size, "is not the correct result")
       errors.add(:production_rate, "is not the correct result")
       errors.add(:estimated_effort, "is not the correct result")
    end
  end
end
