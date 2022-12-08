# AWS Organization Terraform Repo

There are 4 modules in this repo:
1. cloudtrail : which enables the cloudtail for the whole organizaion.
2. cf-stackset-identity provider : this one creates enterprise identity provider which allows us to log in from enterprise Portal. Meanwhile, it creates enterpriseAdmin role in each sub-account as well.
3. policy : create SCP  and tag policy and attach it to a specific OU if required.
4. iam-roles: create the iam roles in a specific OU from the provided json files. 

