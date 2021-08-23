//
//  TextView.swift
//  UIParts
//
//  Created by Ryo Hanma on 2021/08/24.
//

import SwiftUI

struct TextView: UIViewRepresentable{
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        DispatchQueue.main.async {
            let attributedString = NSAttributedString.parseHTMLtoText(text: text)
            view.attributedText = attributedString
        }

        view.isEditable = false
        view.isSelectable = true
        view.isUserInteractionEnabled = true

        return view
    }
    
    func updateUIView(_ textView: UITextView, context: Context) {
    }
}

extension NSAttributedString {
    static func parseHTMLtoText(text: String) -> NSAttributedString {
        let encodeData = text.data(using: String.Encoding.unicode, allowLossyConversion: true)
        
        var attributedString =  NSAttributedString()
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType:
                NSAttributedString.DocumentType.html]
              
        if let encodeData = encodeData {
            do {
                attributedString = try NSAttributedString(
                    data: encodeData,
                    options: options,
                    documentAttributes: nil
                )
            } catch {
                print("Couldn't load \(encodeData)\n")
            }
        }

        return attributedString
    }
}

struct TextView_Previews: PreviewProvider {
    static let text: String = "<h2>Title</h2><p>text</p><p>text</p>"
    
    static var previews: some View {
        Group {
            TextView(text: .constant(text))
        }
    }
}

