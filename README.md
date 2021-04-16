# Cash Stocks App
### Eann Tuan

## High Level Overview
I modeled my app off of Apple's Stock app in terms of the UI and functionality.

## Questions I would've asked
1. What behavior do we want to show if the user hasn't purchased any stock? Right now, I defaulted to displaying the total value as 0 and made the text green.
2. How often are we pulling data from the backend? Every second? Minute? 

## Refactors

1.  I'd like a way to launch the app with different URL's rather than manually inputing the api. I'd probably have a Config file just to centralize all of the environment variables.
2. When reloading the tableview data, I'd like to compare the incoming data with the current data and only reload if there are differences.
3. Decide if I need to keep track of the table state... may not be necessary.

## Code Organization

1. StocksTableViewController.swift - renders data for the main UI
2. StockDetailsViewController.swift - displays details for each Stock (would be an enhancement here)
3. Stock.swift - stores the structs for the Stock data models
4. Supporting Files - folder that contains Accessibility Identifiers, WebService, extensions etc

## Enhancements
1. I would ask product (and then backend) if we could have an endpoint that would provide the percentage difference so I could display the delta. Right now, that view is hidden, but I wanted to add it in there to show my intention. With additional time, I would consider storing the most recent stock data, then every time I fetch, I would compare the timestamps, then compare the price delta, do the calculation client-side, then display the percentage difference.
2. I wanted to use the currency field and do some sort of calculation of the stock's currency. Furthermore, I'd like to edit the order of the user's stock, have favorites, etc, but this would be a question I'd discuss with the backend in terms of how we want to sort and if there were an endpoint I could post once the user determines their desired order of viewing their stocks.
3. I'd also ask Product/Backend for a similar graph that Apple has, including the scrolling banner up top, the high's, low's, etc.
4. More color!!!
5. Add a scrolling banner up top like Apple has in their Stocks App.
6. Add notifications for the user to notify them when a stock prices goes up or down.


## Testing
1. I tested the very basic scenario of loading the portfolio.json. I ran out of time, but my plan was to test with the different endpoints (malformed and error) to ensure that the correct error messages displayed.
2. For future testing, I'd check that the stock price is being updated correctly.

