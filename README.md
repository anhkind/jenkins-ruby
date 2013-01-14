# jenkins-ruby [![Build Status](https://travis-ci.org/anhkind/jenkins-ruby.png)](https://travis-ci.org/anhkind/jenkins-ruby) [![Dependency Status](https://gemnasium.com/anhkind/jenkins-ruby.png)](https://gemnasium.com/anhkind/jenkins-ruby)

***jenkins-ruby*** is a suite of Ruby classes that help to connect and automate different tasks on Jenkins CI through its Remote Access API.

## Setup

Setup your Jenkins as following:

```
Jenkins.configure(options)
```

where options is a `Hash` with following keys:

```
options = (
  	host:     'jenkins_host', # required
  	port:     8080,           # optional, default is 8080
  	username: 'username',     # required
  	password: 'password'      # required
)
```

Configuration from .yml file will be added soon!

## Usage
After configuring Jenkin, a job can be created as following:

```
job = Jenkins::Job.new('job_name')
job #=> #<Jenkins::Job:0x007fac429493f0>
```

If you want to search for a job:

```
job = Jenkins::Job.find('existing_job')
job #=> #<Jenkins::Job:0x007fac41d0e630>

job = Jenkins::Job.find('non_existing_job')
job #=> nil
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
