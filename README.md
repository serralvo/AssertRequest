# Assert Request

[![CI Status](https://img.shields.io/travis/lucas1295santos/AssertRequest.svg?style=flat)](https://travis-ci.org/lucas1295santos/AssertRequest)
[![Version](https://img.shields.io/cocoapods/v/AssertRequest.svg?style=flat)](https://cocoapods.org/pods/AssertRequest)
[![License](https://img.shields.io/cocoapods/l/AssertRequest.svg?style=flat)](https://cocoapods.org/pods/AssertRequest)
[![Platform](https://img.shields.io/cocoapods/p/AssertRequest.svg?style=flat)](https://cocoapods.org/pods/AssertRequest)

Assert Request allows you to assert that your app is making the correct network request in a given situation, without any setup.

This framework works like a snapshot test. First, you run it on record mode, so every request made during test time is stored on disk. Later, when you disable recording, the framework will assert that matching requests will be made for that same test case.

During test time, no requests will be actually made to the web.

### Use cases

You might consider using Assert Request when:

- Testing an integrated scene. Like a test that asserts that pressing a button will request some data.
- Testing a highly coupled system. If you are making changes to a highly coupled legacy system, you may want to place some tests first, to ensure that you'll not break anything. Using Assert Request is a good option since you don't have to mock or inject anything up.
- Testing workers or data sources that will fetch something from the web.

### How it works

When an AssertRequest session is created, several methods related to making network requests are changed by the framework's counterpart using [method swizzling](https://abhimuralidharan.medium.com/method-swizzling-in-ios-swift-1f38edaf984f). So when your test calls something like `URLSession.shared.dataTask(with:completionHandler:)`, the call will be intercepted by the framework, so it can analyze the requests made and generate the test result. The actual method from `URLSession` will never be called, so no requests will be made.

Before using, it is important to understand what methods your app uses for making requests to the network. If it uses methods that are not swizzled by the framework, it will not work. Check out the session [Funcionalities](#funcionalities), to know what methods are supported. If your case is not covered, feel free to contribute! Check the session [Swizzling new methods](#swizzling-a-new-method) and [Contributing](#Contributing) to learn how to do it.

## Example

Consider that you want to test some function that look like this:

```swift
func foo() {
            let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(post)")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let retrievedData = String(data: data ?? Data(), encoding: .utf8) ?? ""
            DispatchQueue.main.async {
                self.resultTextView?.text = retrievedData
            }
        }
        task.resume()
}
```

Despite it being a pretty untestable function, with AssertRequest, it is pretty straight-forward to test it. On your test file, do the following:

```swift
import AssertRequest
import XCTest
@testable import MyAppModule

class Tests: XCTestCase {

    func myTest() {
        AssertRequest.startObserving(recording: true)

        ViewController().foo()

        AssertRequest.assert()
    }
}
```

This test will fail, showing you the following message: `Requests recorded! Set recording to false and run again`. After you get this message, you can check that a folder called `RequestSnapshot` was created on the same folder where the test resides. Inside that folder, you'll have a folder named after your test class, and inside it, a file named after your test case. This file is a `JSON` that looks like this:

```json
[
  {
    "url" : "https:\/\/jsonplaceholder.typicode.com\/posts\/1",
    "method" : "GET"
  }
]
```

The generated `JSON` describes the request made, by recording the URL, the HTTP method, body, and header.

After that, remove the recording configuration from the `startObserving` method, so the test can really run.

```swift
AssertRequest.startObserving()
```

Now your test should pass! If you change anything about the request, like changing the URL for example, this test will fail.

The `JSON` that describes the request, on a more complex example would look like this:

```json
[
  {
    "body" : "{\"body\":\"bar\",\"usedId\":99,\"title\":\"foo\"}",
    "method" : "POST",
    "headers" : {
      "Content-Type" : "application\/json"
    },
    "url" : "https:\/\/jsonplaceholder.typicode.com\/posts"
  }
]
```

As you can imagine from the `JSON` being an array of objects, a single test may make more than one request, and they will all be recorded.

```json
[
  {
    "url" : "https:\/\/jsonplaceholder.typicode.com\/posts\/1",
    "method" : "GET"
  },
  {
    "url" : "https:\/\/jsonplaceholder.typicode.com\/posts\/2",
    "method" : "GET"
  }
]
```

You can check the Example App on this repo to see the full example.

## Installation

AssertRequest is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AssertRequest'
```

## Funcionalities

- [x] URLSession dataTask
- [x] URLSession uploadTask

To see all the specific methods that are available check the [Swizzling](AssertRequest/Classes/Swizzling) folder.

## Roadmap

- [ ] Alamofire support
- [ ] Swift package manager distribution

## Contributing

This is an open-source project and everyone is welcome more than welcome to contribute! Just, fork this repo and open a Pull Request. Be wary that it is expected that your contributing code follows good practices, and improvements may be requested on code review. And feel free to create issues relating bugs, improvements, or feature requests.

If you want to add more methods to be swizzled, check out the session [Swizzling new methods](#swizzling-a-new-method).

## Swizzling a new method

To make the framework be able to intercept new methods, you'll have to implement a new `MethodSelector`. Take the `dataTask(with:)` method from `URLSession` as an example:

``` swift
struct URLSessionDataTaskWithRequest: MethodSelector {
    let urlSessionInstance = URLSession.shared

    // This is the method I want to intercept
    var originalMethod: Selector {
        #selector(urlSessionInstance.dataTask(with:) as (URLRequest) -> URLSessionDataTask)
    }

    // This is the method that will serve as an
    // interceptor. It is implemented bellow on the
    // URLSession extension.
    var swizzledMethod: Selector {
        #selector(urlSessionInstance._dataTask(with:) as (URLRequest) -> URLSessionDataTask)
    }
    
    let type: AnyClass = URLSession.self
}

extension URLSession {
    
    // This is the interceptor method. To make the request
    // being recorded by the framework, call the default
    // interceptor, sending the URLRequest passed to this
    // method. Don't forget to return and call completions.
    @objc open func _dataTask(with urlRequest: URLRequest) -> URLSessionDataTask {
        Session.default.interceptor.intercept(urlRequest: urlRequest)
        return Session.default.dummyDataTask
    }
}
```

After declaring your new `MethodSelector` and the interceptor method, just register this new `MethodSelector` at the `methodsToSwizzle` in `Swizzle.swift`.

```swift
    private let methodsToSwizzle: [MethodSelector] = [
        URLSessionDataTaskWithURLCompletion(),
        URLSessionDataTaskWithURL(),
        ...
        MyNewMethodSelector(),
    ]
```

## Author

Find me on Twitter: [@oliveira__lucas](https://twitter.com/oliveira__lucas)

Read my [engineering blog](https://www.lucasoliveira.tech/)

## License

AssertRequest is available under the MIT license. See the [LICENSE](LICENSE) file for more info.