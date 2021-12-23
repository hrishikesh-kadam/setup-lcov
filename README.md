# setup-lcov

Composite GitHub Action to setup [LCOV].


# Setup sources

Linux - <br/>
sudo apt-get -y install lcov

macOS - <br/>
brew install lcov <br/>
https://formulae.brew.sh/formula/lcov

Windows - <br/>
choco install lcov <br/>
https://community.chocolatey.org/packages/lcov <br/>
https://github.com/jgonzalezdr/lcov


# Usage

```yml
steps:
  - name: Setup LCOV
    uses: hrishikesh-kadam/setup-lcov@v1
```


[LCOV]: https://github.com/linux-test-project/lcov
