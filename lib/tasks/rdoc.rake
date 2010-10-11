require "rake/rdoctask"

namespace :doc do
    desc "Generate RDoc documentation"
    Rake::RDocTask.new do |rdoc|
        rdoc.rdoc_dir = "doc/app"
        rdoc.title    = "Rail Blazers PET v1.3 Documentation"
        rdoc.options << "--line-numbers" << "--inline-source" <<
        "--accessor" << "cattr_accessor=object" << "--charset" << "utf-8"
        rdoc.template = "#{ENV["template"]}.rb" if ENV["template"]
        rdoc.rdoc_files.include("README")
        rdoc.rdoc_files.include("app/**/*.rb")
    end
end

