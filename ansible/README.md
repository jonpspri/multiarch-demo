# Ansible build to configure a Jenkins repository

The key asset of use in this repository is the set of Ansible playbooks and
roles in the ansible directory.  One files must be edited for these to be useful:

-   `hosts.yml` must be configured for your environment (see `hosts.yml.example`)

TODO:  Investigate the Jenkins API to further automate configuration of the
cluster, including addition and removal of nodes.  I may end up creating an
ansible module to handle Jenkins stuff, though I have difficulty believing
there is not one already.
