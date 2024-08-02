# setup-lcov

Composite GitHub Action to setup [LCOV].

# Setup sources

<table>
  <tr>
    <th>OS</th>
    <th>Stable</th>
    <th>HEAD</th>
    <th>Tag / Branch</th>
  </tr>
  <tr>
    <td>Linux</td>
    <td>
      <a href="https://launchpad.net/ubuntu/+source/lcov">apt-get</a>
    </td>
    <td colspan=2 align="center">make install</td>
  </tr>
  <tr>
    <td>macOS</td>
    <td colspan=2 align="center">
      <a href="https://formulae.brew.sh/formula/lcov">brew</a>
    </td>
    <td>make install</td>
  </tr>
  <tr>
    <td>Windows</td>
    <td>
      <a href="https://community.chocolatey.org/packages/lcov">choco</a>
      <sup>1</sup>
    </td>
    <td colspan=2 align="center">Not supported</td>
  </tr>
</table>

<sup>1</sup> choco lcov package version is outdated and on 1.15.alpha0w

# Usage

## Stable version

```yml
steps:
  - name: Setup LCOV
    uses: hrishikesh-kadam/setup-lcov@v1
```

## HEAD of Default Branch of [LCOV]

```yml
steps:
  - name: Setup LCOV
    uses: hrishikesh-kadam/setup-lcov@v1
    with:
      ref: HEAD
```

## Tag / Branch of [LCOV]

```yml
steps:
  - name: Setup LCOV
    uses: hrishikesh-kadam/setup-lcov@v1
    with:
      ref: v2.1
```


[LCOV]: https://github.com/linux-test-project/lcov
