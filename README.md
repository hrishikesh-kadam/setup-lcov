# setup-lcov

Composite GitHub Action to setup [LCOV].


# Setup sources

Linux - <br/>
sudo apt-get -y install lcov

macOS - <br/>
brew install lcov

Windows - <br/>
choco install lcov


# Usage

```yml
steps:
  - name: Setup LCOV
    uses: hrishikesh-kadam/setup-lcov@v1
```


[LCOV]: https://github.com/linux-test-project/lcov
