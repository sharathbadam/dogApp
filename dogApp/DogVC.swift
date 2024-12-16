//
//  DogVC.swift
//  dogApp
//
//  Coding Exercise:
//  Display the dog label from the tableView.
//
//  Coding Exercise:
//  Load JSON to fetch image from URL to display:
//    e.g. passing "Husky" to this page
//    https://dog.ceo/api/breed/husky/images/random
//  This returns JSON, like: {"message":"https:\\images.dog.ceo/breeds/husky/n02110185_8162.jpg","status":"success"}
//  Show the image from the message URL in dogImage
//

import UIKit
import SDWebImage

// Struct to represent the JSON response from the Dog API
struct ImageData: Decodable {
    let message: String
    let status: String
}

// View Controller to display the dog breed label and fetch an image
class DogVC: UIViewController {
    @IBOutlet weak var dogImage: UIImageView!
    @IBOutlet weak var dogLabel: UILabel!
    let urlSession = URLSession.shared
    
    var dog: String = ""
    
    // Called when the view is loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        dogLabel.text = ""
        dogLabel.text = dog
        fetchImage()
    }
    
    // Method to configure the ViewController with a specific dog breed
    func configurFor(dogBreed: String) {
        dog = dogBreed
    }
    
    // Fetch the image URL for the specified dog breed and load it
    func fetchImage() {
        guard let dogUrl = URL(string:"https://dog.ceo/api/breed/"+"\(dog.lowercased())"+"/images/random") else {
            return
        }
        
        // Start a data task to fetch the image data
        urlSession.dataTask(with: dogUrl) {[weak self] data, response, error in
            if let error {
                print("Error in receiving image: ", error.localizedDescription)
                return
            }
            
            if let data {
                do {
                    let decoder = JSONDecoder()
                    let obj = try decoder.decode(ImageData.self, from: data)
                    
                    DispatchQueue.main.async { [weak self] in
                        guard let url = URL(string: obj.message) else {
                            return
                        }

                        self?.dogImage.sd_setImage(with: url)
                    }
                } catch {
                    print("Error in parsing data")
                }
            }
        }.resume()
    }
}
