# SSH

```console
$ gpg -k --with-keygrip
/home/cees/.gnupg/pubring.kbx
-----------------------------
pub   rsa4096/0xDA87E80D6294BE9B 2011-01-05 [SC]
      Key fingerprint = DF9B 9C49 EAA9 2984 3258  9D76 DA87 E80D 6294 BE9B
      Keygrip = 852FD92A9FCA53BDE42B7FFD9AA27DA91DABA7D4
uid                   [ unknown] Debian CD signing key <debian-cd@lists.debian.org>
sub   rsa4096/0x642A5AC311CD9819 2011-01-05 [E]
      Keygrip = 1AECF99382DE641B212B5FA643E220564FDB44CD

pub   rsa4096/0x5E405915C1A26E43 2022-07-28 [C]
      Key fingerprint = CDB9 0641 C509 2C74 5D94  CE52 5E40 5915 C1A2 6E43
      Keygrip = 8C05CA14213DF9E5992647CF5F55BC71A01077C5
uid                   [ultimate] Cees van de Griend <cees@griend.eu>
uid                   [ultimate] [jpeg image of size 3096]
uid                   [ultimate] Cees van de Griend <c.vande.griend@gmail.com>
uid                   [ultimate] Cees van de Griend <cees.van.de.griend@xantara-it.nl>
uid                   [ultimate] Cees van de Griend <c.vandegriend@dhl.com>
sub   rsa4096/0xA7A656B3C065CEFF 2022-07-28 [S] [expires: 2023-07-28]
      Keygrip = 795FEB2A46513EC05113B4AF81BBF9E9FB88B63A
sub   rsa4096/0x31B0D83F6B22B0DC 2022-07-28 [E] [expires: 2023-07-28]
      Keygrip = 97870EDB0F5F487855A69281570DDA9E8094A727
sub   rsa4096/0xD59E628B324782E1 2022-07-28 [A] [expires: 2023-07-28]
      Keygrip = 966FEF98516BF2F041E88BA8C2EB59C35FB05FC1

```

```console
$ echo 966FEF98516BF2F041E88BA8C2EB59C35FB05FC1 > ~/.gnupg/sshcontrol
$ ssh-add -L
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDoQwOWd2+bxV6TaaRtQhI5uMES/oM4hMWjsGVhfMeX19RIbfgy4qNapiPvciQeJTmvmltRGCzWLJ+3DMjWe09pP1cX5JPMhb2vH1v8qmJZ3LtC/BupfVrDcg8/C/u3p48APUC8wb2m9Fa7oAgrQSQuMpjJBIfiR1TiinEb8bsEvJpTzZvbf1/KvosKRTmlx6n3aGIlp1Ly6mJZU0hyleXi4MuTZXJIvqfHnngUO5i/AkSoCgnwNkL3XGhR7eS8YRy25OijCCA3mT3RJ2/tQiyuXWvEnuyhmQ23i6S7d4x6O1qdx1D3xKemVxKOzkNOXCvttjtMKRdmZ+cnx8fw5bnQx+O+s/05x499udy8LBLF+UPXUyATyn6ok8thhsQ1p0d3ZCWrwoNCaKDaug13oVLdNLrdiEgUYmkLKJA0015QlOVmWodXduawsqJAkKnH45L5iRfm4WYkWDp/x4FwXe5D0fN8kQLjZHKrxdvlO2gVuIsYqk8ifzi0sIRkx0n2kcvjAZWzAbDY6CWLcu9bqAXxSfr28IcIW/CLjVyv7M5x8sSKOo/5XxWrK2PHdF5S7o37ZDtG6ItMUqUPYGA9SJIhnHGb/CSKfKZtDe6ODka2A49MzE91alIKc22OeP5APaF23Rx9f88YcEJK05fvr0Xlx6peHLvqPm2Ku9r0UspWcw== (none)
$ gpg --export-ssh-key 0xD59E628B324782E1
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDoQwOWd2+bxV6TaaRtQhI5uMES/oM4hMWjsGVhfMeX19RIbfgy4qNapiPvciQeJTmvmltRGCzWLJ+3DMjWe09pP1cX5JPMhb2vH1v8qmJZ3LtC/BupfVrDcg8/C/u3p48APUC8wb2m9Fa7oAgrQSQuMpjJBIfiR1TiinEb8bsEvJpTzZvbf1/KvosKRTmlx6n3aGIlp1Ly6mJZU0hyleXi4MuTZXJIvqfHnngUO5i/AkSoCgnwNkL3XGhR7eS8YRy25OijCCA3mT3RJ2/tQiyuXWvEnuyhmQ23i6S7d4x6O1qdx1D3xKemVxKOzkNOXCvttjtMKRdmZ+cnx8fw5bnQx+O+s/05x499udy8LBLF+UPXUyATyn6ok8thhsQ1p0d3ZCWrwoNCaKDaug13oVLdNLrdiEgUYmkLKJA0015QlOVmWodXduawsqJAkKnH45L5iRfm4WYkWDp/x4FwXe5D0fN8kQLjZHKrxdvlO2gVuIsYqk8ifzi0sIRkx0n2kcvjAZWzAbDY6CWLcu9bqAXxSfr28IcIW/CLjVyv7M5x8sSKOo/5XxWrK2PHdF5S7o37ZDtG6ItMUqUPYGA9SJIhnHGb/CSKfKZtDe6ODka2A49MzE91alIKc22OeP5APaF23Rx9f88YcEJK05fvr0Xlx6peHLvqPm2Ku9r0UspWcw== openpgp:0x324782E1
```

ToDo: configure gpg-agent.conf

ToDo: source gpg.xsh
