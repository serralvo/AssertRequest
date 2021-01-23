import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resultTextView: UITextView!

    let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
    
    @IBAction func didTouchMakeDataRequest() {
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            let retrievedData = String(data: data!, encoding: .utf8)!
            DispatchQueue.main.async {
                self.resultTextView.text = retrievedData
            }
        }

        task.resume()
    }
    
    @IBAction func didTouchClear() {
        resultTextView.text = "Request result will appear here"
    }
}
