module ProjectsHelper
  # Helper function for 'overview', calculates total effort in a phase
  def calculate_phase_effort(project_id, project_phase)
    deliverable = Deliverable.find_all_by_project_id(project_id)
    del_to_process = deliverable.select {|d| d.phase == project_phase }

    sum = 0
    del_to_process.each do |d|
      sum += d.estimated_effort.to_f
    end
    return sum
  end
end
