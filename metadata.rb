name             'jenkins-demo'
maintainer       'Opscode, Inc.'
maintainer_email 'tgreen@opscode.com'
license          'All rights reserved'
description      'Installs/Configures jenkins-demo'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends          'jenkins', '~> 0.8.0'
depends          's3_file', '~> 1.0.0'
