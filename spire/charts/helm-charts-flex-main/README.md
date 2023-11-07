<!-- vim: filetype=markdown colorcolumn=80 softtabstop=4 shiftwidth=4 tabstop=4 expandtab:
-->

<img src="spire-helm.svg" align="right" style="width: 30%; height: auto;" />

> **Note**: The helm charts in this repo are beta releases. We encourage you to try
> them and contribute. The API may change as we move towards a production ready release.

# helm-charts-flex

[![Apache 2.0 License](https://img.shields.io/github/license/spiffe/helm-charts)](https://opensource.org/licenses/Apache-2.0)
[![Development Phase](https://github.com/spiffe/spiffe/blob/main/.img/maturity/dev.svg)](https://github.com/spiffe/spiffe/blob/main/MATURITY.md#development)
[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/spiffe)](https://artifacthub.io/packages/search?repo=spiffe)

These Helm Charts provide the ability to quickly deploy SPIRE in both tierd
and standalone configuration, managing different clusters in either the same
or different namespaces.

## Table of Contents

- [Installation](#installation)
- [Configuration](#configuration)
- [Reconfiguration](#reonfiguration)
- [Upgrades](#upgrades)
- [License](#license)
- [Contributing](#contributing)

## Installation

Each installation operates under a trust domain.  You must specify your trust
domain upon installation.

There are two types of installation, standalone and tiered.  If just starting,
use the standalone installation, which has a single cluster managing your
trust domain.  Tiered installation is useful when you have multiple clusters
managing your trust domain, one cluster per failure domain and one cluster
coordinating the other clusters.

### Standalone Installation

To install a cluster named "spire-demo" with a trust domain of "demo.trust.domain"

```bash
$ helm install spire-demo spire-flex-0.1.0.tgz --set trustdomain=demo.company.com
``` 

or the preferred approach of putting the values in a values.yaml file

```bash
$ helm install spire-demo spire-flex-0.1.0.tgz --file values.yaml
```

We recommend that you replace the values "spire-demo" and "demo.trust.domain"
with values specific to your environment.

For details of the configuration items, see [Configuration](#configuration).

### Tiered Installation

To install a tiered cluster setup, one must install one coordnating "root" cluster
and one or more "nested" clusters.

```bash
$ helm install spire-demo-root spire-flex-0.1.0.tgz --set trustdomain=demo.company.com --set type=root
$ helm install spire-demo-nested1 spire-flex-0.1.0.tgz --set trustdomain=demo.company.com --set type=nested
$ helm install spire-demo-nested2 spire-flex-0.1.0.tgz --set trustdomain=demo.company.com --set type=nested
``` 

or the preferred approach of putting the values in a values.yaml file

```bash
$ helm install spire-demo-root spire-flex-0.1.0.tgz --file spire-root.yaml
$ helm install spire-demo-nested1 spire-flex-0.1.0.tgz --file spire-nested1.yaml
$ helm install spire-demo-nested2 spire-flex-0.1.0.tgz --file spire-nested2.yaml
```

We recommend that you replace the values "spire-demo-root", "spire-demo-nested1",
"spire-demo-nested2", and "demo.trust.domain" with values specific to your environment.

For details of the configuration items, see [Configuration](#configuration).

## Configuration

While options can be passed on the command line, the typical deployment uses
a values.yaml file.

Details of how to perform specific common configuration tasks are part of the
[user manual](https://github.com/spiffe/helm-charts-flex/blob/main/spire-flex/CONFIGURATION.md).

## Reconfiguration

To change values in an already deployed cluster, one uses the helm upgrade
command with the new values.

```bash
$ helm upgrade spire-demo spire-flex-0.1.0.tgz --set trustdomain=dev.company.com
```

or the preferred approach of putting the values in a values.yaml file

```bash
$ helm upgrade spire-demo spire-flex-0.1.0.tgz --file values.yaml
```

after the values.yaml file has been updated.

We recommend keeping the values.yaml file under source code control.

## Upgrades

To upgrade the deployed spire cluster from release spire-flex-0.1.0 to release       
spire-flex-0.2.0                                                                     
                                                                                
``` bash                                                                        
$ helm upgrade spire-demo spire-flex-0.2.0.tgz --reuse-values                        
```                                                                             
                                                                                
or if you want to pass explicit values to the chart                             
                                                                                
```bash                                                                         
$ helm upgrade spire-demo spire-flex-0.2.0.tgz --file values.yaml                    
```                                                                             
                                                                                
Upgrades are supported from any minor version to the next minor version.  Upgrades
are supported from any major version to the next major version's initial release.                                                                        
                                                                                
In the event a new value must be set or an old value removed, the upgrade will fail with      
a message on what value must be adjusted.  Due to Helm's output, this might only
report one needed change at a time. 

## License

This Helm Chart, along with all examples provided by this project, are under the
[Apache Public License, Version 2.0](https://opensource.org/licenses/Apache-2.0)

## Contributing

Contributions are welcome.  Non-trivial contributions, meaning those that require
an explanation or justification for thier adoption, require an Issue or Feature
Request to be opened, allowing a place for the discussion and acceptance of the
proposed change(s).

Contributions are needed in many areas.  In order of need, these include:

- Documentation
- Testing
- Development
- Maintainership
- Design

Other unmentioned areas of contributorship may be beneficial.  Reach out to
the maintainers team in chat or submit an Issue / Feature Request to have the
contirbution considered.

