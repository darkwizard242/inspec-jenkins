# copyright: 2019, Ali Muhammad

title "Compliance: Jenkins"

control "jenkins-01" do
  impact 0.7
  title "Validate that jenkins package is installed and ready to be used."
  desc "Control to validate whether jenkins is installed on the system. It will also attempt verification for the command execution."

  describe package("jenkins") do
    it { should be_installed }
  end
end


control "jenkins-02" do
  impact 0.7
  title "Validate jenkins repo file"
  desc "Control to validate whether jenkins repo file exists or not."

  describe apt('http://pkg.jenkins.io/debian-stable') do
    it { should exist }
    it { should be_enabled }
  end
end


control "jenkins-03" do
  impact 0.7
  title "Validate jenkins service is present, enabled and running."
  desc "Control to validate whether a service file exists for jenkins, it is in enabled state and is in running state."

  describe service('jenkins') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end


control "jenkins-04" do
  impact 0.7
  title "Verify jenkins process is running via jenkins user."
  desc "Control to check whether there is a 'jenkins' process is running and is owned by user 'jenkins'."

  describe processes('java') do
    its('users') { should eq ['jenkins'] }
  end
end
