class Blog:
    def __init__(self):
        self.users = []
        self.current_user = None

    def signup(self):
        username = input('Enter a username: ')
        password = input('Enter a password: ')
        new_user = User(username, password)
        self.users.append(new_user)

    def login(self):
        username = input('What is your username? ')
        password = input('What is your password? ')
        for user in self.users:
            if user.username == username and user.password == password:
                self.current_user = user
                break
        print(f"{self.current_user} has logged in")

class User:
    def __init__(self, username, password):
        self.username = username
        self.password = password

    def __str__(self):
        return self.username
    

def main():
    b = Blog()
    while True:
        if b.current_user is None:
            print('1. Sign Up\n2. Log In\n3. Quit')
            to_do = input('Which option: ')
            if to_do == '3':
                break
            elif to_do == '1':
                b.signup()
            elif to_do == '2':
                b.login()
        else:
            print('1. Log Out')
            to_do = input('Which option: ')
            print(f"Logging {b.current_user} out")
            b.current_user = None

main()
