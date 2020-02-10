import UIKit
import CoreImage.CIFilterBuiltins
import CoreImage
import Photos

class PhotoFilterViewController: UIViewController {

    
    private var context = CIContext(options: nil)
    
    private var originalImage: UIImage? {
        didSet{
            updateImage()
        }
        
        
    }
    
	@IBOutlet weak var brightnessSlider: UISlider!
	@IBOutlet weak var contrastSlider: UISlider!
	@IBOutlet weak var saturationSlider: UISlider!
	@IBOutlet weak var imageView: UIImageView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
        
        originalImage = imageView.image
        
	}
    
    func updateImage(){
        if let originalImage = originalImage {
            imageView.image = filterImage(originalImage)
        } else {
            imageView.image = nil  // resetting the image to show no image
        }
    }
    
    
   func filterImage(_ image: UIImage) -> UIImage? {
    
    // UIImage -> CGImage -> CIImage
    guard let cgImage = image.cgImage else {return nil}

    let ciImage = CIImage(cgImage: cgImage)
    
    let filter = CIFilter.colorControls() // Like a recipe
    print(filter)
    print(filter.attributes)
    
    filter.inputImage = ciImage
    filter.brightness = brightnessSlider.value
    filter.contrast = contrastSlider.value
    filter.saturation = saturationSlider.value
    
    //CIImage -> CGImage -> UIImage
    guard let outputCImage = filter.outputImage else {return nil}
    
    // rendering the image (actually baking the cookies)
    guard let outputCGImage = context.createCGImage(outputCImage,
                        from: CGRect(origin: .zero, size: image.size))
                                    else {return nil}

    return UIImage(cgImage:outputCGImage)
    }
    
    
	// MARK: Actions
	
	@IBAction func choosePhotoButtonPressed(_ sender: Any) {
		// TODO: show the photo picker so we can choose on-device photos
		// UIImagePickerController + Delegate
	}
	
	@IBAction func savePhotoButtonPressed(_ sender: UIButton) {
		// TODO: Save to photo library
	}
	

	// MARK: Slider events
	
	@IBAction func brightnessChanged(_ sender: UISlider) {
        updateImage()
	}
	
	@IBAction func contrastChanged(_ sender: Any) {
        updateImage()
	}
	
	@IBAction func saturationChanged(_ sender: Any) {
        updateImage()
	}
}

