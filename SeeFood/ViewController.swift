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
    }
	
	// MARK: - IBActions
	
	@IBAction func cameraTapped(_ sender:  UIBarButtonItem) {
		present(imagePicker, animated: true, completion: nil )
	}
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	// MARK: - UIImagePickerControllerDelegate
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
		imageView.image = image
		imagePicker.dismiss(animated: true, completion: nil)
	}
}
