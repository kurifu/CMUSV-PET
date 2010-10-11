require "rake/rdoctask"

namespace :doc do
    desc "Generate RDoc documentation"
    Rake::RDocTask.new do |rdoc|
        rdoc.rdoc_dir = "doc/app"
        rdoc.title    = "Rail Blazers PET v1.3 Documentation"
        rdoc.options << "--main" << "doc/DESIGN_DECISION"
        rdoc.options << "--line-numbers" << "--inline-source" <<
        "--accessor" << "--charset" << "utf-8" << "--diagram"
        rdoc.template = "#{ENV["template"]}.rb" if ENV["template"]
        rdoc.rdoc_files.include("README")
        rdoc.rdoc_files.include("app/**/*.rb")
        rdoc.rdoc_files.include("doc/DESIGN_DECISION")
        rdoc.rdoc_files.include("public/static_table.xml")
    end
end

