# Ansible build to configure a Jenkins repository

The key asset of use in this repository is the set of Ansible playbooks and
roles in the ansible directory.  One files must be edited for these to be useful:

-   `hosts` must be configured for your environment (see `hosts.example`)

-   `roles/slave/vars/docker_logins.yml` should be configured with the
    docker environments to which you want the slaves to connect.
    (see `roles/slave/vars/docker_logins.example.yml`)

TODO:  The docker_logins should probably be a group_var, but I don't have the
energy to start a new cluster to test that.  Pull requests welcome :)

TODO:  Investigate the Jenkins API to further automate configuration of the
cluster, including addition and removal of nodes.  I may end up creating an
ansible module to handle Jenkins stuff, though I have difficulty believing
there is not one already.
