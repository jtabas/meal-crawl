# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

desc 'Update Foundation for Sites assets'
   task update: :clean do
    sh 'bower install'
    sh 'cp -R bower_components/foundation-sites/dist/js/plugins/* vendor/assets/js/'
end
