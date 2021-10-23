//
//  ImageView+URL.swift
//  Series
//
//  Created by Jose Mendez on 22/10/21.
//

import UIKit

extension UIImage
{
    /// Given a required height, returns a (rasterised) copy
    /// of the image, aspect-fitted to that height.
    
    func aspectFittedToHeight(_ newHeight: CGFloat) -> UIImage
    {
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: newSize)
        
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}

extension UIImageView {
    public func imageFromUrlAndSize(urlString: String) {
        self.backgroundColor = .black
        if var savedImage = getFile(filename: urlString){
            DispatchQueue.main.async {
                savedImage = savedImage.aspectFittedToHeight(self.frame.size.height)
                self.backgroundColor = .none
                self.image = savedImage
            }
        }
        else if let url = URL(string: urlString) {
            let request = URLRequest(url: url);
            let session = URLSession(configuration: URLSessionConfiguration.default)
            session.dataTask(with: request) { (data, response, error) -> Void in
                if let imageData = data as Data? {
                    DispatchQueue.main.async {
                        if var image = UIImage(data: imageData){
                            image = image.aspectFittedToHeight(self.frame.size.height)
                            _ = self.writeFile(filename: urlString, image: image)
                            self.backgroundColor = .none
                            self.image = image
                        }
                    };
                }
                }.resume()
        }
    }
    public func imageFromUrl(urlString: String) {
        self.backgroundColor = .black
        if let savedImage = getFile(filename: urlString){
            DispatchQueue.main.async {
                self.backgroundColor = .none
                self.image = savedImage
            }
        }
        else if let url = URL(string: urlString) {
            let request = URLRequest(url: url);
            let session = URLSession(configuration: URLSessionConfiguration.default)
            session.dataTask(with: request) { (data, response, error) -> Void in
                if let imageData = data as Data? {
                    DispatchQueue.main.async {
                        if let image = UIImage(data: imageData){
                            _ = self.writeFile(filename: urlString, image: image)
                            self.backgroundColor = .none
                            self.image = image
                        }
                    };
                }
                }.resume()
        }
    }
    
    private func writeFile(filename : String, image : UIImage) -> UIImage?{
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(filename.replacingOccurrences(of: "/", with: ""))
            if let data = image.pngData() {
                do{
                    try data.write(to: fileURL);
                    return image;
                }
                catch{
                    return nil;
                }
            }
        }
        
        return nil;
    }
    
    private func getFile(filename : String) -> UIImage?{
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(filename.replacingOccurrences(of: "/", with: ""));
            let image = UIImage(contentsOfFile: fileURL.path);
            return image;
        }
        
        return nil;
    }
}
