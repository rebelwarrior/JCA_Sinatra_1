

package :tmux do
  apt 'tmux' do
    pre :install, 'echo "tmux to install"'
    post :install, 'echo "done w/ tmux"'
  end
  verify do
    has_apt 'tmux'
  end
end

package :node do
  requires :git
  apt 'make'
  apt 'g++'
  apt 'python'
  runner "git clone https://github.com/joyent/node.git"
  runner "cd node"
  runner "./configure"
  runner "make"
  runner "sudo make install"
  runner "cd .."
  verify do 
    has_file '/usr/local/bin/npm'
    has_executable 'npm'
  end
end

package :'coffee-script' do
  requires :node
  runner 'sudo npm -g install coffee-script'
  verify do
    has_executable 'coffee'
  end
end


package :git do
  apt 'git-core'
  verify do
    has_apt 'git-core'
  end
end

package :rbenv do
  requires :git
  runner "git clone https://github.com/sstephenson/rbenv.git ~/.rbenv"
  runner "git clone https://github.com/sstephenson/rbuy-build.git ~/.rbenv/plugins/ruby-build"
  # if Ubuntu
  runner %q[echo 'eval "$(rbenv init -)"' >> ~/.profile]
  push_text 'export PATH="~/.rbenv/bin:$PATH"', '~/.profile'
  # if Vagrant Ubuntu
  # runner %q[echo 'eval "$(rbenv init -)"' >> /home/vagrant/.profile]
  # push_text 'export PATH="~/.rbenv/bin:$PATH"', '/home/vagrant/.profile'
  # runner "sudo chown -R vagrant /home/vagrant/.rbenv"
  
  runner 'exec $SHELL -l' # will this work??
  verify do 
    has_executable 'rbenv'
  end
end

package :jruby do
  version "1.7.4"
  requires :rbenv
  requires :java
  runner "rbenv install jruby-1.7.4"
  runner "rbenv local jruby-1.7.4"
  runner "rbenv rehash"
  verify do
    has_executable 'jruby'
  end
end

package :java7, :provides => :java do
  apt 'openjdk-7-jdk'
  verify do
    has_apt 'openjdk-7-jdk'
  end
end

package :tomcat7, :provides => :tomcat do
  requires :java
  apt 'tomcat7'
  verify do
    has_apt 'tomcat7'
  end
end

package :torquebox do
  requires :jruby
  recommends :rbenv
  gem 'torquebox-server' do
    version "2.3.0"
    #source
    build_docs false
  end
  runner "rbenv rehash"
end

package :mariadb, :provides => [:mysql, :database] do
  apt 'python-software-properties'
  runner 'sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db'
  runner "sudo add-apt-repository 'deb http://mirror.jmu.edu/pub/mariadb/repo/5.5/ubuntu precise main'"
  runner 'sudo apt-get update'
  apt 'mariadb-server'
  verify do
    has_apt 'mariadb-server'
  end
end
  
