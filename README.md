# Skyscanner app challenge
Skyscanner demo app for iPhone (iOS 12.1+).

![screenshot_1](assets/screenshot_1_resized.png)
![screenshot_2](assets/screenshot_2_resized.png)
![screenshot_3](assets/screenshot_3_resized.png)
![screenshot_4](assets/screenshot_4_resized.png)
![screenshot_5](assets/screenshot_5_resized.png)

## Usage
- Clone the repo.
- Paste your own Skyscanner API key in `FlightSearchAPIClient.Defaults.apiKey`:

```
struct FlightSearchAPIClient {

    private enum Defaults {
        …
        static let apiKey = "YourAPIKey"
        …
    }
```

- Open the workspace file `Skscnnr.xcworkspace` with Xcode 10.1 and run the app.

## Tools/Libraries/SDKs used
- [Alamofire](https://github.com/Alamofire/Alamofire)
- [AlamofireImage](https://github.com/Alamofire/AlamofireImage)
- [RxSwift](https://github.com/ReactiveX/RxSwift)
- [NVActivityIndicatorView](https://github.com/ninjaprox/NVActivityIndicatorView)

## Author
Luis Valdés Cuesta

[luis (DOT) valdes (DOT) cuesta (AT) gmail.com]()

## License
(The MIT License)

Copyright (c) 2019 Luis Valdés Cuesta

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.