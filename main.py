import questionary


def main():
    res = questionary.select(
        "What do you want to do?",
        choices=[
            'Setup auto-update script',
            'Setup correct timezone',
            'Quit'
        ]).ask()  # returns value of selection
    print(res)

if __name__ == "__main__":
    main()
