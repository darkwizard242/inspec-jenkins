# copyright: 2019, Ali Muhammad

title "Compliance: Jenkins"

default_variables = yaml(content: inspec.profile.file('variables.yml')).params

control "jenkins-01" do
  impact 0.7
  title "Validate that jenkins package is installed and ready to be used."
  desc "Control to validate whether jenkins is installed on the system. It will also attempt verification for the command execution."

  default_variables.each do |var|
    describe package(var["jenkins_package_name"]) do
      it { should be_installed }
    end
end


control "jenkins-02" do
  impact 0.7
  title "Validate jenkins service is present, enabled and running."
  desc "Control to validate whether a service file exists for jenkins, it is in enabled state and is in running state."

  describe service('jenkins') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end


control "jenkins-03" do
  impact 0.7
  title "Verify jenkins process is running via jenkins user and group."
  desc "Control to check whether there is a 'jenkins' process is running and is owned by user/group 'jenkins'."

  describe processes('java') do
    its('users') { should eq ['jenkins', 'jenkins'] }
  end
end


control "jenkins-04" do
  impact 0.7
  title "Verify jenkins home directory exists."
  desc "Control to check whether the default home directory for jenkins exists."

  describe directory('/var/lib/jenkins') do
    its('owner') { should eq 'jenkins' }
    its('group') { should eq 'jenkins' }
    its('mode') { should cmp '0755' }
  end
end


control "jenkins-05" do
  impact 0.7
  title "Verify jenkins lib directory exists."
  desc "Control to check whether there lib directory for jenkins exists."

  describe directory('/usr/share/jenkins') do
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    its('mode') { should cmp '0755' }
  end
end


control "jenkins-06" do
  impact 0.7
  title "Verify jenkins war file exists."
  desc "Control to check whether the war file for jenkins exists."

  describe file('/usr/share/jenkins/jenkins.war') do
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    its('mode') { should cmp '0644' }
  end
end


### REQUIRES REVISITING
# control "jenkins-07" do
#   impact 0.7
#   title "Verify jenkins admin initial password file exists."
#   desc "Control to check whether the file containing the initial admin password for jenkins exists."
#
#   describe file('/var/lib/jenkins/secrets/initialAdminPassword') do
#     its('owner') { should eq 'jenkins' }
#     its('group') { should eq 'jenkins' }
#     its('mode') { should cmp '0640' }
#   end
# end
