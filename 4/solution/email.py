import base64

mid = "{YOUR_BILIBILI_MID}"
email = "{YOUR_EMAIL}"

# 51351333
# ZXZhbnBhbjIwMThAZ21haWwuY29t

message_bytes = email.encode('ascii')
base64_bytes = base64.b64encode(message_bytes)
base64_message = base64_bytes.decode('ascii')

print(base64_message)
