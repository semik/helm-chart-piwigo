# Helm Chart for Piwigo

I'm trying to create Helm Chart and Docker image for [Piwigo](https://piwigo.org/) image galery. At this moment, and untill this note get deleted I do not run this anywhere in production. Purpose of this project is to learn Docker, Kubernetes, Hell and any other stuff around.

# Declaring Let's Encrypt K8s Cluster Issuer

```yaml
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
spec:
  acme:
    # The ACME server URL
    server: https://acme-v02.api.letsencrypt.org/directory
    # Email address used for ACME registration
    email: email@example.com
    # Name of a secret used to store the ACME account private key
    privateKeySecretRef:
      name: letsencrypt-prod
    # Enable the HTTP-01 challenge provider
    solvers:
      - http01:
          ingress:
            ingressClassName: nginx
```