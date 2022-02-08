# daveloper_deployments
for terraform configurations for in my Azure personal subscription

##### daveloper_common_resources
1. Has resources you will use with other configurations, i.e. key vault and remote state storage.
2. Has a bit of a chicken/egg thing: storage was created and then subsequently used for state in later applies. 
