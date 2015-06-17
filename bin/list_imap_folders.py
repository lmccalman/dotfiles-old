import click
import imaplib


def recursive_print(x):
    if type(x) is list:
        for k in x:
            recursive_print(k)
    else:
        print(x)

@click.command()
@click.argument('server')
@click.argument('username')
@click.option('--password', prompt=True, hide_input=True,
              confirmation_prompt=True)
def main(server, username, password):
    mail = imaplib.IMAP4_SSL(server)
    mail.login(username, password)
    status, folders = mail.list()
    recursive_print(folders)

if __name__ == "__main__":
    main()
