
## Specs

•	UI: storyboard + AutoLayout
•	design pattern: MVVM
•	server request: AFNwtworking
•	JSON Parse: SwiftyJSON
•	image load: SDWebImage
•	UnitTest for Methods in ViewModel
•	cocoapods for 3rd party libraries

## Design pattern details

Model
•	Channel
•	Program


ViewModel
•	I use one ViewModel to handle data for two ViewControllers(ChannelsViewController is for Channel list, ProgramsViewController is for Program list), enumeration DataType to distinguish what data should I fetch.
•	In ViewModel, different datatype needs different fileId() and parseWithJSON(). 
•	startFetchDataFor(dataType) returns the ordered array for dataType, If it's channel, then returns ordered channels array, if it's program, then returns ordered programs array.
•	ViewModel also conforms CellRepresentable protocol, which returns custom UItableView configuration.


ViewController
•	set up ViewModel with dataType
•	conform UITableView datasource and delegate
