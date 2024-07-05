# Kafka
## 1. docker compose kafka with sasl
`docker-compose up -d`  
`docker compose ps`

![Intermediate results](https://github.com/Basilt69/WB_Practice_BI_Olap/blob/master/Kafka/images/img.png)

![Offset Explorer is connected](https://github.com/Basilt69/WB_Practice_BI_Olap/blob/master/Kafka/images/img_1.png)

## 2. Creation of topic with Offset Explorer

![New test topic](https://github.com/Basilt69/WB_Practice_BI_Olap/blob/master/Kafka/images/img_2.png)

## 3. Insert of data into Kafka topic
`cd scripts`  
`python producer.py`

![Results of insert](https://github.com/Basilt69/WB_Practice_BI_Olap/blob/master/Kafka/images/img_3.png)

## 4. Read from Kafka topic using python script
`python consumer.py`  

![Reading results](https://github.com/Basilt69/WB_Practice_BI_Olap/blob/master/Kafka/images/img_4.png)
