FROM circleci/php:7.1-node-browsers

# Set the home directory, it's not available in the build process
ENV HOME="/home/circleci"

# Make composer packages executable.
ENV PATH="${HOME}/.composer/vendor/bin:${PATH}"

# Install drush, prestissimo and coder.
RUN composer global require drush/drush-launcher hirak/prestissimo drupal/coder
RUN phpcs --config-set installed_paths ~/.composer/vendor/drupal/coder/coder_sniffer

# Add the kontena CLI.
RUN wget -O /tmp/kontena.deb https://gh-releases.kontena.io/kontena/kontena/deb/latest
RUN sudo dpkg -i /tmp/kontena.deb
