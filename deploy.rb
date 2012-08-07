#!/usr/bin/env ruby

require 'net/ssh'

module CV
  def CV.check_dir
    return File.exists? "plymouthwebdev"
  end

  def CV.deploy
    if check_dir
      Net::SSH.start('vps2.danbee.co.uk', 'danbee') do |ssh|
        ssh.exec("cd ~/plymouthwebdev; bundle install")
        ssh.exec("cd ~/plymouthwebdev; git pull origin master")
        ssh.exec("cd ~/plymouthwebdev; stasis")
      end
    else
      puts "Please run this from the projects directory."
    end
  end
end

CV.deploy
