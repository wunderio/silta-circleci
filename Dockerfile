FROM circleci/php:7.1-cli-node

# Make composer packages executable.
ENV PATH="/home/circleci/.composer/vendor/bin:${PATH}"

# Install drush, prestissimo and coder.
RUN composer global require drush/drush-launcher hirak/prestissimo drupal/coder \
  && phpcs --config-set installed_paths ~/.composer/vendor/drupal/coder/coder_sniffer \
  && composer clearcache

# Install vim based on popular demand.
RUN sudo apt-get install vim

# Add gcloud CLI
RUN curl -sSL https://sdk.cloud.google.com | bash \
  && rm -r /home/circleci/google-cloud-sdk/.install/.backup/
ENV PATH $PATH:/home/circleci/google-cloud-sdk/bin/

# Add kubectl
RUN yes | gcloud components install kubectl

# Install Helm
ENV HELM_VERSION v2.10.0
ENV FILENAME helm-${HELM_VERSION}-linux-amd64.tar.gz
ENV HELM_URL https://storage.googleapis.com/kubernetes-helm/${FILENAME}

RUN curl -o /tmp/$FILENAME ${HELM_URL} \
  && tar -zxvf /tmp/${FILENAME} -C /tmp \
  && rm /tmp/${FILENAME} \
  && sudo mv /tmp/linux-amd64/helm /bin/helm \
  && helm init --client-only \
  && helm repo remove local

# Add custom php config. Increase memory to 256M
COPY conf/php/memory.ini /usr/local/etc/php/conf.d/memory.ini

