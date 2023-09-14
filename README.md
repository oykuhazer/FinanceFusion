# FinanceFusion

## [Click here to watch the video of the app](https://www.youtube.com/watch?v=dH5LdpI1rrc)

The Finance Fusion application is an iOS application built on the foundation of the **MVC architecture**. It represents an iOS application where users can view exchange rates, perform currency conversions, and manage their financial assets. The application manages data exchange using powerful frameworks such as **URLSession,Firebase, RxSwift and Realm**. Leveraging the capabilities of Modern Swift, the Finance Fusion App effectively operates with **JSON data**. It utilizes the **Codable protocol** to model and parse the data.

## Folder Structure 

<p align="center">
  <img src="https://github.com/oykuhazer/FinanceFusion/assets/130215854/99729fd0-7742-4d72-9f1d-6c62f43c3826" alt="zyro-image" width="200" height="450" />
  <img src="https://github.com/oykuhazer/FinanceFusion/assets/130215854/dcb57b93-78c2-45be-9586-0e61b1685d58" alt="zyro-image" width="200" height="450" />
    <img src="https://github.com/oykuhazer/FinanceFusion/assets/130215854/44954be1-3c2c-407d-8f18-3be73c2e26a8" alt="zyro-image" width="200" height="450" />
  </p>
  
## Authentication Screen

This page represents the identity verification screen. It contains buttons that allow users to sign up for or log into the application.

<p align="center">
  <img src="https://github.com/oykuhazer/FinanceFusion/assets/130215854/841729b3-5b0f-4dc5-87ce-4d12f781ffde" alt="zyro-image" width="200" height="450">
</p>

## Sign Up Bottom Sheet Screen

This page includes a bottom sheet where users can register and functions related to the registration process. Additionally, there is a manager class for registering users using Firebase.

<p align="center">
  <img src="https://github.com/oykuhazer/FinanceFusion/assets/130215854/38fa737e-be8b-459f-b658-e12d4e506c8a" alt="zyro-image" width="200" height="450" />
  <img src="https://github.com/oykuhazer/FinanceFusion/assets/130215854/288f15f1-2e3b-4344-a134-d6875ce092aa" alt="zyro-image" width="200" height="450" />
  </p>

## Log In Bottom Sheet Screen

This page contains a Swift class that constitutes the login screen and provides user login using Firebase operation manager.

<p align="center">
  <img src="https://github.com/oykuhazer/FinanceFusion/assets/130215854/075d5477-801a-4dc2-b096-777dfac83d66" alt="zyro-image" width="200" height="450">
</p>

## Main Currency Screen

This page displays exchange rates, allows users to change the selected currency, and performs currency conversion.

### Technologies Used
- RxSwift and RxCocoa: RxSwift and RxCocoa libraries are used to handle asynchronous data flow using Reactive Programming principles.
- URLSession: URLSession is used to make HTTP requests to an API for currency exchange rates.

### Functionalities
- View Exchange Rates: Users can horizontally view a list of different currency exchange rates. Each currency rate includes the country code and exchange rate.
- Select Currency: Users can select a currency rate from the list of currency rates.
- Currency Rate Details: Users can access details of a selected currency rate, and these details are displayed on another screen.
- Currency Rate Search: Users can search among currency rates using a search bar. Search results filter the currency rate list.
- Currency Conversion: Users can perform currency conversion between currency rates and view the converted amount.
Menu Navigation: The application allows transitioning from the main screen to two other sub-screens (Currency Conversion and Portfolio).

<p align="center">
  <img src="https://github.com/oykuhazer/FinanceFusion/assets/130215854/ca31982e-0ea7-451f-9082-b83254bada59" alt="zyro-image" width="200" height="450">
</p>

## Currency Detail Screen

This class is a view controller used to display the details of a specific currency pair and show historical exchange rates for this currency pair in both chart and table formats.

### Technologies Used
- URLSession: Used for making network requests. The CurrencyDetailNetworkManager class utilizes URLSession to fetch historical exchange rates from the Frankfurter API.
- Contains a button to add currency pairs to your portfolio using **Realm and RxSwift**.

### Functionalities
- Used to display data with UITableView.
- Used UISegmentedControl to select a time frame.
- Used LineChartView to display exchange rates as a graph.
- Used UIScrollView for user interface scrolling.
- Used DisposeBag to facilitate RxSwift usage.
- The setupUI function creates and configures the user interface.
- The displayPortfolioButtonTapped function is used to add a currency pair to the user's portfolio.
- The segmentValueChanged function is called when the user changes the time frame and is used to fetch new data.
- The fetchExchangeRatesForCurrencyPair function is used to retrieve exchange rates and works asynchronously with RxSwift.
- The CustomMarkerView class is used to display a custom marker on the graph.
- The CurrencyDetailNetworkManager class is used to fetch historical exchange rates from the Frankfurter API.


<p align="center">
  <img src="https://github.com/oykuhazer/FinanceFusion/assets/130215854/a48fdebd-04ed-43dc-b6a9-025f59dc9d8f" alt="zyro-image" width="200" height="450" />
   <img src="https://github.com/oykuhazer/FinanceFusion/assets/130215854/fd8ddf24-d93d-4ab7-af9d-0d62e7451888" alt="zyro-image" width="200" height="450" />
  <img src="https://github.com/oykuhazer/FinanceFusion/assets/130215854/d6b30842-4233-40b3-bde0-7d7004b02fff" alt="zyro-image" width="200" height="450" />
  </p>

## Converter Screen

On this page, currency conversion functionality is provided using RxSwift.

### Functionalities
- Asynchronous operations, user input, and data exchange are managed using RxSwift.
- Network Operations: URLSession is used to make requests to the API and fetch data, and RxSwift enhances the functionality of these operations. Additionally, currency exchange rates are obtained using the Frankfurter API.
- JSON Data Encoding and Decoding: JSONDecoder is used to retrieve and decode JSON data, allowing data from the API to be transformed into Swift objects.
- Currency Conversion: RxSwift observables are used to convert the amount entered by the user through selected currency rates. When currency rates are obtained or the currency pair is changed, the conversion process occurs automatically.
- User Interface (UI): User interface elements (textfield, label, button, etc.) are created and organized. Users can select "From Currency" and "To Currency" options and enter an amount for conversion. Additionally, the option to reverse the currency pair is provided.

<p align="center">
  <img src="https://github.com/oykuhazer/FinanceFusion/assets/130215854/132385d6-5980-4740-8bb0-fcd4b9f838ad" alt="zyro-image" width="200" height="450" />
   <img src="https://github.com/oykuhazer/FinanceFusion/assets/130215854/dfacc500-259b-4fed-b7c1-2c9b17a79eaf" alt="zyro-image" width="200" height="450" />
   <img src="https://github.com/oykuhazer/FinanceFusion/assets/130215854/51ad3676-4dc0-439f-b58e-45c0129709fb" alt="zyro-image" width="200" height="450" />
  </p>

## Portfolio Screen

This page allows for the management of a portfolio. It is created with RxSwift to store and view portfolio items using the Realm database. Users can save, view, and edit their financial assets such as selected currencies and currency pairs. Additionally, these assets are clickable to view their details.

### Technologies Used
- Portfolio items are stored and managed using **Realm**.
User interactions and data streams are managed using **RxSwift**.

### PortfolioService Class
- getAllPortfolioItems(): Retrieves all portfolio items from the Realm database and returns them as a collection.
- addPortfolioItem(selectedCurrency:currencyPair:): Adds a new portfolio item. It takes selected currency and currency pair as parameters and uses this information to create a new PortfolioItem and add it to the Realm database.
- deletePortfolioItem(_ item:): Deletes a specified portfolio item. This is used to remove the item from the database.

<p align="center">
  <img src="https://github.com/oykuhazer/FinanceFusion/assets/130215854/f05c4684-4b22-43d2-a419-3cc6505a4cdf" alt="zyro-image" width="200" height="450" />
  <img src="https://github.com/oykuhazer/FinanceFusion/assets/130215854/2bc7b386-3b81-4527-bf28-83e33b07c6de" alt="zyro-image" width="200" height="450" />
  </p>

