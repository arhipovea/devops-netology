import hvac
import os


VAULT_URL = os.environ["VAULT_URL"]
VAULT_TOKEN = os.environ["VAULT_TOKEN"]

client = hvac.Client(url=VAULT_URL, token=VAULT_TOKEN)
client.is_authenticated()

# Пишем секрет
client.secrets.kv.v2.create_or_update_secret(path="hvac", secret=dict(netology22="Big secret!!! Second exercise v2"))

# Читаем секрет
secret_response = client.secrets.kv.v2.read_secret_version(path="hvac")

with open("prog_result", "w") as f:
    f.write(f"Secret keys: {secret_response['data']['data'].keys()}")

while True:
    pass