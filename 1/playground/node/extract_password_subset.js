const fs = require('fs');

const passwordFile = fs.readFileSync('./password/top19576.txt', 'utf-8');

// for loop password line by line and try to log in
for (const line of passwordFile.split(/\r?\n/)) {
    // console.log("Now password is: " + line)
    if (line.length === 8) {
        fs.appendFileSync('./password/top19576-only-8-digits.txt', `${line}\r\n`);
    }
}
