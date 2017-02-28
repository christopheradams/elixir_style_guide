task :test do
  exit_code = 0
  files = ["README.md", "CONTRIBUTING.md"]
  files.each do |file|
    begin
      sh "bundle exec mdl --style 'markdown.rb' #{file}"
    rescue Exception => ex
      exit_code = 1
    end
  end

  exit exit_code
end
