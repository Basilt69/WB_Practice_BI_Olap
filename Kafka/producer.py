from confluent_kafka import Producer
import numpy as np
import pandas as pd

from json import JSONEncoder
import json

config = {
    "bootstrap.servers": "localhost:9093",  # адрес Kafka сервера
    "client.id": "simple-producer",
    "sasl.mechanism": "PLAIN",
    "security.protocol": "SASL_PLAINTEXT",
    "sasl.username": "admin",
    "sasl.password": "admin-secret",
}

producer = Producer(**config)


def data():

    from clickhouse_driver import Client

    with open(f"./secrets/ch_db.json") as json_file:
        data = json.load(json_file)

    client = Client(
        data["server"][0]["host"],
        user=data["server"][0]["user"],
        password=data["server"][0]["password"],
        verify=False,
        database="",
        settings={"numpy_columns": True, "use_numpy": True},
        compression=True,
    )
    res = client.execute(
        "select place_cod, shk_id, dt from SHKonPlace where dt >= today() limit 100"
    )

    return res


def delivery_report(err, msg):
    if err is not None:
        print(f"Message delivery failed: {err}")
    else:
        print(
            f"Message delivered to {msg.topic()} [{msg.partition()}] at offset {msg.offset()}"
        )


def send_message(data):
    try:
        # Асинхронная отправка сообщения
        producer.produce("ShkOnPlace", data.encode("utf-8"), callback=delivery_report)
        producer.poll(0)  # Поллинг для обработки обратных вызовов
    except BufferError:
        print(
            f"Local producer queue is full ({len(producer)} messages awaiting delivery): try again"
        )


if __name__ == "__main__":
    res = data()
    for i in range(len(res)):
        result = res[i]
        pp = pd.DataFrame([result], columns=["place_cod", "dt", "shk_id"])
        send_message(pp.to_json(orient="records")[1:-1])
    producer.flush()