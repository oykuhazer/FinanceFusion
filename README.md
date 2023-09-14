# FinanceFusion

## [Click here to watch the video of the app](https://www.youtube.com/watch?v=dH5LdpI1rrc)

The Finance Fusion application is an iOS application built on the foundation of the **MVC architecture**. It represents an iOS application where users can view exchange rates, perform currency conversions, and manage their financial assets. The application manages data exchange using powerful frameworks such as **URLSession,Firebase, RxSwift and Realm**. Leveraging the capabilities of Modern Swift, the Finance Fusion App effectively operates with **JSON data**. It utilizes the **Codable protocol** to model and parse the data.

## Folder Structure 

<p align="center">
  <img src="https://github.com/oykuhazer/FinanceFusion/assets/130215854/c1c45f8d-ef67-4abf-b0b2-09ed5a4cb126" alt="zyro-image" width="200" height="450" />
  <img src="https://github.com/oykuhazer/FinanceFusion/assets/130215854/75817cd5-9de0-4846-83f7-11650235a242" alt="zyro-image" width="200" height="450" />
    <img src="https://github.com/oykuhazer/FinanceFusion/assets/130215854/a11b11cb-3dbd-4604-9fe4-1a9c107d3708" alt="zyro-image" width="200" height="450" />
  </p>
  
## Authentication Screen

This page represents the identity verification screen. It contains buttons that allow users to sign up for or log into the application.

<p align="center">
  <img src="https://github.com/oykuhazer/FinanceFusion/assets/130215854/37e34e2b-8a9c-4fcd-bc1f-49ddbe03c72d" alt="zyro-image" width="200" height="450">
</p>

## Sign Up Bottom Sheet Screen

This page includes a bottom sheet where users can register and functions related to the registration process. Additionally, there is a manager class for registering users using Firebase.

<p align="center">
  <img src="https://github.com/oykuhazer/FinanceFusion/assets/130215854/f2e282a2-95b8-442c-b538-a8c903e16778" alt="zyro-image" width="200" height="450" />
  <img src="https://github.com/oykuhazer/FinanceFusion/assets/130215854/5010f4a0-3d72-42d5-8aa9-645147d77cb6" alt="zyro-image" width="200" height="450" />
  </p>

## Log In Bottom Sheet Screen

This page contains a Swift class that constitutes the login screen and provides user login using Firebase operation manager.

<p align="center">
  <img src="https://github.com/oykuhazer/FinanceFusion/assets/130215854/83fce8e2-d22b-4e8d-9d91-434a1696cd40" alt="zyro-image" width="200" height="450">
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
  <img src="https://github.com/oykuhazer/FinanceFusion/assets/130215854/69a63c9e-58c9-4433-a3ca-6ea02ad8340e" alt="zyro-image" width="200" height="450">
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
  <img src="https://github.com/oykuhazer/FinanceFusion/assets/130215854/35fab982-d388-4423-9c8c-4f7706ea8077" alt="zyro-image" width="200" height="450" />
   <img src="https://github.com/oykuhazer/FinanceFusion/assets/130215854/94c47d62-c47a-4e20-ae1f-e7e5ff33dd9f" alt="zyro-image" width="200" height="450" />
  <img src="https://github.com/oykuhazer/FinanceFusion/assets/130215854/caee17d6-d7d9-45e8-a0a1-cfc05e83c28c" alt="zyro-image" width="200" height="450" />
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
  <img src="https://github.com/oykuhazer/FinanceFusion/assets/130215854/c49579af-694f-4e74-9315-d3cf5f5973f4" alt="zyro-image" width="200" height="450" />
   <img src="https://github.com/oykuhazer/FinanceFusion/assets/130215854/b565c33f-6805-4cbd-9edb-b4583d4972d9" alt="zyro-image" width="200" height="450" />
   <img src="https://github.com/oykuhazer/FinanceFusion/assets/130215854/ca2f3ad4-fd0d-40cd-8a7c-f1003a4867f6" alt="zyro-image" width="200" height="450" />
  <img src="https://github.com/oykuhazer/FinanceFusion/assets/130215854/91bec4d1-f1b3-453d-9fbf-6fca81d7aae4" alt="zyro-image" width="200" height="450" />
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
  <img src="https://github.com/oykuhazer/FinanceFusion/assets/130215854/23c002b1-2314-49ac-97b3-2db1bd5a9261" alt="zyro-image" width="200" height="450" />
  <img src="https://github.com/oykuhazer/FinanceFusion/assets/130215854/a7a3b631-c43f-49c7-b57e-80a752475e4d" alt="zyro-image" width="200" height="450" />
  </p>

