# TODO

- [x] Prepare docker image with Apache2 + php7.4 and piwigo 13.8.0
  - [x] Reduce number of layers (RUN/COPY calls)
  - [ ] Use staged build to extract ZIP image and do not install curl into primary image
  - [ ] Make Apache to log to STDOUT to get logs in K8s
- [x] Prepare helm chart to install deployment with that image
  - [x] Define ingress
    - [x] HTTP only
    - [x] HTTPS with some selfsign cert from K8s
    - [x] HTTPS with provided cert from Semik CA
    - [x] HTTPS with Let's Encrypt
  - [ ] Mount there a config {{ piwigo_root }}/piwigo/local/config/database.inc.php (to get rid of default login page)
    - [ ] Provide some initial config??
  - [x] Provide it with database and let it communicate via UNIX SOCKET
- [ ] Provide it with folder with photos

