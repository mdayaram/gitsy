Gitsy
=====

Gitsy is a set of Ruby scripts used to manager bare git repositories in
a central server.

Example `authorized_keys` entry:

```
command="/path/to/gitsy/bin/gitsy noj",no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCy5sXxzKcqpKa823Y/L49KzNJ6RZxjuh5iGd2Bul0Mp934AE/Z1TkaoWfUorVg3m8YV0tzKPrF+W64/lBYGPc7O3MqORnAjhQIBcwKilJkmqeThe+DlRtD1yCLSvItweEaD72gtbnkPMOLLek2weJ9rqyl0U5kmIhMyhd77ZmTwLK5y+1IO/3LKX4en4d2pmotTOFuBSvYZYgVpaR6zC1S55IxvlQ6QpHNjOXxAsJXPZtM6MBNZx/jFBhRwq4JodBbL854iA5UPIHdHAGpo2bPqZTHv2vTKG34PPQu5cHSE+icMY0PPdJRSd+eaMp7XmudkXIlyDipRiRvJCBUiLTv noj@host
```

### TODO

1. Add documentation/comments in config.yml that explains different configurations.
2. Add some more examples for fun things, like adding a key to authorized_hosts,
	 check if a user has read or write access to a specific repo, etc..
3. Setup a configuration for queuing, aka, allow maybe only 10 git request at
	 a time, and queue the rests.
4. Figure out how to fail a commit on a push using pre-receive and document.
