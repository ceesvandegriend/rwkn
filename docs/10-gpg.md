# GPG

Create temporary directory to use as GnuPG home directory.

```console
$ export GNUPGHOME=$(mktemp -d -t gnupg_$(date +%Y%m%d%H%M)_XXX)
$ echo ${GNUPGHOME}
/tmp/gnupg_202207281850_D6W
```

Create a `gpg.conf`.

```console
$ wget -O $GNUPGHOME/gpg.conf https://raw.githubusercontent.com/drduh/config/master/gpg.conf
--2022-07-28 18:51:51--  https://raw.githubusercontent.com/drduh/config/master/gpg.conf
Connecting to 192.168.128.3:3128... connected.
Proxy request sent, awaiting response... 200 OK
Length: 2101 (2.1K) [text/plain]
Saving to: ‘/tmp/gnupg_202207281850_D6W/gpg.conf’

/tmp/gnupg_20220728 100%[===================>]   2.05K  --.-KB/s    in 0s

2022-07-28 18:51:51 (11.1 MB/s) - ‘/tmp/gnupg_202207281850_D6W/gpg.conf’ saved [2101/2101]
```

```console
$ grep -ve "^#" $GNUPGHOME/gpg.conf
personal-cipher-preferences AES256 AES192 AES
personal-digest-preferences SHA512 SHA384 SHA256
personal-compress-preferences ZLIB BZIP2 ZIP Uncompressed
default-preference-list SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed
cert-digest-algo SHA512
s2k-digest-algo SHA512
s2k-cipher-algo AES256
charset utf-8
fixed-list-mode
no-comments
no-emit-version
no-greeting
keyid-format 0xlong
list-options show-uid-validity
verify-options show-uid-validity
with-fingerprint
require-cross-certification
no-symkey-cache
use-agent
throw-keyids
```

Create a secure password for the master key.

Note: not my real password!

```console
gpg --gen-random --armor 0 24
gpg: keybox '/tmp/gnupg_202207281850_D6W/pubring.kbx' created
zbsr7dX48lGdlCPq5jlG5ZTsFenffS/d
```

Generate the master key for *certification* only.

```console
$ gpg --expert --full-generate-key
Please select what kind of key you want:
   (1) RSA and RSA (default)
   (2) DSA and Elgamal
   (3) DSA (sign only)
   (4) RSA (sign only)
   (7) DSA (set your own capabilities)
   (8) RSA (set your own capabilities)
   (9) ECC and ECC
  (10) ECC (sign only)
  (11) ECC (set your own capabilities)
  (13) Existing key
  (14) Existing key from card
Your selection? 8

Possible actions for a RSA key: Sign Certify Encrypt Authenticate
Current allowed actions: Sign Certify Encrypt

   (S) Toggle the sign capability
   (E) Toggle the encrypt capability
   (A) Toggle the authenticate capability
   (Q) Finished

Your selection? s

Possible actions for a RSA key: Sign Certify Encrypt Authenticate
Current allowed actions: Certify Encrypt

   (S) Toggle the sign capability
   (E) Toggle the encrypt capability
   (A) Toggle the authenticate capability
   (Q) Finished

Your selection? e

Possible actions for a RSA key: Sign Certify Encrypt Authenticate
Current allowed actions: Certify

   (S) Toggle the sign capability
   (E) Toggle the encrypt capability
   (A) Toggle the authenticate capability
   (Q) Finished

Your selection? q
RSA keys may be between 1024 and 4096 bits long.
What keysize do you want? (3072) 4096
Requested keysize is 4096 bits
Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0) 0
Key does not expire at all
Is this correct? (y/N) y

GnuPG needs to construct a user ID to identify your key.

Real name: Cees van de Griend
Email address: cees@griend.eu
Comment:
You selected this USER-ID:
    "Cees van de Griend <cees@griend.eu>"

Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? o
We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.
gpg: /tmp/gnupg_202207281850_D6W/trustdb.gpg: trustdb created
gpg: key 0x5E405915C1A26E43 marked as ultimately trusted
gpg: directory '/tmp/gnupg_202207281850_D6W/openpgp-revocs.d' created
gpg: revocation certificate stored as '/tmp/gnupg_202207281850_D6W/openpgp-revocs.d/CDB90641C5092C745D94CE525E405915C1A26E43.rev'
public and secret key created and signed.

pub   rsa4096/0x5E405915C1A26E43 2022-07-28 [C]
      Key fingerprint = CDB9 0641 C509 2C74 5D94  CE52 5E40 5915 C1A2 6E43
uid                              Cees van de Griend <cees@griend.eu>
```

```console
$ export KEYID=0x5E405915C1A26E43
```

Add a JPEG photo to the master key.

```console
$ gpg --edit-key ${KEYID}
Secret key is available.

sec  rsa4096/0x5E405915C1A26E43
     created: 2022-07-28  expires: never       usage: C
     trust: ultimate      validity: ultimate
[ultimate] (1). Cees van de Griend <cees@griend.eu>

gpg> addphoto

Pick an image to use for your photo ID.  The image must be a JPEG file.
Remember that the image is stored within your public key.  If you use a
very large picture, your key will become very large as well!
Keeping the image close to 240x288 is a good size to use.

Enter JPEG filename for photo ID: images/cees.jpg
Is this photo correct (y/N/q)? y

sec  rsa4096/0x5E405915C1A26E43
     created: 2022-07-28  expires: never       usage: C
     trust: ultimate      validity: ultimate
[ultimate] (1). Cees van de Griend <cees@griend.eu>
[ unknown] (2)  [jpeg image of size 3096]

gpg> save
```

Add a subkey for *signing*.

```console
$ gpg --expert --edit-key ${KEYID}
Secret key is available.

sec  rsa4096/0x5E405915C1A26E43
     created: 2022-07-28  expires: never       usage: C
     trust: ultimate      validity: ultimate
[ultimate] (1). Cees van de Griend <cees@griend.eu>
[ultimate] (2)  [jpeg image of size 3096]

gpg> addkey
Please select what kind of key you want:
   (3) DSA (sign only)
   (4) RSA (sign only)
   (5) Elgamal (encrypt only)
   (6) RSA (encrypt only)
   (7) DSA (set your own capabilities)
   (8) RSA (set your own capabilities)
  (10) ECC (sign only)
  (11) ECC (set your own capabilities)
  (12) ECC (encrypt only)
  (13) Existing key
  (14) Existing key from card
Your selection? 4
RSA keys may be between 1024 and 4096 bits long.
What keysize do you want? (3072) 4096
Requested keysize is 4096 bits
Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0) 1y
Key expires at Fri 28 Jul 2023 07:05:30 PM CEST
Is this correct? (y/N) y
Really create? (y/N) y
We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.

sec  rsa4096/0x5E405915C1A26E43
     created: 2022-07-28  expires: never       usage: C
     trust: ultimate      validity: ultimate
ssb  rsa4096/0xA7A656B3C065CEFF
     created: 2022-07-28  expires: 2023-07-28  usage: S
[ultimate] (1). Cees van de Griend <cees@griend.eu>
[ultimate] (2)  [jpeg image of size 3096]

gpg> save
```

Add a subkey for *encryption*.

```console
$ gpg --expert --edit-key ${KEYID}
Secret key is available.

sec  rsa4096/0x5E405915C1A26E43
     created: 2022-07-28  expires: never       usage: C
     trust: ultimate      validity: ultimate
ssb  rsa4096/0xA7A656B3C065CEFF
     created: 2022-07-28  expires: 2023-07-28  usage: S
[ultimate] (1). Cees van de Griend <cees@griend.eu>
[ultimate] (2)  [jpeg image of size 3096]

gpg> addkey
Please select what kind of key you want:
   (3) DSA (sign only)
   (4) RSA (sign only)
   (5) Elgamal (encrypt only)
   (6) RSA (encrypt only)
   (7) DSA (set your own capabilities)
   (8) RSA (set your own capabilities)
  (10) ECC (sign only)
  (11) ECC (set your own capabilities)
  (12) ECC (encrypt only)
  (13) Existing key
  (14) Existing key from card
Your selection? 6
RSA keys may be between 1024 and 4096 bits long.
What keysize do you want? (3072) 4096
Requested keysize is 4096 bits
Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0) 1y
Key expires at Fri 28 Jul 2023 07:09:16 PM CEST
Is this correct? (y/N) y
Really create? (y/N) y
We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.

sec  rsa4096/0x5E405915C1A26E43
     created: 2022-07-28  expires: never       usage: C
     trust: ultimate      validity: ultimate
ssb  rsa4096/0xA7A656B3C065CEFF
     created: 2022-07-28  expires: 2023-07-28  usage: S
ssb  rsa4096/0x31B0D83F6B22B0DC
     created: 2022-07-28  expires: 2023-07-28  usage: E
[ultimate] (1). Cees van de Griend <cees@griend.eu>
[ultimate] (2)  [jpeg image of size 3096]

gpg> save
```

Add a subkey for *authentication* so we can use it as a public/private SSH key.

```console
$ gpg --expert --edit-key ${KEYID}
Secret key is available.

sec  rsa4096/0x5E405915C1A26E43
     created: 2022-07-28  expires: never       usage: C
     trust: ultimate      validity: ultimate
ssb  rsa4096/0xA7A656B3C065CEFF
     created: 2022-07-28  expires: 2023-07-28  usage: S
ssb  rsa4096/0x31B0D83F6B22B0DC
     created: 2022-07-28  expires: 2023-07-28  usage: E
[ultimate] (1). Cees van de Griend <cees@griend.eu>
[ultimate] (2)  [jpeg image of size 3096]

gpg> addkey
Please select what kind of key you want:
   (3) DSA (sign only)
   (4) RSA (sign only)
   (5) Elgamal (encrypt only)
   (6) RSA (encrypt only)
   (7) DSA (set your own capabilities)
   (8) RSA (set your own capabilities)
  (10) ECC (sign only)
  (11) ECC (set your own capabilities)
  (12) ECC (encrypt only)
  (13) Existing key
  (14) Existing key from card
Your selection? 8

Possible actions for a RSA key: Sign Encrypt Authenticate
Current allowed actions: Sign Encrypt

   (S) Toggle the sign capability
   (E) Toggle the encrypt capability
   (A) Toggle the authenticate capability
   (Q) Finished

Your selection? s

Possible actions for a RSA key: Sign Encrypt Authenticate
Current allowed actions: Encrypt

   (S) Toggle the sign capability
   (E) Toggle the encrypt capability
   (A) Toggle the authenticate capability
   (Q) Finished

Your selection? e

Possible actions for a RSA key: Sign Encrypt Authenticate
Current allowed actions:

   (S) Toggle the sign capability
   (E) Toggle the encrypt capability
   (A) Toggle the authenticate capability
   (Q) Finished

Your selection? a

Possible actions for a RSA key: Sign Encrypt Authenticate
Current allowed actions: Authenticate

   (S) Toggle the sign capability
   (E) Toggle the encrypt capability
   (A) Toggle the authenticate capability
   (Q) Finished

Your selection? q
RSA keys may be between 1024 and 4096 bits long.
What keysize do you want? (3072) 4096
Requested keysize is 4096 bits
Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0) 1y
Key expires at Fri 28 Jul 2023 07:11:22 PM CEST
Is this correct? (y/N) y
Really create? (y/N) y
We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.

sec  rsa4096/0x5E405915C1A26E43
     created: 2022-07-28  expires: never       usage: C
     trust: ultimate      validity: ultimate
ssb  rsa4096/0xA7A656B3C065CEFF
     created: 2022-07-28  expires: 2023-07-28  usage: S
ssb  rsa4096/0x31B0D83F6B22B0DC
     created: 2022-07-28  expires: 2023-07-28  usage: E
ssb  rsa4096/0xD59E628B324782E1
     created: 2022-07-28  expires: 2023-07-28  usage: A
[ultimate] (1). Cees van de Griend <cees@griend.eu>
[ultimate] (2)  [jpeg image of size 3096]

gpg> save
```

Add uid (email addresses) to the master key.
Edit the trust to *ultimate* and set the first uid (cees@griend.eu)
as *primary*.

```console
$ gpg --expert --edit-key ${KEYID}
Secret key is available.

sec  rsa4096/0x5E405915C1A26E43
     created: 2022-07-28  expires: never       usage: C
     trust: ultimate      validity: ultimate
ssb  rsa4096/0xA7A656B3C065CEFF
     created: 2022-07-28  expires: 2023-07-28  usage: S
ssb  rsa4096/0x31B0D83F6B22B0DC
     created: 2022-07-28  expires: 2023-07-28  usage: E
ssb  rsa4096/0xD59E628B324782E1
     created: 2022-07-28  expires: 2023-07-28  usage: A
[ultimate] (1). Cees van de Griend <cees@griend.eu>
[ultimate] (2)  [jpeg image of size 3096]

gpg> adduid
Real name: Cees van de Griend
Email address: c.vande.griend@gmail.com
Comment:
You selected this USER-ID:
    "Cees van de Griend <c.vande.griend@gmail.com>"

Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? o

sec  rsa4096/0x5E405915C1A26E43
     created: 2022-07-28  expires: never       usage: C
     trust: ultimate      validity: ultimate
ssb  rsa4096/0xA7A656B3C065CEFF
     created: 2022-07-28  expires: 2023-07-28  usage: S
ssb  rsa4096/0x31B0D83F6B22B0DC
     created: 2022-07-28  expires: 2023-07-28  usage: E
ssb  rsa4096/0xD59E628B324782E1
     created: 2022-07-28  expires: 2023-07-28  usage: A
[ultimate] (1)  Cees van de Griend <cees@griend.eu>
[ultimate] (2)  [jpeg image of size 3096]
[ unknown] (3). Cees van de Griend <c.vande.griend@gmail.com>

gpg> adduid
Real name: Cees van de Griend
Email address: cees.van.de.griend@xantara-it.nl
Comment:
You selected this USER-ID:
    "Cees van de Griend <cees.van.de.griend@xantara-it.nl>"

Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? o

sec  rsa4096/0x5E405915C1A26E43
     created: 2022-07-28  expires: never       usage: C
     trust: ultimate      validity: ultimate
ssb  rsa4096/0xA7A656B3C065CEFF
     created: 2022-07-28  expires: 2023-07-28  usage: S
ssb  rsa4096/0x31B0D83F6B22B0DC
     created: 2022-07-28  expires: 2023-07-28  usage: E
ssb  rsa4096/0xD59E628B324782E1
     created: 2022-07-28  expires: 2023-07-28  usage: A
[ultimate] (1)  Cees van de Griend <cees@griend.eu>
[ultimate] (2)  [jpeg image of size 3096]
[ unknown] (3)  Cees van de Griend <c.vande.griend@gmail.com>
[ unknown] (4). Cees van de Griend <cees.van.de.griend@xantara-it.nl>

gpg> adduid
Real name: Cees van de Griend
Email address: c.vandegriend@dhl.com
Comment:
You selected this USER-ID:
    "Cees van de Griend <c.vandegriend@dhl.com>"

Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? o

sec  rsa4096/0x5E405915C1A26E43
     created: 2022-07-28  expires: never       usage: C
     trust: ultimate      validity: ultimate
ssb  rsa4096/0xA7A656B3C065CEFF
     created: 2022-07-28  expires: 2023-07-28  usage: S
ssb  rsa4096/0x31B0D83F6B22B0DC
     created: 2022-07-28  expires: 2023-07-28  usage: E
ssb  rsa4096/0xD59E628B324782E1
     created: 2022-07-28  expires: 2023-07-28  usage: A
[ultimate] (1)  Cees van de Griend <cees@griend.eu>
[ultimate] (2)  [jpeg image of size 3096]
[ unknown] (3)  Cees van de Griend <c.vande.griend@gmail.com>
[ unknown] (4)  Cees van de Griend <cees.van.de.griend@xantara-it.nl>
[ unknown] (5). Cees van de Griend <c.vandegriend@dhl.com>

gpg> uid 3

sec  rsa4096/0x5E405915C1A26E43
     created: 2022-07-28  expires: never       usage: C
     trust: ultimate      validity: ultimate
ssb  rsa4096/0xA7A656B3C065CEFF
     created: 2022-07-28  expires: 2023-07-28  usage: S
ssb  rsa4096/0x31B0D83F6B22B0DC
     created: 2022-07-28  expires: 2023-07-28  usage: E
ssb  rsa4096/0xD59E628B324782E1
     created: 2022-07-28  expires: 2023-07-28  usage: A
[ultimate] (1)  Cees van de Griend <cees@griend.eu>
[ultimate] (2)  [jpeg image of size 3096]
[ unknown] (3)* Cees van de Griend <c.vande.griend@gmail.com>
[ unknown] (4)  Cees van de Griend <cees.van.de.griend@xantara-it.nl>
[ unknown] (5). Cees van de Griend <c.vandegriend@dhl.com>

gpg> trust
sec  rsa4096/0x5E405915C1A26E43
     created: 2022-07-28  expires: never       usage: C
     trust: ultimate      validity: ultimate
ssb  rsa4096/0xA7A656B3C065CEFF
     created: 2022-07-28  expires: 2023-07-28  usage: S
ssb  rsa4096/0x31B0D83F6B22B0DC
     created: 2022-07-28  expires: 2023-07-28  usage: E
ssb  rsa4096/0xD59E628B324782E1
     created: 2022-07-28  expires: 2023-07-28  usage: A
[ultimate] (1)  Cees van de Griend <cees@griend.eu>
[ultimate] (2)  [jpeg image of size 3096]
[ unknown] (3)* Cees van de Griend <c.vande.griend@gmail.com>
[ unknown] (4)  Cees van de Griend <cees.van.de.griend@xantara-it.nl>
[ unknown] (5). Cees van de Griend <c.vandegriend@dhl.com>

Please decide how far you trust this user to correctly verify other users' keys
(by looking at passports, checking fingerprints from different sources, etc.)

  1 = I don't know or won't say
  2 = I do NOT trust
  3 = I trust marginally
  4 = I trust fully
  5 = I trust ultimately
  m = back to the main menu

Your decision? 5
Do you really want to set this key to ultimate trust? (y/N) y

sec  rsa4096/0x5E405915C1A26E43
     created: 2022-07-28  expires: never       usage: C
     trust: ultimate      validity: ultimate
ssb  rsa4096/0xA7A656B3C065CEFF
     created: 2022-07-28  expires: 2023-07-28  usage: S
ssb  rsa4096/0x31B0D83F6B22B0DC
     created: 2022-07-28  expires: 2023-07-28  usage: E
ssb  rsa4096/0xD59E628B324782E1
     created: 2022-07-28  expires: 2023-07-28  usage: A
[ultimate] (1)  Cees van de Griend <cees@griend.eu>
[ultimate] (2)  [jpeg image of size 3096]
[ unknown] (3)* Cees van de Griend <c.vande.griend@gmail.com>
[ unknown] (4)  Cees van de Griend <cees.van.de.griend@xantara-it.nl>
[ unknown] (5). Cees van de Griend <c.vandegriend@dhl.com>

gpg> uid 3

sec  rsa4096/0x5E405915C1A26E43
     created: 2022-07-28  expires: never       usage: C
     trust: ultimate      validity: ultimate
ssb  rsa4096/0xA7A656B3C065CEFF
     created: 2022-07-28  expires: 2023-07-28  usage: S
ssb  rsa4096/0x31B0D83F6B22B0DC
     created: 2022-07-28  expires: 2023-07-28  usage: E
ssb  rsa4096/0xD59E628B324782E1
     created: 2022-07-28  expires: 2023-07-28  usage: A
[ultimate] (1)  Cees van de Griend <cees@griend.eu>
[ultimate] (2)  [jpeg image of size 3096]
[ unknown] (3)  Cees van de Griend <c.vande.griend@gmail.com>
[ unknown] (4)  Cees van de Griend <cees.van.de.griend@xantara-it.nl>
[ unknown] (5). Cees van de Griend <c.vandegriend@dhl.com>

gpg> uid 4

sec  rsa4096/0x5E405915C1A26E43
     created: 2022-07-28  expires: never       usage: C
     trust: ultimate      validity: ultimate
ssb  rsa4096/0xA7A656B3C065CEFF
     created: 2022-07-28  expires: 2023-07-28  usage: S
ssb  rsa4096/0x31B0D83F6B22B0DC
     created: 2022-07-28  expires: 2023-07-28  usage: E
ssb  rsa4096/0xD59E628B324782E1
     created: 2022-07-28  expires: 2023-07-28  usage: A
[ultimate] (1)  Cees van de Griend <cees@griend.eu>
[ultimate] (2)  [jpeg image of size 3096]
[ unknown] (3)  Cees van de Griend <c.vande.griend@gmail.com>
[ unknown] (4)* Cees van de Griend <cees.van.de.griend@xantara-it.nl>
[ unknown] (5). Cees van de Griend <c.vandegriend@dhl.com>

gpg> trust
sec  rsa4096/0x5E405915C1A26E43
     created: 2022-07-28  expires: never       usage: C
     trust: ultimate      validity: ultimate
ssb  rsa4096/0xA7A656B3C065CEFF
     created: 2022-07-28  expires: 2023-07-28  usage: S
ssb  rsa4096/0x31B0D83F6B22B0DC
     created: 2022-07-28  expires: 2023-07-28  usage: E
ssb  rsa4096/0xD59E628B324782E1
     created: 2022-07-28  expires: 2023-07-28  usage: A
[ultimate] (1)  Cees van de Griend <cees@griend.eu>
[ultimate] (2)  [jpeg image of size 3096]
[ unknown] (3)  Cees van de Griend <c.vande.griend@gmail.com>
[ unknown] (4)* Cees van de Griend <cees.van.de.griend@xantara-it.nl>
[ unknown] (5). Cees van de Griend <c.vandegriend@dhl.com>

Please decide how far you trust this user to correctly verify other users' keys
(by looking at passports, checking fingerprints from different sources, etc.)

  1 = I don't know or won't say
  2 = I do NOT trust
  3 = I trust marginally
  4 = I trust fully
  5 = I trust ultimately
  m = back to the main menu

Your decision? 5
Do you really want to set this key to ultimate trust? (y/N) y

sec  rsa4096/0x5E405915C1A26E43
     created: 2022-07-28  expires: never       usage: C
     trust: ultimate      validity: ultimate
ssb  rsa4096/0xA7A656B3C065CEFF
     created: 2022-07-28  expires: 2023-07-28  usage: S
ssb  rsa4096/0x31B0D83F6B22B0DC
     created: 2022-07-28  expires: 2023-07-28  usage: E
ssb  rsa4096/0xD59E628B324782E1
     created: 2022-07-28  expires: 2023-07-28  usage: A
[ultimate] (1)  Cees van de Griend <cees@griend.eu>
[ultimate] (2)  [jpeg image of size 3096]
[ unknown] (3)  Cees van de Griend <c.vande.griend@gmail.com>
[ unknown] (4)* Cees van de Griend <cees.van.de.griend@xantara-it.nl>
[ unknown] (5). Cees van de Griend <c.vandegriend@dhl.com>

gpg> uid 4

sec  rsa4096/0x5E405915C1A26E43
     created: 2022-07-28  expires: never       usage: C
     trust: ultimate      validity: ultimate
ssb  rsa4096/0xA7A656B3C065CEFF
     created: 2022-07-28  expires: 2023-07-28  usage: S
ssb  rsa4096/0x31B0D83F6B22B0DC
     created: 2022-07-28  expires: 2023-07-28  usage: E
ssb  rsa4096/0xD59E628B324782E1
     created: 2022-07-28  expires: 2023-07-28  usage: A
[ultimate] (1)  Cees van de Griend <cees@griend.eu>
[ultimate] (2)  [jpeg image of size 3096]
[ unknown] (3)  Cees van de Griend <c.vande.griend@gmail.com>
[ unknown] (4)  Cees van de Griend <cees.van.de.griend@xantara-it.nl>
[ unknown] (5). Cees van de Griend <c.vandegriend@dhl.com>

gpg> uid 5

sec  rsa4096/0x5E405915C1A26E43
     created: 2022-07-28  expires: never       usage: C
     trust: ultimate      validity: ultimate
ssb  rsa4096/0xA7A656B3C065CEFF
     created: 2022-07-28  expires: 2023-07-28  usage: S
ssb  rsa4096/0x31B0D83F6B22B0DC
     created: 2022-07-28  expires: 2023-07-28  usage: E
ssb  rsa4096/0xD59E628B324782E1
     created: 2022-07-28  expires: 2023-07-28  usage: A
[ultimate] (1)  Cees van de Griend <cees@griend.eu>
[ultimate] (2)  [jpeg image of size 3096]
[ unknown] (3)  Cees van de Griend <c.vande.griend@gmail.com>
[ unknown] (4)  Cees van de Griend <cees.van.de.griend@xantara-it.nl>
[ unknown] (5)* Cees van de Griend <c.vandegriend@dhl.com>

gpg> trust
sec  rsa4096/0x5E405915C1A26E43
     created: 2022-07-28  expires: never       usage: C
     trust: ultimate      validity: ultimate
ssb  rsa4096/0xA7A656B3C065CEFF
     created: 2022-07-28  expires: 2023-07-28  usage: S
ssb  rsa4096/0x31B0D83F6B22B0DC
     created: 2022-07-28  expires: 2023-07-28  usage: E
ssb  rsa4096/0xD59E628B324782E1
     created: 2022-07-28  expires: 2023-07-28  usage: A
[ultimate] (1)  Cees van de Griend <cees@griend.eu>
[ultimate] (2)  [jpeg image of size 3096]
[ unknown] (3)  Cees van de Griend <c.vande.griend@gmail.com>
[ unknown] (4)  Cees van de Griend <cees.van.de.griend@xantara-it.nl>
[ unknown] (5)* Cees van de Griend <c.vandegriend@dhl.com>

Please decide how far you trust this user to correctly verify other users' keys
(by looking at passports, checking fingerprints from different sources, etc.)

  1 = I don't know or won't say
  2 = I do NOT trust
  3 = I trust marginally
  4 = I trust fully
  5 = I trust ultimately
  m = back to the main menu

Your decision? 5
Do you really want to set this key to ultimate trust? (y/N) y

sec  rsa4096/0x5E405915C1A26E43
     created: 2022-07-28  expires: never       usage: C
     trust: ultimate      validity: ultimate
ssb  rsa4096/0xA7A656B3C065CEFF
     created: 2022-07-28  expires: 2023-07-28  usage: S
ssb  rsa4096/0x31B0D83F6B22B0DC
     created: 2022-07-28  expires: 2023-07-28  usage: E
ssb  rsa4096/0xD59E628B324782E1
     created: 2022-07-28  expires: 2023-07-28  usage: A
[ultimate] (1)  Cees van de Griend <cees@griend.eu>
[ultimate] (2)  [jpeg image of size 3096]
[ unknown] (3)  Cees van de Griend <c.vande.griend@gmail.com>
[ unknown] (4)  Cees van de Griend <cees.van.de.griend@xantara-it.nl>
[ unknown] (5)* Cees van de Griend <c.vandegriend@dhl.com>

gpg> uid 5

sec  rsa4096/0x5E405915C1A26E43
     created: 2022-07-28  expires: never       usage: C
     trust: ultimate      validity: ultimate
ssb  rsa4096/0xA7A656B3C065CEFF
     created: 2022-07-28  expires: 2023-07-28  usage: S
ssb  rsa4096/0x31B0D83F6B22B0DC
     created: 2022-07-28  expires: 2023-07-28  usage: E
ssb  rsa4096/0xD59E628B324782E1
     created: 2022-07-28  expires: 2023-07-28  usage: A
[ultimate] (1)  Cees van de Griend <cees@griend.eu>
[ultimate] (2)  [jpeg image of size 3096]
[ unknown] (3)  Cees van de Griend <c.vande.griend@gmail.com>
[ unknown] (4)  Cees van de Griend <cees.van.de.griend@xantara-it.nl>
[ unknown] (5). Cees van de Griend <c.vandegriend@dhl.com>

gpg> uid 1

sec  rsa4096/0x5E405915C1A26E43
     created: 2022-07-28  expires: never       usage: C
     trust: ultimate      validity: ultimate
ssb  rsa4096/0xA7A656B3C065CEFF
     created: 2022-07-28  expires: 2023-07-28  usage: S
ssb  rsa4096/0x31B0D83F6B22B0DC
     created: 2022-07-28  expires: 2023-07-28  usage: E
ssb  rsa4096/0xD59E628B324782E1
     created: 2022-07-28  expires: 2023-07-28  usage: A
[ultimate] (1)* Cees van de Griend <cees@griend.eu>
[ultimate] (2)  [jpeg image of size 3096]
[ unknown] (3)  Cees van de Griend <c.vande.griend@gmail.com>
[ unknown] (4)  Cees van de Griend <cees.van.de.griend@xantara-it.nl>
[ unknown] (5). Cees van de Griend <c.vandegriend@dhl.com>

gpg> primary

sec  rsa4096/0x5E405915C1A26E43
     created: 2022-07-28  expires: never       usage: C
     trust: ultimate      validity: ultimate
ssb  rsa4096/0xA7A656B3C065CEFF
     created: 2022-07-28  expires: 2023-07-28  usage: S
ssb  rsa4096/0x31B0D83F6B22B0DC
     created: 2022-07-28  expires: 2023-07-28  usage: E
ssb  rsa4096/0xD59E628B324782E1
     created: 2022-07-28  expires: 2023-07-28  usage: A
[ultimate] (1)* Cees van de Griend <cees@griend.eu>
[ultimate] (2)  [jpeg image of size 3096]
[ unknown] (3)  Cees van de Griend <c.vande.griend@gmail.com>
[ unknown] (4)  Cees van de Griend <cees.van.de.griend@xantara-it.nl>
[ unknown] (5)  Cees van de Griend <c.vandegriend@dhl.com>

gpg> save
```

Check the (secret) keys.

```console
$ gpg -K
/tmp/gnupg_202207281850_D6W/pubring.kbx
---------------------------------------
sec   rsa4096/0x5E405915C1A26E43 2022-07-28 [C]
      Key fingerprint = CDB9 0641 C509 2C74 5D94  CE52 5E40 5915 C1A2 6E43
uid                   [ultimate] Cees van de Griend <cees@griend.eu>
uid                   [ultimate] [jpeg image of size 3096]
uid                   [ultimate] Cees van de Griend <c.vande.griend@gmail.com>
uid                   [ultimate] Cees van de Griend <cees.van.de.griend@xantara-it.nl>
uid                   [ultimate] Cees van de Griend <c.vandegriend@dhl.com>
ssb   rsa4096/0xA7A656B3C065CEFF 2022-07-28 [S] [expires: 2023-07-28]
ssb   rsa4096/0x31B0D83F6B22B0DC 2022-07-28 [E] [expires: 2023-07-28]
ssb   rsa4096/0xD59E628B324782E1 2022-07-28 [A] [expires: 2023-07-28]

```

Backup the secret master key.

```console
$ gpg --armor --export-secret-keys $KEYID > $GNUPGHOME/master.key
```

Backup all the secret subkeys.

```console
$ gpg --armor --export-secret-subkeys $KEYID > $GNUPGHOME/sub.key
```

Generate a revoke certificate for the master key and store it in a very safe place.

```console
$ gpg --output $GNUPGHOME/revoke.asc --gen-revoke $KEYID

sec  rsa4096/0x5E405915C1A26E43 2022-07-28 Cees van de Griend <cees@griend.eu>

Create a revocation certificate for this key? (y/N) y
Please select the reason for the revocation:
  0 = No reason specified
  1 = Key has been compromised
  2 = Key is superseded
  3 = Key is no longer used
  Q = Cancel
(Probably you want to select 1 here)
Your decision? 0
Enter an optional description; end it with an empty line:
>
Reason for revocation: No reason specified
(No description given)
Is this okay? (y/N) y
ASCII armored output forced.
Revocation certificate created.

Please move it to a medium which you can hide away; if Mallory gets
access to this certificate he can use it to make your key unusable.
It is smart to print this certificate and store it away, just in case
your media become unreadable.  But have some caution:  The print system of
your machine might store the data and make it available to others!
```

Backup the temporary GPG home directory.

```console
$ tar cvzf ~/Projects/rwkn/tmp/gnupg_202207281850_D6W.tar.gz gnupg_202207281850_D6W
```

Export the public master and public subkeys.

```console
$ gpg --armor --export $KEYID | tee gpg-$KEYID-$(date +%F).asc
-----BEGIN PGP PUBLIC KEY BLOCK-----

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
t8rSNW6e
=Wp5e
-----END PGP PUBLIC KEY BLOCK-----
```

Send the public keys to the keyservers.

```console
$ gpg --send-key $KEYID
gpg: sending key 0x5E405915C1A26E43 to hkps://keys.openpgp.org
$ gpg --keyserver pgp.mit.edu --send-key $KEYID
gpg: sending key 0x5E405915C1A26E43 to hkp://pgp.mit.edu
$ gpg --keyserver keys.gnupg.net --send-key $KEYID
gpg: sending key 0x5E405915C1A26E43 to hkp://hkps.pool.sks-keyservers.net
gpg: keyserver send failed: Server indicated a failure
gpg: keyserver send failed: Server indicated a failure
$ gpg --keyserver hkps://keyserver.ubuntu.com:443 --send-key $KEYID
gpg: sending key 0x5E405915C1A26E43 to hkps://keyserver.ubuntu.com:443
```
