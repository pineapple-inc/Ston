//
//  EditInvoiceViewController.swift
//  eventCal
//
//  Created by Harsh_Dev on 2019-07-28.
//  Copyright © 2019 FitFi. All rights reserved.
//

import UIKit
import EventKit
import PDFGenerator
class EditInvoiceViewController: UIViewController {

    var currentEvent:EKEvent!
    var fileName:String = ""
    @IBAction func getInvoice(_ sender: UIButton) {
        generatePDF()
       // sharePDF()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
//    func sharePDF()
//    {
//        let str = "invoice"
//        fileName = getDocumentsDirectory().appendingPathComponent("sample1.pdf")
//        
//        do {
//            try str.write(toFile: fileName, atomically: true, encoding: String.Encoding.utf8)
//
//            let fileURL = 
//            
//            let objectsToShare = [fileURL]
//            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
//            
//            self.present(activityVC, animated: true, completion: nil)
//            
//        } catch {
//            print("cannot write file")
//            // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
//        }
//    }
    func generatePDF() {
        let v1 = UIScrollView(frame: CGRect(x: 0.0,y: 0, width: 100.0, height: 100.0))
        let v2 = UIView(frame: CGRect(x: 0.0,y: 0, width: 100.0, height: 200.0))
        let v3 = UIView(frame: CGRect(x: 0.0,y: 0, width: 100.0, height: 200.0))
        v1.backgroundColor = .red
        v1.contentSize = CGSize(width: 100.0, height: 200.0)
        v2.backgroundColor = .green
        v3.backgroundColor = .blue
        
        let dst = URL(fileURLWithPath: NSTemporaryDirectory().appending("sample1.pdf"))
        // outputs as Data
        do {
            let data = try PDFGenerator.generated(by: [v1, v2, v3])
            try data.write(to: dst, options: .atomic)
            
        } catch (let error) {
            print(error)
        }
        
        // writes to Disk directly.
        do {
            try PDFGenerator.generate([v1, v2, v3], to: dst)
            // let str = "invoice"
            //  fileName = getDocumentsDirectory().appendingPathComponent("sample1.pdf")
            
            do {
                //            try str.write(toFile: fileName, atomically: true, encoding: String.Encoding.utf8)
                //
                let fileURL = dst
                
                let objectsToShare = [fileURL]
                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                
                self.present(activityVC, animated: true, completion: nil)
                
            } catch {
                print("cannot write file")
                // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
            }
        } catch (let error) {
            print(error)
        }
        
    }
    func readDataFromCSV(fileName:String, fileType: String){
        guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
            else {
                return
        }
        do {
            
//            var contents = try String(contentsOfFile: filepath, encoding: .utf8)
//            contents = cleanRows(file: contents)
            
        } catch {
            print("File Read Error for file \(filepath)")
            return
        }
    }
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory as NSString
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
