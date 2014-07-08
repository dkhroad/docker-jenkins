FROM dkhroad/base:0.2
MAINTAINER Devinder Khroad "dkhroad@gmail.com

RUN curl -q  http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -
RUN echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list
RUN apt-get update
RUN apt-get -y install openjdk-7-jre-headless
RUN apt-get -y install jenkins
RUN apt-get -y clean
RUN rm -rf /var/cache/jenkins/war
RUN mkdir /var/cache/jenkins/war
RUN chown jenkins /var/cache/jenkins/war
ADD scripts/jenkins /usr/local/bin/jenkins
RUN chmod a+x /usr/local/bin/jenkins

# Install jenkins plugins
ADD scripts /tmp/scripts

# Setup jenkins jobs
#sudo -u jenkins cp -R /vagrant/jobs/* /var/lib/jenkins/jobs/

CMD ["/sbin/my_init","--","/usr/local/bin/jenkins"]
EXPOSE 8080
EXPOSE 9090 
EXPOSE 22

VOLUME ["/var/lib/jenkins", "/var/log/jenkins"]

RUN /tmp/scripts/plugins.sh 
COPY config.xml /var/lib/jenkins/config.xml

