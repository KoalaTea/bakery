from onepassword.client import Client
from onepassword import Item
import asyncio
import os

def main() -> None:
    token = None
    with open("/mnt/c/Users/Ryan Whittier/.credentials/automation.txt") as credentials:
        for line in credentials.read():
            if line.starts_with("OP_SERVICE_ACCOUNT_TOKEN="):
                token=line[len("OP_SERVICE_ACCOUNT_TOKEN="):]
    if not token:
        print("No token found")
        exit()

    os.system("OP_SERVICE_ACCOUNT_TOKEN={token} op inject -i ./ansible_control_files/proxmox_inventory_without_creds.ini -o ansible_control_files/proxmox_creds_inventory.ini")

    # loop = asyncio.get_event_loop()
    # loop.run_until_complete(async_main(token))

async def async_main(token: str) -> None:
    client = await Client.authenticate(auth=token, integration_name="Home Automation", integration_version="v0.0.1")
    await generate_password(client)

async def generate_password(client: Client) -> None:
    # Create an Item and add it to your vault.
    to_create = Item(
        id="",
        title="LXCDefaultRoot",
        category="Login",
        vault_id="q73bqltug6xoegr3wkk2zkenoq",
        fields=[
            ItemField(
                id="username",
                title="username",
                field_type="Text",
                section_id=None,
                value="root",
            ),
            ItemField(
                id="password",
                title="password",
                field_type="Concealed",
                section_id=None,
                value="jeff",
            ),
        ],
        sections=[ItemSection(id="", title="")],
    )
    created_item = await client.items.create(to_create)

if __name__ == "__main__":
    main()