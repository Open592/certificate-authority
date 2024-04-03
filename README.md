# Simulate Jagex Certificate

## What is this?

The goal of this repository is to emulate, as close as is possible, the certificate Jagex used during the 592 era. We do this so that we can create, and sign, jar files for use in our project.

Our goal is to emulate:

- Certificate chain issuer and owner details
- Validity periods
- Certificate algorithms
- Key sizes

And leave us with a keystore which can be used, along with `jarsigner` to sign our files.

## Usage

### Creating certificate chain

```
# To ensure `ca/` directory is setup correctly
make reset

make gen-root
make gen-intermediate
make gen-jagex
```

### Creating keystore

```
make gen-keystore
```

### Signing jar file

```
jarsigner -keystore keystore/jagex-keystore.jks -sigfile ZIGBERT <PATH>.jar jagex

# Confirm everything looks correct
jarsigner -verify -certs -verbose <PATH>.jar
```

## Results

The resulting certificates (intermediate CA, and Jagex) are identical, to the extent possible, to the certificates used to sign the `loader.jar` file distributed during the 592 game era.

- All certificate subject details are correct.
- All certificate NOTBEFORE and NOTAFTER are identical.
- MD is correct for both certificates
- Serial numbers are identical for both certificates.
- Key size is correct for both certificates.
- Extensions are identical for both certificates.
- Resulting PEM files are identical in size.
- ASN.1 is nearly identical.\*\*

\*\* Ordering and content is identical, though OpenSSL uses `UTF8STRING` instead of `PRINTABLESTRING` in some places. You can observe the differences by diffing the `our-*.txt`files versus`original-*.txt`files within`share/asn1`

![Screenshot of jarsigner verify](/share/images/jarsigner-verify.png)

## FAQ

### Will this allow for running modified files within the original unmodified applet viewer?

No, the original applet viewer validated the public keys, so certificates signed by this fake certificate authority will not pass that check. This is true for both the Thawte, and Jagex certificates.

Reference: [Deobfuscated applet viewer](https://github.com/Open592/jagexappletviewer/blob/master/src/main/java/com/open592/appletviewer/SignedFileValidator.java#L85-L115)

### Could you ever run 592 era remote jars in the original unmodified applet viewer?

No, the Jagex client was released after the 592 era (25th of May 2010) and is hard coded with a public key which differs from the one used to sign the 592 era jar files.

### What's the point?

To better understand how Jagex distributed their game.

### Is this secure?

No.

### Should I use this?

No.

## References

- [Creating a CA](https://www.phildev.net/ssl/creating_ca.html)
- [OpenSSL Certificate Authority](https://jamielinux.com/docs/openssl-certificate-authority/index.html)
