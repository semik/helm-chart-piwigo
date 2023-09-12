# TODO

- [x] Prepare docker image with Apache2 + php7.4 and piwigo 13.8.0
  - [x] Reduce number of layers (RUN/COPY calls)
  - [ ] Use staged build to extract ZIP image and do not install curl into primary image
- [x] Prepare helm chart to install deployment with that image
  - [ ] Define ingress
    - [ ] HTTP only
    - [ ] HTTPS with some selfsign cert from K8s
    - [ ] HTTPS with provided cert from Semik CA
    - [ ] HTTPS with Let's Encrypt
  - [ ] Mount there a config {{ piwigo_root }}/piwigo/local/config/database.inc.php (to get rid of default login page)
  - [ ] Provide it with database:
    - [ ] as another pod
    - [ ] even better as sidecar and let it communicate via UNIX SOCKET
- [ ] Provide it with folder with photos

