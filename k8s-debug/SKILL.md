# K8s Debugging Skill

1. Get pod status: `kubectl get pods -n <namespace>`
2. Describe failing pods: `kubectl describe pod <name> -n <namespace>`
3. Check events: `kubectl get events -n <namespace> --sort-by=.lastTimestamp`
4. Check IAM/Workload Identity: verify GSA->KSA bindings
5. Check resource requests vs node capacity
6. Report findings with EXACT values from output
