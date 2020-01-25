# Multi-architecture Build Demo Repository

This repository was created as a resource to demonstrate multi-architecture
buids for the 2020 IBM Fast Start series of internal and business partner
conferences.

The key asset of use in this repository is the set of Ansible playbooks and
roles in the ansible directory.  One files must be edited for these to be useful:

- `ansible/hosts` must be configured for your environment

- `ansible/roles/slave/vars/docker_logins.yml` should be configured with the
  docker environments to which you want the slaves to connect.

TODO:  The docker_logins should probably be a group_var, but I don't have the
energy to start a new cluster to test that.  Pull requests welcome :)
