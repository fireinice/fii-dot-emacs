LOAD_PATH = Dir["*"].delete_if{ |d| File.file?(d)}.collect { |d| d = "-L #{d}" }.join(' ')


require 'rake/clean'
CLEAN.include('conf/*.elc', '*~', '#*', '.#*', '*.elc', '*_flymake.*' )



def build(filename)
  if filename.is_a?(FileList)
    #then it should be a FileList
    filename= filename.to_s
  end
  sh "emacs -batch -no-init-file #{LOAD_PATH} -f batch-byte-compile #{filename}"
end

rule '.elc' => ['.el'] do |t|
  sh "emacs -batch -no-init-file #{LOAD_PATH} -f batch-byte-compile #{t.source}"
end

task :build, [:name] do |t, args|
  filename= args[:name].to_s
  sh "emacs -batch -no-init-file #{LOAD_PATH} -f batch-byte-compile #{filename}"
end

namespace :build do
  desc "build site fiels under the root dir"
  task :site_file do
    site_files =  FileList['*.el'].exclude('trash.el')
    Rake::Task[:build].invoke(site_files)
    # build("#{FileList['*.el'].exclude('trash.el')}")
  end
end

namespace :clean do
  desc "build site fiels under the root dir"
  task :site_file do |t|
    Rake::Task[t.name.to_sym].clear
  end
end




