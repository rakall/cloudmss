# Change Log

Updated change log

## [v.1.0.13] - 2021-02-26
## Changed
- Backend Load Balancer Session persistence is based on Client IP and protocol 
- Remove "Interpolation-only expressions are deprecated" warnings
- Custom data is updated using python3 
- Auto-scaling variables are moved to locals
- New autoscaling rule based on healthy instances using load balancer health probe

## [v.1.0.12] - 2020-10-20
## Changed
- Added ip addresses as outputs [Compatible with v1.0.9 and v1.0.8]

## [v1.0.11] - 2020-10-20
## Changed
- Added ip addresses as outputs [Compatible with v1.0.10 and v1.0.7]

## [v1.0.10] - 2020-10-20
## Changed
- enable_ip_forwarding = false
- domain_name_label = "${local.nva_name}name"

## [v1.0.09] - 2020-10-20
## Changed
- Update north firewall [compatible with v1.0.8]"

## [v1.0.08] - 2020-10-06
## Changed
- domain name is ${local.nva_name}name

## [v1.0.07] - 2020-10-02
## Changed
- add prefix to public ips

## [v1.0.06] - 2020-08-25
## Changed
- enable_ip_forwarding = false
- domain_name_label = local.nva_name

## [v1.0.04] - 2020-03-21
## Changed
- Added List map for lba rules



## **1.0.2**
NEW FEATURES:
* Updated NVA Chekpoint tags
* Using NVAs modules

## **1.0.1**
NEW FEATURES:
* Added additional User Defined Routes (udr) per Firewall Entity to manage backend Routes
* Tfstate file is now saved per entity in platform storage account

## **1.0.0**

NEW FEATURES:
* Deploy the following environments:
##### North Internet Corporate Firewall Entity
- 1 Resource Group (rsg)
- 2 Subnets (snt)
  - Frontend Subnet
  - Backend Subnet 
- 1 Network Security Group (nsg)
- 1 User Defined Routes (udr)
- 2 Load Balancers (lba)
  - Frontend Load Balancer (external load balancer)
  - Backend Load Balancer (internal load balancer)
- 1 Public IP (pip)

##### South Production Corporate Firewall Entity
- 1 Resource Group (rsg)
- 2 Subnets (snt)
  - Frontend Subnet
  - Backend Subnet 
- 1 Network Security Group (nsg)
- 1 User Defined Routes (udr)
- 2 Load Balancers (lba)
  - Frontend Load Balancer (external load balancer)
  - Backend Load Balancer (internal load balancer)


##### South no Production Corporate Firewall Entity
- 1 Resource Group (rsg)
- 2 Subnets (snt)
  - Frontend Subnet
  - Backend Subnet 
- 1 Network Security Group (nsg)
- 1 User Defined Routes (udr)
- 2 Load Balancers (lba)
  - Frontend Load Balancer (external load balancer)
  - Backend Load Balancer (internal load balancer)