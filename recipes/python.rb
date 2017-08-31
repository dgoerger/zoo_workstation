### installs and configures python3 (and python2 where possible) packages
# python2 is best-effort

include_recipe 'zoo_workstation::zoo_repo'

unless node['zoo_workstation']['python']['packages'].empty?
  node['zoo_workstation']['python']['packages'].each do |pkg|
    package pkg do
      action :install
    end
  end
end

link '/usr/local/bin/jupyter' do
  link_type :symbolic
  to '/usr/bin/jupyter-3'
end

if node['zoo_workstation']['nvidia']['install']
  include_recipe 'zoo_workstation::nvidia'

  package 'python3-tensorflow-gpu' do
    action :install
  end
  package 'python2-tensorflow-gpu' do
    action :install
  end
else
  package 'python3-tensorflow' do
    action :install
  end
  package 'python2-tensorflow' do
    action :install
  end
end

cookbook_file '/usr/local/lib/python3_startup.py' do
  # disable ~/.python_history by default - in case anyone types creds - can be reenabled with `unset PYTHONSTARTUP`
  source 'python3_startup.py'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
end

# download datasets
execute 'python_spacy_dataset' do
  # spacy requires download of dataset
  command 'python3 -m spacy.en.download all && python3 -m spacy.de.download all'
  only_if { File.exist?('/usr/lib64/python3.6/site-packages/spacy') && ! File.exist?('/usr/lib64/python3.6/site-packages/spacy/data/__init__.py') }
end
execute 'python_nltk_dataset' do
  # nltk requires download of nltk_data
  command 'python3 -m nltk.downloader -d /usr/local/share/nltk_data all'
  only_if { File.exist?('/usr/lib/python3.6/site-packages/nltk') && ! File.exist?('/usr/local/share/nltk_data') }
end

### ANACONDA
# anaconda - python3.6
execute 'install_anaconda3' do
  command 'bash /usr/local/src/anaconda-4.4.0.py3.x86_64.sh -b -p /usr/local/anaconda3'
  action :nothing
end

remote_file '/usr/local/src/anaconda-4.4.0.py3.x86_64.sh' do
  # swap out to always source latest at time of machine build
  # .. find latest version at https://repo.continuum.io/anaconda/
  #
  #source 'https://repo.continuum.io/anaconda/anaconda3-latest-Linux-x86_64.sh'
  source 'https://repo.continuum.io/archive/Anaconda3-4.4.0-Linux-x86_64.sh'
  owner 'root'
  group 'root'
  mode '0500'
  action :create
  notifies :run, 'execute[install_anaconda3]', :immediately
end

link '/usr/local/bin/conda' do
  to '/usr/local/anaconda3/bin/conda'
  link_type :symbolic
  action :create
end
