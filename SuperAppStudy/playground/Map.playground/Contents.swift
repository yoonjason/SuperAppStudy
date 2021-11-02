import UIKit

var greeting = "Hello, playground"


let ageString: String? = "10"

let result = ageString.flatMap(Int.init)

print(result)

//UIEvent -> tableView(indexPath) -> Model -> URL -> Data -> Model -> ViewModel -> View


struct MyModel: Decodable {
    let name: String
}

let myLabel = UILabel()

if let data = UserDefaults.standard.data(forKey: "my_data_key") {
    if let model = try? JSONDecoder().decode(MyModel.self, from: data) {
        let welcomeMessage = "Hello \(model.name)"
        myLabel.text = welcomeMessage
    }
}

//map과 flatmap 활용

let welcomeMessage = UserDefaults.standard.data(forKey: "my_data_key")
    .flatMap {
        try? JSONDecoder().decode(MyModel.self, from: $0)
    }
    .map(\.name)
    .map{ "Hello \($0) "}

myLabel.text = welcomeMessage
