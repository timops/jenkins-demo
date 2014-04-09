#
# Cookbook Name:: jenkins-demo
# Recipe:: server
#
# Author:: Doug MacEachern <dougm@vmware.com>
# Author:: Fletcher Nichol <fnichol@nichol.ca>
# Author:: Seth Chisamore <schisamo@opscode.com>
#
# Copyright 2010, VMware, Inc.
# Copyright 2012, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'jenkins::server'

node['jenkins-demo']['jobs'].each do |job|

  job_file = "#{job}_config.xml" 
  job_withpath = "#{node['jenkins-demo']['job_dir']}/#{job_file}"


  t = template job_withpath do
    source "#{job_file}.erb"
    variables({
     :notify => node['jenkins-demo']['notify']
    }) 
    action :nothing
  end

  t.run_action(:create)

  jenkins_job job do
    url node['jenkins']['server']['url'] 
    job_name "#{job}_project"
    config job_withpath
    action :create
  end

  file job_withpath do
    action :delete
  end

end
