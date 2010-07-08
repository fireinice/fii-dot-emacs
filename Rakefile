require 'rake/clean'
CLEAN.include('conf/*.elc', '*~', '#*', '.#*', '*.elc' )

rule '.elc' => ['.el'] do |t|
  sh "cc #{t.source} -c -o #{t.name}"
end
