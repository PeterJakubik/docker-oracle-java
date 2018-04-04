FROM arm32v7/debian:stretch-slim

ENV JAVADIR /usr/src/java

RUN 	apt-get update; \
	fetchDeps='ca-certificates wget'; \
	apt-get install -y --no-install-recommends $fetchDeps; \
	mkdir -p "$JAVADIR"; \
	wget -O java.tar.gz --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-arm32-vfp-hflt.tar.gz; \
	tar -xzf java.tar.gz -C "$JAVADIR" --strip-components=1; \
	rm java.tar.gz; \
	apt-get purge -y --auto-remove $fetchDeps; \
	rm -rf /var/lib/apt/lists/*; \
	ln -s "$JAVADIR" /opt/jdk

ENV JAVA_HOME /opt/jdk
ENV PATH ${PATH}:${JAVA_HOME}/bin
ENV JAVA_VERSION 8u161

CMD ["java"]
