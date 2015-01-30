# Testing


As much of the JavaScript as possible should be tested using Jasmine. To test the modules, the tests need to be setup as follows:

```
describe("Color Picker", function() {
  it("Defaults to 'rust'", function() {
    expect(colorPicker.selectedColor()).toBe("rust");
  }
}
```

We use the [gulp-jasmine-phantom](https://github.com/dflynn15/gulp-jasmine-phantom) plugin to run our tests with either PhantomJS or minijasminenode2.

All unit tests will be placed in the [unit folder](/unit), and the integration tests will be placed in the [integration folder](/integration). If you need to add any fixtures for testing you can place them in the [fixtures folder](/fixtures).

Tests will run automatically through Gulp. You can also run them manually from the command line:

Unit Tests:
```
gulp tests-unit
```

Integration Tests (running with PhantomJS):
```
gulp tests-integration
```

Unit & Integration tests:
```
gulp test
```

Run all test in PhantomJS and generate coverage data.
```
gulp karma
```

To correctly run the tests please make sure that you have the following dependencies installed.


## Dependencies

Before you install `gulp-jasmine-phantom` please enusre that you have PhantomJS
installed on your machine. The plugin assumes that the `phantomjs` binary is
available in the PATH and executable from the command line.

**If you do not have `phantomjs` installed please install following [these directions.](http://phantomjs.org/download.html)

### Gulp plugin options

#### integration
Type: `boolean`
Default: false

Run your tests with `phantomjs`

#### keepRunner
Type: `boolean | string`
Default: false

Keep the `specRunner.html` file after build. If given a string, it will keep the runner at the string path.
