#
# Cookbook Name:: jenkins-demo
# Attributes:: default
#
# Author:: Tim Green <tgreen@opscode.com>
#
# Copyright:: 2013, Opscode, Inc.
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

default['jenkins']['gimmesomewar'] = '/vagrant/jenkins.war'
default['jenkins']['server']['plugins'] = [ 'git-client', 'git', 'build-pipeline-plugin' ]

default['jenkins-demo']['notify'] = 'none@opscode.com'
default['jenkins-demo']['jobs'] = [ 'maven', 'freestyle' ]
default['jenkins-demo']['job_dir'] = '/tmp'
default['jenkins-demo']['labels'] = 'linux'

default['s3_file']['bucket'] = 'tgopc'
default['s3_file']['remote_path'] = '/jenkins.war'
default['s3_file']['aws_access_key_id'] = 'access_key'
default['s3_file']['aws_secret_access_key'] = 'secret_access_key'
