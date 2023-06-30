# RA Assignment


## Design pattern or Architecture

This project uses the Model-View-ViewModel (MVVM) architecture. 

The model represents the data and business logic of the application. In this project, the Facility, FacilityOption and Exclusion structs serve as models. FacilitiesViewModel (ViewModel) manages data, business logic, and API client interaction in this solution and acts as the intermediary between the view and model. SwiftUI renders the Views (FacilitiesView, FacilityItemView, FacilityOptionView) and binds them to the ViewModel's data. 

Async/await is used to fetch facility data asynchronously in the retrieveData() method.

MVVM architecture pattern makes the components easy to maintain and test. 

## Libraries used

No 3rd party libraries were used in this project.
