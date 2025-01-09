//
//  ViewController.swift
//  SeeFood
//
//  Created by Isaac Urbina on 1/9/25.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController {

	// MARK: - IBOutlets
	
	@IBOutlet weak var imageView: UIImageView!
	
	// MARK: - Objects/variables
	
	let imagePicker = UIImagePickerController()
	
	// MARK: - UIViewController
	
    override func viewDidLoad() {
        super.viewDidLoad()
		imagePicker.delegate = self
		//imagePicker.sourceType = .camera
		imagePicker.sourceType = .photoLibrary
		imagePicker.allowsEditing = false
		imageView.contentMode = .scaleAspectFit
    }
	
	// MARK: - IBActions
	
	@IBAction func cameraTapped(_ sender:  UIBarButtonItem) {
		present(imagePicker, animated: true, completion: nil )
	}
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	// MARK: - UIImagePickerControllerDelegate
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		guard let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
			print("Could not get image")
			return
		}
		imageView.image = userPickedImage
		guard let ciImage = CIImage(image: userPickedImage) else {
			fatalError("Could not convert UIImage into CIImage")
		}
		detect(image: ciImage)
		imagePicker.dismiss(animated: true, completion: nil)
	}
	
	private func detect(image: CIImage) {
		guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
			fatalError("Loading CoreML model failed")
		}
		let request = VNCoreMLRequest(model: model) { request, error in
			guard let results = request.results as? [VNClassificationObservation] else {
				fatalError("Model failed to process image")
			}
			print(results )
		}
		let handler = VNImageRequestHandler(ciImage: image)
		
		do {
			try handler.perform([request])
		} catch {
			print("Error performing request: \(error)")
		}
	}
}
