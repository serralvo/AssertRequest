import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resultTextView: UITextView?
    
    @IBAction func didTouchMakeDataRequest() {
        requestPost("1") { (data, response, error) in
            let retrievedData = String(data: data ?? Data(), encoding: .utf8) ?? ""
            DispatchQueue.main.async {
                self.resultTextView?.text = retrievedData
            }
        }
    }
    
    @IBAction func didTouchMakeChainedRequests() {
        requestPost("1") { (data, response, error) in
            let firstPostRetrievedData = String(data: data ?? Data(), encoding: .utf8) ?? ""
            self.requestPost("2") { (data, response, error) in
                let secondPostRetievedData = String(data: data ?? Data(), encoding: .utf8) ?? ""
                DispatchQueue.main.async {
                    self.resultTextView?.text = "[\(firstPostRetrievedData),\n\(secondPostRetievedData)]"
                }
            }
        }
    }
    
    @IBAction func didTouchClear() {
        resultTextView?.text = "Request result will appear here"
    }
    
    private func requestPost(_ post: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(post)")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            completionHandler(data, response, error)
        }

        task.resume()
    }
}
