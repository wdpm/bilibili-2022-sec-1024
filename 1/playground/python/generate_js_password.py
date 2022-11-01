import json

with open('../node/password/top19576-only-8-digits.txt', 'r') as fp:
    lines = fp.readlines()
    password_array = [line.strip() for line in lines]

    with open('js-password.js', 'w') as fp2:
        fp2.write(json.dumps(password_array))
