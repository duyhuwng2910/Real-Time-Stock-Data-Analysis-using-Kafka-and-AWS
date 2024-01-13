# Connect to EC2 machine
ssh -i "real-time-stock-data-analysis.pem" ubuntu@ec2-13-229-76-225.ap-southeast-1.compute.amazonaws.com

# Install Kafka package
wget https://downloads.apache.org/kafka/3.6.1/kafka_2.13-3.6.1.tgz

tar -xvf kafka_2.13-3.6.1.tgz

# Install Java
sudo yum install java-1.8.0-openjdk

sudo apt install openjdk-8-jdk

# Start Zookeeper
cd kafka_2.13-3.6.1
bin/zookeeper-server-start.sh config/zookeeper.properties

# Start Kafka server
# Duplicate the session & enter in a new console --
export KAFKA_HEAP_OPTS="-Xmx256M -Xms128M"
cd kafka_2.13-3.6.1
bin/kafka-server-start.sh config/server.properties

# It is pointing to private server , change server.properties so that it can run in public IP 
# To do this , you can follow any of the 2 approaches shared belwo --
# Do a "sudo nano config/server.properties" - change ADVERTISED_LISTENERS to public ip of the EC2 instance
sudo nano config/server.properties

# Create the topic:
# Duplicate the session & enter in a new console --
cd kafka_2.13-3.6.1
bin/kafka-topics.sh --create --topic demo --bootstrap-server 13.229.76.225:9092 --replication-factor 1 --partitions 1

# See the details
cd kafka_2.13-3.6.1
bin/kafka-topics.sh --describe --topic demo --bootstrap-server 13.229.76.225:9092

# Start Producer to wrtie events:
cd kafka_2.13-3.6.1
bin/kafka-console-producer.sh --topic demo --bootstrap-server 13.229.76.225:9092

# Start Consumer to read events:
cd kafka_2.13-3.6.1
bin/kafka-console-consumer.sh --topic demo --bootstrap-server 13.229.76.225:9092