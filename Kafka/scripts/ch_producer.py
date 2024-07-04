import json
from time import sleep
from dataclasses import dataclass
from datetime import datetime
from confluent_kafka import Producer

from ch_client import client

@dataclass
class ShkOnPlace:
    place_cod: int
    dt: datetime
    shk_id: int

    def to_json(self):
        return json.dumps(
            {
                'place_cod': self.place_cod,
                'dt': self.dt.strftime('%Y-%m-%dT%H:%M:%S'),
                'shk_id': self.shk_id
            }
        )

config = {
    'bootstrap.servers': 'localhost:9093',  # адрес Kafka сервера
    'client.id': 'simple-producer',
    'sasl.mechanism':'PLAIN',
    'security.protocol': 'SASL_PLAINTEXT',
    'sasl.username': 'admin',
    'sasl.password': 'admin-secret'
}

producer = Producer(**config)


def delivery_report(err, msg):
    if err is not None:
        print(f"Message delivery failed: {err}")
    else:
        print(f"Message delivered to {msg.topic()} [{msg.partition()}] at offset {msg.offset()}")


def send_message(data):
    try:
        # Асинхронная отправка сообщения
        producer.produce('ShkOnPlace', data.encode('utf-8'), callback=delivery_report)
        producer.poll(0)  # Поллинг для обработки обратных вызовов
    except BufferError:
        print(f"Local producer queue is full ({len(producer)} messages awaiting delivery): try again")


def main():
    data = client.execute('select place_cod, dt, shk_id from SHKonPlace where dt >= today() limit 100')

    for i in data:
        shkonplace = ShkOnPlace(*i)
        send_message(shkonplace.to_json())
        sleep(5)

    producer.flush()


if __name__ == '__main__':
    main()