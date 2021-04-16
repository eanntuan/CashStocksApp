//
//  CashStocksAppUITests.swift
//  CashStocksAppUITests
//
//  Created by Eann Tuan on 4/15/21.
//

import XCTest

class CashStocksAppUITests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  ///
  /// Waits for the element to appear/enable, and then taps it
  ///
  func tap(_ element: XCUIElement, timeout: TimeInterval? = nil) {
    element.elementType == .staticText ? waitForElementToAppear(element, timeout: timeout)
      : waitForElementToEnable(element, timeout: timeout)
    element.tap()
  }
  
  ///
  /// Waits for a certain element to appear on the screen.
  ///
  func waitForElementToAppear(_ element: XCUIElement, timeout: TimeInterval? = nil) {
    waitForPredicate(element, predicate: NSPredicate(format: "exists == true"), timeout: timeout)
  }
  
  ///
  /// Waits for a certain element to disappear on the screen.
  ///
  func waitForElementToDisappear(_ element: XCUIElement, timeout: TimeInterval? = nil) {
    waitForPredicate(element, predicate: NSPredicate(format: "exists == false"), timeout: timeout)
  }
  
  ///
  /// Waits for a certain element to be enabled.
  ///
  func waitForElementToEnable(_ element: XCUIElement, timeout: TimeInterval? = nil) {
    waitForElementToAppear(element, timeout: timeout)
    waitForPredicate(element, predicate: NSPredicate(format: "hittable == true"), timeout: timeout)
  }
  
  ///
  /// Waits for a certain element to be disabled.
  ///
  func waitForElementToDisable(_ element: XCUIElement, timeout: TimeInterval? = nil) {
    waitForPredicate(element, predicate: NSPredicate(format: "hittable == false"), timeout: timeout)
  }
  
  ///
  /// Waits for label to equal specified value
  ///
  func waitForLabelToEqual(_ element: XCUIElement, value: String, timeout: TimeInterval? = nil) {
    waitForElementToAppear(element)
    waitForPredicate(element,
                     predicate: NSPredicate(format: "label == \"\(value)\""),
                     timeout: timeout)
  }
  
  ///
  ///
  ///
  func waitForPredicate(_ element: XCUIElement,
                        predicate: NSPredicate,
                        timeout: TimeInterval? = nil) {
    expectation(for: predicate, evaluatedWith: element, handler: nil)
    waitForExpectations(timeout: timeout ?? 60, handler: nil)
  }
  
  func testNormalStocks() throws {
    // UI tests must launch the application that they test.
    let app = XCUIApplication()
    app.launch()
    app.tables/*@START_MENU_TOKEN@*/.staticTexts["TWTR"]/*[[".cells.staticTexts[\"TWTR\"]",".staticTexts[\"TWTR\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    app.navigationBars["CashStocksApp.StockDetailsView"].buttons["Stocks"].tap()
    
    let stocksNavigationBar = app.navigationBars["Stocks"]
    stocksNavigationBar.searchFields["Search"].tap()
    stocksNavigationBar.buttons["Cancel"].tap()
  }
  
  func testSearchFunction() {
    let app = XCUIApplication()
    app.launch()
    waitForElementToAppear(app.tables/*@START_MENU_TOKEN@*/.staticTexts["TWTR"]/*[[".cells.staticTexts[\"TWTR\"]",".staticTexts[\"TWTR\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/)
    
    let stocksNavigationBar = app.navigationBars["Stocks"]
    stocksNavigationBar.searchFields["Search"].tap()

    let searchSearchField = stocksNavigationBar.searchFields["Search"]
    searchSearchField.tap()
    
    let jKey = app/*@START_MENU_TOKEN@*/.keys["J"]/*[[".keyboards.keys[\"J\"]",".keys[\"J\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
    jKey.tap()
    
    let oKey = app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
    oKey.tap()
    
    let hKey = app/*@START_MENU_TOKEN@*/.keys["h"]/*[[".keyboards.keys[\"h\"]",".keys[\"h\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
    hKey.tap()
    
    let nKey = app/*@START_MENU_TOKEN@*/.keys["n"]/*[[".keyboards.keys[\"n\"]",".keys[\"n\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
    nKey.tap()

    XCTAssertEqual(app.tables/*@START_MENU_TOKEN@*/.staticTexts["NameLabel-0"]/*[[".cells",".staticTexts[\"Johnson & Johnson\"]",".staticTexts[\"NameLabel-0\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.label, "Johnson & Johnson", "Search is broken")
    app.tables/*@START_MENU_TOKEN@*/.staticTexts["NameLabel-0"]/*[[".cells",".staticTexts[\"Johnson & Johnson\"]",".staticTexts[\"NameLabel-0\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
    app.navigationBars["CashStocksApp.StockDetailsView"].buttons["Stocks"].tap()
    stocksNavigationBar.buttons["Cancel"].tap()
  }
  
  func testStockDetails() {
    let app = XCUIApplication()
    app.launch()
    
    let tickerlabelStaticText = app.tables.children(matching: .cell).element(boundBy: 0).staticTexts["TickerLabel-0"]
    waitForElementToAppear(tickerlabelStaticText)
    tickerlabelStaticText.tap()
    
    XCTAssertEqual(app.staticTexts["TickerLabel"].label, "TWTR", "Ticker label is incorrect")
    XCTAssertEqual(app.staticTexts["NameLabel"].label, "Twitter, Inc.", "Name label is incorrect")
    XCTAssertEqual(app.staticTexts["PriceLabel"].label, "$38.00", "Price label is incorrect")
    XCTAssertEqual(app.staticTexts["QuantityLabel"].label, "Units: 1", "Quantity label is incorrect")
    XCTAssertEqual(app.staticTexts["TotalValueLabel"].label, "Total Value: USD 38", "Total value label is incorrect")
    XCTAssertEqual(app.staticTexts["InfoLabel"].label, "You're on your way to becoming RICH!!", "Info label is incorrect")
    
    let backButton = app.navigationBars["CashStocksApp.StockDetailsView"].buttons["Stocks"]
    backButton.tap()
  }
  
  func testEmptyStocks() throws {
    
  }
  
  func testLaunchPerformance() throws {
    if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
      // This measures how long it takes to launch your application.
      measure(metrics: [XCTApplicationLaunchMetric()]) {
        XCUIApplication().launch()
      }
    }
  }
}
