#task :default => 'install'

desc "Executes pod install"
task :install do
  sh "cd Example && bundle exec pod install && cd .."
end

desc "Executes pod update"
task :update do
  sh "cd Example && bundle exec pod update && cd .."
end

desc "Executes lint"
task :lint do
  sh "bundle exec pod lib lint --verbose"
end
