FROM debian:jessie

RUN apt-get update -y
RUN apt-get install -y git
RUN apt-get install -y ruby
RUN apt-get install -y vim-nox
RUN apt-get install -y tcpdump
RUN apt-get install -y screen
RUN apt-get install -y ruby-dev
RUN apt-get install -y cmake
RUN apt-get install -y pkg-config
RUN apt-get install -y python-dev

RUN apt-get update \
  && apt-get install -y curl net-tools unzip python \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN apt-get update -y \
    && apt-get install -y python-pip
# pip install python-dateutil first to get most up to date version
RUN pip install python-dateutil
RUN apt-get install -y python-psycopg2
RUN apt-get install -y python-matplotlib
RUN apt-get install -y python-lxml
RUN apt-get install -y python-scipy

WORKDIR /home/dev
ENV HOME /home/dev
ADD vimrc /home/dev/.vimrc
ADD bash_profile /home/dev/.bash_profile
ADD gitconfig /home/dev/.gitconfig
ADD plushy_requirements.txt /home/dev/plushy_requirements.txt

# Run vim stuff
run git clone -q https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
run vim -c 'PluginInstall' -c 'qa!'
run cd ~/.vim/bundle/command-t/ruby/command-t \
    && ruby extconf.rb \
    && make

# JAVA
ENV JAVA_HOME /usr/jdk1.8.0_31
ENV PATH $PATH:$JAVA_HOME/bin
RUN curl -sL --retry 3 --insecure \
  --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
  "http://download.oracle.com/otn-pub/java/jdk/8u31-b13/server-jre-8u31-linux-x64.tar.gz" \
  | gunzip \
  | tar x -C /usr/ \
  && ln -s $JAVA_HOME /usr/java \
  && rm -rf $JAVA_HOME/man

# SPARK
ENV SPARK_VERSION 1.4.1
ENV HADOOP_VERSION 2.4
ENV SPARK_PACKAGE $SPARK_VERSION-bin-hadoop$HADOOP_VERSION
ENV SPARK_HOME /usr/spark-$SPARK_PACKAGE
ENV PATH $PATH:$SPARK_HOME/bin
RUN curl -sL --retry 3 \
  "http://mirrors.ibiblio.org/apache/spark/spark-$SPARK_VERSION/spark-$SPARK_PACKAGE.tgz" \
  | gunzip \
  | tar x -C /usr/ \
  && ln -s $SPARK_HOME /usr/spark

# HADOOP/S3
RUN curl -sL --retry 3 "http://central.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.6.0/hadoop-aws-2.6.0.jar" -o $SPARK_HOME/lib/hadoop-aws-2.6.0.jar \
 && curl -sL --retry 3 "http://central.maven.org/maven2/com/amazonaws/aws-java-sdk/1.7.14/aws-java-sdk-1.7.14.jar" -o $SPARK_HOME/lib/aws-java-sdk-1.7.14.jar \
 && curl -sL --retry 3 "http://central.maven.org/maven2/com/google/collections/google-collections/1.0/google-collections-1.0.jar" -o $SPARK_HOME/lib/google-collections-1.0.jar \
 && curl -sL --retry 3 "http://central.maven.org/maven2/joda-time/joda-time/2.8.2/joda-time-2.8.2.jar" -o $SPARK_HOME/lib/joda-time-2.8.2.jar


# Plushy Specific
RUN pip install -r /home/dev/plushy_requirements.txt
ENV PYTHONPATH /home/dev/plushy
