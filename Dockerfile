FROM circleci/php:7.1-node-browsers

# Make composer packages executable.
ENV PATH="/home/circleci/.composer/vendor/bin:${PATH}"

# Install drush, prestissimo and coder.
RUN composer global require drush/drush-launcher hirak/prestissimo drupal/coder && phpcs --config-set installed_paths ~/.composer/vendor/drupal/coder/coder_sniffer

# Add the kontena CLI.
RUN wget -O /tmp/kontena.deb https://github.com/kontena/kontena/releases/download/v1.5.0/kontena-cli_1.5.0_amd64.deb && sudo dpkg -i /tmp/kontena.deb && rm /tmp/kontena.deb
