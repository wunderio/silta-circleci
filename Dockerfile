FROM circleci/php:7.1-cli-node

# Helm version
ENV HELM_VERSION v2.9.1

# Make composer packages executable.
ENV PATH="/home/circleci/.composer/vendor/bin:${PATH}"

# Install drush, prestissimo and coder.
RUN composer global require drush/drush-launcher hirak/prestissimo drupal/coder && phpcs --config-set installed_paths ~/.composer/vendor/drupal/coder/coder_sniffer && composer clearcache

# Add gcloud CLI
RUN curl -sSL https://sdk.cloud.google.com | bash
ENV PATH $PATH:/home/circleci/google-cloud-sdk/bin/

# Add kubectl
RUN yes | gcloud components install kubectl

# Install Helm
ENV FILENAME helm-${HELM_VERSION}-linux-amd64.tar.gz
ENV HELM_URL https://storage.googleapis.com/kubernetes-helm/${FILENAME}

RUN curl -o /tmp/$FILENAME ${HELM_URL} \
  && tar -zxvf /tmp/${FILENAME} -C /tmp \
  && sudo mv /tmp/linux-amd64/helm /bin/helm 

# Helm plugins require git
# helm-diff requires bash, curl
# RUN sudo apt-get install git bash

# Install Helm plugins
#RUN helm init --client-only
# Plugin is downloaded to /tmp, which must exist
#RUN helm plugin install https://github.com/viglesiasce/helm-gcs.git
#RUN helm plugin install https://github.com/databus23/helm-diff
#RUN sudo rm -rf /tmp

# Add custom php config. Increase memory to 256M
COPY conf/php/memory.ini /usr/local/etc/php/conf.d/memory.ini

# Add helper command to define environment variables.
COPY generate-kontena-config /usr/bin
