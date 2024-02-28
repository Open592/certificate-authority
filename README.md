# Certificate Authority

## What is this?

This is an experiment to emulate, as close as is possible, the certificates Jagex used during the 592 era. This will result in us having a fake certificate authority which we can use to sign the remote jar files validated by the applet viewer.

### Will this allow for running modified files within the original unmodified applet viewer?

No, the original applet viewer validated the public keys, so certificates signed by this fake certificate authority will not pass that check. This is true for both the Thawte, and Jagex certificates.

Reference: [Deobfuscated applet viewer](https://github.com/Open592/jagexappletviewer/blob/master/src/main/java/com/open592/appletviewer/SignedFileValidator.java#L85-L115)

## What's the point?

To better understand how Jagex distributed their game.

## Is this secure?

No.

## Should I use this?

No.

## References

- [OpenSSL Certificate Authority](https://jamielinux.com/docs/openssl-certificate-authority/index.html)
