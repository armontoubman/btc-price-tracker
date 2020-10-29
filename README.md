# btc-price-tracker

Simple GUI to track the price of Bitcoin. Made with Common Lisp. Demonstrates the use of [qtools](https://github.com/Shinmera/qtools).

## Usage

Get [roswell](https://www.github.com/roswell/roswell/). Clone btc-price-tracker to .roswell/local-projects/.

```bash
$ ros run
* (ql:quickload :btc-price-tracker)
* (btc-price-tracker:main)
```

A square window should pop up that shows the BTC/USD price every five seconds.

To build an executable:
```bash
* (asdf:operate :build-op :btc-price-tracker :force T)
```

## License
[MIT](https://choosealicense.com/licenses/mit/)
