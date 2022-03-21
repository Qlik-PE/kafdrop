#!/bin/bash

echo "Starting Kafdrop"

# Set marathon ports to 0:0 to have marathon assign and pass random port
if [ "$PORT0" ]; then
    JMX_PORT=$PORT0;
fi

# Marathon passes "HOST" variable
if [ -z "$HOST" ]; then
    HOST=localhost;
fi

# Marathon passes memory limit
if [ "$MARATHON_APP_RESOURCE_MEM" ]; then
    HEAP_ARGS="-Xms${MARATHON_APP_RESOURCE_MEM%.*}m -Xmx${MARATHON_APP_RESOURCE_MEM%.*}m"
fi

if [ "$JMX_PORT" ]; then
    JMX_ARGS="-Dcom.sun.management.jmxremote \
    -Dcom.sun.management.jmxremote.port=${JMX_PORT} \
    -Dcom.sun.management.jmxremote.rmi.port=${JMX_PORT} \
    -Dcom.sun.management.jmxremote.local.only=false \
    -Dcom.sun.management.jmxremote.authenticate=false \
    -Dcom.sun.management.jmxremote.ssl=false \
    -Djava.rmi.server.hostname=$HOST"
fi

KAFKA_PROPERTIES_FILE=${KAFKA_PROPERTIES_FILE:-kafka.properties}
if [ "$KAFKA_PROPERTIES" != "" ]; then
  echo "Writing Kafka properties into $KAFKA_PROPERTIES_FILE"
  echo "$KAFKA_PROPERTIES" | base64 --decode --ignore-garbage > "$KAFKA_PROPERTIES_FILE"
else
  rm -f "$KAFKA_PROPERTIES_FILE"
fi

KAFKA_TRUSTSTORE_FILE=${KAFKA_TRUSTSTORE_FILE:-kafka.truststore.jks}
if [ "$KAFKA_TRUSTSTORE" != "" ]; then
  echo "Writing Kafka truststore into $KAFKA_TRUSTSTORE_FILE"
  echo "$KAFKA_TRUSTSTORE" | base64 --decode --ignore-garbage > "$KAFKA_TRUSTSTORE_FILE"
else
  rm -f "$KAFKA_TRUSTSTORE_FILE"
fi

KAFKA_KEYSTORE_FILE=${KAFKA_KEYSTORE_FILE:-kafka.keystore.jks}
if [ "$KAFKA_KEYSTORE" != "" ]; then
  echo "Writing Kafka keystore into $KAFKA_KEYSTORE_FILE"
  echo "$KAFKA_KEYSTORE" | base64 --decode --ignore-garbage > "$KAFKA_KEYSTORE_FILE"
else
  rm -f "$KAFKA_KEYSTORE_FILE" 
fi

username=${USERNAME:-admin}
password=${PASSWORD:-admin}
role=${PASSWORD:-USER}

ARGS="--add-opens=java.base/sun.nio.ch=ALL-UNNAMED -Xss256K \
     $JMX_ARGS \
     $HEAP_ARGS \
     $JVM_OPTS"

CMD_ARGS="$CMD_ARGS \
         --spring.security.user.name=$username \
         --spring.security.user.password=$password \
         --spring.security.user.roles=$role"

CMD="exec java $ARGS -jar /kafdrop*.jar ${CMD_ARGS}"
echo "exec java: $CMD"

${CMD}

