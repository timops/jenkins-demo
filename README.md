jenkins-demo Cookbook
=====================

This cookbook, when used in concert with the included Vagrantfile, will
automate the deployment of a master/slave jenkins cluster.  The default
is to use JNLP for master/slave communication.  In addition to software
deployment, the following is done:

1.  Install set of commonly used Jenkins plugins (currently just
    git-client, git, and build-pipeline-plugin).
2.  Create some example jobs from templated XML.  Includes example of
    freestyle and maven style projects.

Requirements
------------

#### cookbooks:
- `jenkins` - see Berksfile for details on branch used.  Note: this is
based off of the 0.8.0 official jenkins cookbook.

#### operating systems:
- only tested on Ubuntu 12.04, but probably works elsewhere also.

Attributes
----------

#### jenkins-demo::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['jenkins']['gimmesomewar']</tt></td>
    <td>String</td>
    <td>Specify a local path for jenkins.war</td>
    <td><tt>/vagrant/jenkins.war</tt></td>
  </tr>
  <tr>
    <td><tt>['jenkins']['server']['plugins']</tt></td>
    <td>Array</td>
    <td>A list of Jenkins plugins to install</td>
    <td><tt>['git-client','git','build-pipeline-plugin']</tt></td>
  </tr>
  <tr>
    <td><tt>['jenkins-demo']['jobs']</tt></td>
    <td>Array</td>
    <td>Jenkins job names which map to existing templates</td>
    <td><tt>['maven', 'freestyle']</tt></td>
  </tr>
  <tr>
    <td><tt>['jenkins-demo']['job_dir']</tt></td>
    <td>String</td>
    <td>Temporary location for rendered Job XMLs</td>
    <td><tt>/tmp</tt></td>
  </tr>
  <tr>
    <td><tt>['jenkins-demo']['labels']</tt></td>
    <td>String</td>
    <td>Assign label to specific job</td>
    <td><tt>optional</tt></td>
  </tr>
</table>

Usage
-----

Note:  To get started testing quickly, use the provided Vagrantfile.

#### jenkins-demo::server

Just include `jenkins-demo::server` in your node's `run_list` to deploy
Jenkins master. Make sure that `recipe[apt]` precedes it on the run_list.

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[apt]",
    "recipe[jenkins-demo::server]"
  ]
}
```

#### jenkins-demo::node_jnlp

Just include `jenkins-demo::node_jnlp` in your node's `run_list` to deploy
Jenkins slave. Make sure that `recipe[apt]` precedes it on the run_list.

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[apt]",
    "recipe[jenkins-demo::node_jnlp]"
  ]
}
```


Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: TODO: List authors
