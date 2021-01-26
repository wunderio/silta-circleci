# Silta CircleCI 

## CircleCI ORB

A collection of CircleCI tools used by the Silta hosting infrastructure.

## CircleCI builder image

### Image builds have been moved to https://github.com/wunderio/silta-images

A docker image used circleCI, based on `circleci/php:7.3-cli-node` with the following additions:

- Composer configured correctly
- Drush-launcher, prestissimo and coder pre-installed
- Vim, useful for debugging
- The google cloud cli, kubernetes and helm
