TorqueBox::RemoteDeploy.configure do
  torquebox_home "/opt/torquebox"
  hotsname "localhost"
  port "2222"
  user "torquebox" #vagrant?
  key "~/.vagrant.d/insecure_private_key"
end