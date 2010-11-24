module ProjectsHelper
  #(@project.id, phase)
  def calculate_phase_effort(project_id, phase)
    @hours = 0
    @dataset = Deliverable.find_all_by_phase_and_project_id(phase, project_id)
    puts @dataset
    if @dataset.nil?
      return 0
    else
      @dataset.each do |d|
        @hours += d.estimated_effort
      end
      return @hours
    end


  end
end
