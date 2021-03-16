# Assert Request

[![CI Status](https://img.shields.io/travis/lucas1295santos/AssertRequest.svg?style=flat)](https://travis-ci.org/lucas1295santos/AssertRequest)
[![Version](https://img.shields.io/cocoapods/v/AssertRequest.svg?style=flat)](https://cocoapods.org/pods/AssertRequest)
[![License](https://img.shields.io/cocoapods/l/AssertRequest.svg?style=flat)](https://cocoapods.org/pods/AssertRequest)
[![Platform](https://img.shields.io/cocoapods/p/AssertRequest.svg?style=flat)](https://cocoapods.org/pods/AssertRequest)

Assert Request allows you to assert that your app is making the correct network request in a given situation, without any setup.

This framework works like a snapshot test. First, you run it on record mode, so every request made during test time is stored in disk. Later, when you disable recording, the framework will assert that matching requests will be made for that same test case.

During test time, no requests will be actually made to the web. (Considering that your use match the [Funcionalities](##Funcionalities))

### Use cases

You might consider using Assert Request when:

- Testing an integrated scene, as to test that pressing a button will request some data.
- Testing a highly coupled system. If you are making changes to a highly coupled legacy system, you may want to place some tests first, as to ensure that you'll not break anything. Using Assert Request is a good option since you don't have to mock or inject anything up.
- Testing workers or dataSources that will fetch something from the web.

## Example

## Installation

AssertRequest is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AssertRequest'
```

## Funcionalities

- [x] URLDataTask support

## Roadmap

- [ ] Alamofire support
- [ ] Swift package manager distribution

## Author


Find me on twitter: [@oliveira__lucas](https://twitter.com/oliveira__lucas)

Read my [engineering blog](https://www.lucasoliveira.tech/)

## License

AssertRequest is available under the MIT license. See the LICENSE file for more info.
