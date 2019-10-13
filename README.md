# encryptcompressmydrive7
 Drive compression and encryption system based on 7-zip.



**With many thanks to Igor Pavlov and the 7-Zip project. [https://www.7-zip.org](https://www.7-zip.org)**

## Questions that could occur

### What does encryptcompressmydrive7 do?

encryptcompressmydrive7 basically does what it says it does:  Drive compression and encryption.

But in detail, the system creates a `.ecmd7`-file with a file name based on the username of the user. Because `.ecmd7`-files are basically 7-zip files with a special file name extension, they can not only compress the user files but also encode them, the data about the drive itself and other information needed is saved into `.ecd7db`-files which are just plaintext files with an alternate file name extension and with the purpose of databases.

### Is encryptcompressmydrive7 save?

It is save, but probably not uncrackable. Of course nothing is 'fully' save, but I will warn you if there is anything wrong. The encryption in encryptcompressmydrive7 is based on 7z encryption, which has shown great results for the past years. Of course you are advised to pick a strong password, this will make it lots harder to crack your data.

If you follow [this thread](), I can warn you on security updates, etc.

### How to contribute?

To contribute to the code, you just need to propose changes using a [pull request](https://help.github.com/articles/creating-a-pull-request/), I will add more specific info on this in the file [contribute.md](https://github.com/Marnix0810/encryptcompressmydrive7/blob/master/contribute.md).