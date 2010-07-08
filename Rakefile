require 'rake/clean'
CLEAN.include('conf/*.elc', '*~', '#*', '.#*', '*.elc' )

rule '.elc' => ['.el'] do |t|
  sh "emacs -batch -no-init-file #{load_path} -f batch-byte-compile #{t.name}"
end
