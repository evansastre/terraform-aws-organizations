## Request Service Quota increase

### Prerequisite

- Install the python libraries

```
pip3 install -r requirements.txt
```

- Prepare the quotas.yml
```
- name: "All Standard (A, C, D, H, I, M, R, T, Z) Spot Instance Requests"
  service_code: "ec2"
  quota_code:  "L-34B43A08"
  desired_value: 64

- name: "Running On-Demand Standard (A, C, D, H, I, M, R, T, Z) instances"
  service_code: "ec2"
  quota_code:  "L-1216C47A"
  desired_value: 64
```

- Need the service-link role to be created in the aws account
```
AWSServiceRoleForServiceQuotas
```

### How to Run

Only `enterpriseAdmin` and `devopsPriv` roles are allowed to request quotas increase, you need to assume the right role and get the AK/SK/Token to run the script.

```
python request-service-quotas.py quotas.yml
```