FROM docker.io/library/openjdk:11
#FROM registry.mascj.com/openjdk:8-jre

# slave 默认以root用户运行，但jenkins主服务的运行用户是jenkins，这就造成对共享目录的操作权限不一致
RUN mkdir /var/jenkins_agent && chmod 777 /var/jenkins_agent
WORKDIR /var/jenkins_agent

ADD src/agent.jar agent.jar
# 在slave节点添加 jenkins/jenkins的用户/用户组
ADD src/group /etc/group
ADD src/passwd /etc/passwd

USER jenkins

# 指定这3个参数，注册到jenkins主服务
ENV JNLP_URL="http://jenkins_slave:8080"
ENV SECRET="secret"
ENV WORK_DIR="/var/jenkins_agent"

CMD java -jar agent.jar -jnlpUrl $JNLP_URL -secret $SECRET -workDir $WORK_DIR