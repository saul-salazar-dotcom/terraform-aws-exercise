# Terraform Exercise

## Exercise 1.

### Deployment

```sh
# first setup AWS credentials
$ export AWS_ACCESS_KEY_ID="[ACCESS_KEY]"
$ export AWS_SECRET_ACCESS_KEY="[SECRET_KEY]"

# then setup terraform
$ terraform init

# check the plan before doing anything
$ terraform plan

# use apply to start terraform or destroy to delete the already created infrastructure
$ terraform apply
$ terraform destroy
```

### How can you improve the architecture to be more reliable?

- I already added multiple subnets and machines for more reliability
- Add more options to the database module like backups
- Add app logic to the compute module

## Exercise 2

We have a Java application running on a Kubernetes cluster, one day dies and cannot start again.  
We have a lot of complaining users...

### Logs
`Warning FailedScheduling 3m (x1443 over 13m) default-scheduler 0/24 nodes are available: 18 node(s) didn't match node selector, 24 Insufficient cpu.`

### a. What would you do to restore the service?

- Investigate root problem
    - Get available resources from nodes using `kubectl describe nodes`
    - Confirm if resource limits in manifests do not exceed the available resources in the cluster
        - If exceeds, then we have a few options
            - Add more CPU resources to your cluster
                - Update your node pool with either more CPU or more nodes
            - Remove unused pods
        - If not exceeded
            - Inspect the pods and calculate the CPU requests to validate limits.
                - You can adjust the "CPU requests" in your containers yml.
                - By default its 100m or 0.1 CPU per container
                - Also dont forget to sum the other workload like kube-dns
        - If still failing
            - Explain the problem to a non technical person, sometimes when you talk the problem in another way you find the fix.
            - Research using google, check first page, if not good results then add the filter "site:stackoverflow"
            - Ask for help to technical people inside your team/area with expertise on kubernetes
        - If still failing after trying all options
            - If we dont have another apps on the cluster and if its the last choice, we can try restarting the cluster to see if Kubernetes can read the real available resources.

### b. What would you do to avoid this happen again?

Implement monitoring to view consumer spikes and also add alerts to be notified about problems before the user does
